import 'package:firestore/Shopping/Model/cartitem.dart';

class AddItemActions{
  final CartItem item;
  AddItemActions(this.item);
}

class ToggleStateItemActions{
  final CartItem item;
  ToggleStateItemActions(this.item);
}

class DeleteItemActions{
  final CartItem item;
  DeleteItemActions(this.item);
}