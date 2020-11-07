import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'file:///D:/Flutter_project/firestore/lib/WallPaper/FullScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const String testDevice = "";

class WallPaper extends StatefulWidget {
  @override
  _WallPaperState createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['WallPaper', 'Wall', 'amoled'],
    birthday: DateTime.now(),
    childDirected: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        adUnitId: BannerAd.testAdUnitId,
        listener: (MobileAdEvent event) {
          print("banner Event : $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        targetingInfo: targetingInfo,
        adUnitId: InterstitialAd.testAdUnitId,
        listener: (MobileAdEvent event) {
          print("Interstitial Event : $event");
        });
  }

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference =
      Firestore.instance.collection("WallPaper");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("WallPaper"),
      ),
      body: wallpapersList != null
          ? new StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 4,
              itemCount: wallpapersList.length,
              itemBuilder: (context, i) {
                String imgPath = wallpapersList[i].data()['url'];
                return new Material(
                  elevation: 10.0,
                  borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                  child: new InkWell(
                    onTap: () {
                      createInterstitialAd()..load()..show();
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new FullScreenImagePage(imgPath)));
                    },
                    child: new Hero(
                      tag: imgPath,
                      child: new FadeInImage(
                        image: new NetworkImage(imgPath),
                        fit: BoxFit.cover,
                        placeholder: new AssetImage("assets/loading2.gif"),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  new StaggeredTile.count(2, i.isEven ? 2 : 3),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            )
          : new Center(
              child: new CircularProgressIndicator(),
            ),
    );
  }
}
