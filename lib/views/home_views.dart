import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studentbus/datamodel/user_location.dart';
import 'package:studentbus/views/map_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    UserLocation userLocation = Provider.of<UserLocation>(context);
    UpdateFireLatLng(userLocation);


    return Scaffold(
      body: Stack(
        children: <Widget>[



          Center(

          child: Text(
              'Location: Lat:${userLocation.lat}, Long: ${userLocation.lon}'),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MapView()));
      },),
    );
  }


  Future<void> UpdateFireLatLng( UserLocation userLocation) async {
    try {
      await Firestore.instance.collection('Bus').document("GPS").collection("GPS").document("latlng").updateData({
        'lat': userLocation.lat,
        'lon': userLocation.lon
      });
    } catch (e) {
      print(e.toString());
    }
  }
}