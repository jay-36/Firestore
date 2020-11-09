import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class stg extends StatefulWidget {
  @override
  _stgState createState() => _stgState();
}

class _stgState extends State<stg> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: new AppBar(
        title: new Text("WallPaper"),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) => new Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueAccent
          ),
            child: FadeInImage(
              image: new NetworkImage("https://i.pinimg.com/originals/7b/3d/fe/7b3dfedb05221a208068492f6aa951e2.jpg"),
              fit: BoxFit.cover,
              placeholder: new AssetImage("assets/logo.png"),
            ),
        ),
        staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, index.isEven ? 2 : 3),
        mainAxisSpacing:10,
        crossAxisSpacing: 10,
      )

    );
  }
}
