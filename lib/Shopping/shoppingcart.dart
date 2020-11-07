import 'package:firestore/Shopping/Model/cartitem.dart';
import 'package:firestore/Shopping/additemdialogbox.dart';
import 'package:firestore/Shopping/shoppingitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

class ShoppingCart extends StatelessWidget {

  final DevToolsStore<List<CartItem>> store;
  ShoppingCart({Key key,this.store}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: ReduxDevTools(store),
      body: ShoppingList(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_opendialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
_opendialog(BuildContext contxet){
  return showDialog(context: contxet,builder: (context)=>AddItemDialog());
}

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<List<CartItem>,List<CartItem>>(
      converter: (store) => store.state,
      builder: (context,list)=>ListView.builder(
        itemBuilder: (context,i)=>ShoppingItem(item:list[i]),
        itemCount: list.length,
      ),
    );
  }
}
