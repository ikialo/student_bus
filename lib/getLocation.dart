import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentbus/services/locationService.dart';
import 'package:studentbus/views/home_views.dart';

import 'datamodel/user_location.dart';



class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  @override
  Widget build(BuildContext context) {

    var documentReference = Firestore.instance
        .collection('Bus')
        .document("GPS")
        .collection("GPS")
    .document("latlng");
       // .document(DateTime.now().millisecondsSinceEpoch.toString());

    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        {
          'lat': -9.4543403,
          'lon': 147.1846744,

        },
      );
    });

    return StreamProvider<UserLocation>(
        create: (context) => LocationService().locationStream,
        child: MaterialApp(title: 'Flutter Demo', home: HomeView()));
  }

}
