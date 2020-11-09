import 'package:firestore/Drawer/TwoPanel.dart';
import 'package:flutter/material.dart';

class BackDropPage extends StatefulWidget {
  @override
  _BackDropPageState createState() => _BackDropPageState();
}

class _BackDropPageState extends State<BackDropPage> with SingleTickerProviderStateMixin{

  AnimationController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(milliseconds: 300),value: 1.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  bool get isPanelVisible{
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0.0,
        title: Text("BackDropPage"),
        leading: IconButton(
          onPressed: (){
            controller.fling(velocity: isPanelVisible ? - 1.0 : 1.0 );
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: controller.view,
          ),
        ),
      ),
      body: TwoPanels(controller: controller,),
    );
  }
}
