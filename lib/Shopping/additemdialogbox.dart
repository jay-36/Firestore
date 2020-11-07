import 'package:firestore/Shopping/Model/cartitem.dart';
import 'package:firestore/Shopping/Redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AddItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {

  String itemName;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<List<CartItem>, OnItemAddCallBack>(
      converter: (store) =>
          (itemName) => store.dispatch(AddItemActions(CartItem(name:itemName,checked: false))),
      builder: (context,callback){
        return AlertDialog(
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                callback(itemName);
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            )
          ],
          contentPadding: EdgeInsets.all(10.0),
          content: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Ex. iPhone",
                      labelText: "Enter Name"
                  ),
                  onChanged: (value){
                    setState(() {
                      itemName = value;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


typedef OnItemAddCallBack = Function(String itemName);