import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class StickyList extends StatelessWidget {
  final list = List.generate(5, (i) => "Item ${i+1}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sticky List"),),
      body: ListView.builder(itemBuilder: (context,i){
        return StickyHeader(
          header: Container(child: Text("Header $i",style: TextStyle(fontSize: 35)),padding: EdgeInsets.all(8.0),),
          content: Column(children: list.map((val) => ListTile(title: Text(val),)).toList(),),
        );
      })
    );
  }
}
