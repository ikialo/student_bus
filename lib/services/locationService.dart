
import 'dart:async';

import 'package:location/location.dart';
import 'package:studentbus/datamodel/location_data.dart';
import 'package:studentbus/datamodel/user_location.dart';

class LocationService {
  // Keep track of current Location
  UserLocation _currentLocation;
  LocationDataBus _locationDataBus;
  Location location = Location();
  // Continuously emit location updates
  StreamController<UserLocation> _locationController =
  StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {

            _locationController.add(UserLocation(
              locationData.latitude,
              locationData.longitude,
            ));
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
         userLocation.latitude,
        userLocation.longitude,
      );
    } catch (e) {
      print('Could not get the location: $e');
    }

    return _currentLocation;
  }
}