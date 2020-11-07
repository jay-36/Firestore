import 'package:firestore/Shopping/Model/cartitem.dart';
import 'package:firestore/Shopping/Redux/actions.dart';
import 'package:firestore/Shopping/Redux/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ShoppingItem extends StatefulWidget {

  final CartItem item;

  const ShoppingItem({Key key, this.item}) : super(key: key);

  @override
  _ShoppingItemState createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<List<CartItem>,OnItemDelete>(
      converter: (store) => (itemName) => store.dispatch(DeleteItemActions(widget.item)),
      builder: (context,callback)=>Dismissible(
        onDismissed: (_){
          setState(() {
            callback(widget.item.name);
          });
        },
          key: Key(widget.item.name),
          child: StoreConnector<List<CartItem>,OnToggleStateAction>(
            converter: (store) => (item) => store.dispatch(ToggleStateItemActions(item)),
            builder: (context,callback)=> ListTile(
              title: Text(widget.item.name),
              leading: Checkbox(
                value: widget.item.checked,
                onChanged: (value){
                  setState(() {
                    callback(CartItem(name: widget.item.name,checked: value));
                  });
                }),
            ),
          )
      ),
    );

  }
}

typedef OnToggleStateAction = Function(CartItem item);
typedef OnItemDelete = Function(String item);
