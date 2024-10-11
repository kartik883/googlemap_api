import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Currentlocation extends StatefulWidget {
  const Currentlocation({super.key});

  @override
  State<Currentlocation> createState() => _CurrentlocationState();
}

class _CurrentlocationState extends State<Currentlocation> {
  Completer<GoogleMapController> _controoler = Completer();

  static final CameraPosition _kpos = CameraPosition(
    target: LatLng(28.704060, 77.102493),
    zoom: 14,
  );

  List<Marker> _marker = [];
  List<Marker> list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.704060, 77.102493),
      infoWindow: InfoWindow(title: 'my locaation'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(28.696369, 77.091537),
      infoWindow: InfoWindow(title: 'mangolpuri'),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(35.689487, 139.691711),
      infoWindow: InfoWindow(title: 'tokyo'),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(list);
  }

  Future<Position> getlocation() async {
    await Geolocator.requestPermission()
        .then((onValue) {})
        .onError((Object error, StackTrace stackTrace) {
      print('error');
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('HomePage'),
        ),
        body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _kpos,
            onMapCreated: (GoogleMapController controler) {
              _controoler.complete(controler);
            },
            markers: Set<Marker>.of(_marker),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getlocation().then((onValue) async {
              print(onValue.longitude.toString() + onValue.latitude.toString());

              _marker.add(Marker(
                  markerId: MarkerId('5'),
                  position: LatLng(onValue.longitude, onValue.latitude),
                  infoWindow: InfoWindow(
                    title: 'my current location',
                  )));

              CameraPosition current = CameraPosition(
                target: LatLng(onValue.longitude, onValue.latitude),
                zoom: 14,
              );
              final GoogleMapController controller = await _controoler.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(current));
            });
          },
          child: Icon(Icons.location_on),
        ),
      ),
    );
  }
}
