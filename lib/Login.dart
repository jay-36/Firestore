import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore/Shopping/Model/cartitem.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'Shopping/shoppingcart.dart';
import 'file:///D:/Flutter_project/firestore/lib/WallPaper/Wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';


class LoginPage extends StatefulWidget {

  final DevToolsStore<List<CartItem>> store;
  LoginPage({Key key,this.store}) : super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState(store);
}

class _LoginPageState extends State<LoginPage> {

  final DevToolsStore<List<CartItem>> store;
  _LoginPageState(this.store);


  String myText = null;
  StreamSubscription<DocumentSnapshot> _streamSubscription;

  final DocumentReference documentReference = Firestore.instance.collection("MyData").document("Info");

  void _add(){
    Map<String,String> data = <String,String>{
      "name":"Jay Lukhi",
      "description": "Flutter Developer"};
    documentReference.setData(data).whenComplete((){print("Document Added");}).catchError((e)=>print(e));
  }

  void _update(){
    Map<String,String> data = <String,String>{
      "name":"Jay Lukhi Vinubhai",
      "description": "Flutter Developer / Android Developer"};
    documentReference.update(data).whenComplete((){print("Document Update");}).catchError((e)=>print(e));
  }

  void _delete(){
    documentReference.delete().whenComplete((){print("Document Deleted");}).catchError((e)=>print(e));
  }

  void _fetch(){
    documentReference.get().then((snapshot){
      if(snapshot.exists){
        setState(() {
          myText = snapshot.data()['description'];
        });
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamSubscription = documentReference.snapshots().listen((snapshot) {
      if(snapshot.exists){
        setState(() {
          myText = snapshot.data()['description'];
        });
      }
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamSubscription?.cancel();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Signed Out");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  signInWithGoogle().then((result) {
                    if (result != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return FirstScreen();
                          },
                        ),
                      );
                    }
                  });
                },
                child: Text("Sign in with Google"),
              ),
              RaisedButton(
                onPressed: _add,
                child: Text('Add'),
              ),
              RaisedButton(
                onPressed: _update,
                child: Text('Update'),
              ),
              RaisedButton(
                onPressed: _delete,
                child: Text('Delete'),
              ),
              RaisedButton(
                onPressed: _fetch,
                child: Text('Fetch'),
              ),
              RaisedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => WallPaper(),));},
                child: Text('WallPaper'),
              ),
              RaisedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCart(store:store),));},
                child: Text('Shopping'),
              ),
              myText==null?Container():Text(myText),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Signed Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
            child:  RaisedButton(
              elevation: 5,
              color: Colors.deepPurple,
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
              },
              child: Text('Sign Out', style: TextStyle(fontSize: 25, color: Colors.white),),
            )
        ),
      ),
    );
  }
}