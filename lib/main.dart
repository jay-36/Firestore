import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore/Login.dart';
import 'package:firestore/Shopping/Redux/reducers.dart';
import 'package:firestore/Shopping/shoppingcart.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'Shopping/Model/cartitem.dart';
import 'file:///D:/Flutter_project/firestore/lib/WallPaper/Wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

void main() async {
  final store = new DevToolsStore<List<CartItem>>(cartItemReducers,initialState:List());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(store: store,));
}

class MyApp extends StatelessWidget {

  final DevToolsStore<List<CartItem>> store;
  MyApp({Key key,this.store}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Login',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginPage(store:store),
      ),
    );
  }
}

