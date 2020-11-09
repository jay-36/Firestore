import 'package:flutter/material.dart';

class ExpandableList extends StatelessWidget {
  final list = List.generate(5, (i) => "Item ${i+1}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expandable List"),),
      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (context,i){
        return ExpansionTile(
          title: Text("Header ${i+1}",style: TextStyle(fontSize: 35),),
          children: list.map((val) => ListTile(title: Text(val),)).toList()
        );
      }),
    );
  }
}
