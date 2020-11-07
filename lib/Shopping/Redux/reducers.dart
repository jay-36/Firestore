import 'package:firestore/Shopping/Model/cartitem.dart';
import 'package:firestore/Shopping/Redux/actions.dart';

List<CartItem> cartItemReducers(List<CartItem> items, dynamic action) {
  if (action is AddItemActions) {
    return addItem(items, action);
  } else if (action is ToggleStateItemActions) {
    return toggleState(items, action);
  } else if (action is DeleteItemActions) {
    return deleteItem(items, action);
  }
  return items;
}

List<CartItem> addItem(List<CartItem> items, AddItemActions action) {
  return List.from(items)..add(action.item);
}

List<CartItem> toggleState(
    List<CartItem> items, ToggleStateItemActions action) {
  List<CartItem> newItems =
      items.map((item) => item.name == action.item.name ? action.item : item).toList();
  return newItems;
}

List<CartItem> deleteItem(List<CartItem> items, DeleteItemActions action) {
  return List.from(items)..remove(action.item);
}
