import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Completer<GoogleMapController> _controoler = Completer();

  static final CameraPosition gmap = CameraPosition(
    target: LatLng(28.704060, 77.102493),
    zoom: 14,
  );

  List<Marker> _marker = [];
  List<Marker> list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.704060, 77.102493),
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('HomePage'),
        ),
        body: GoogleMap(
          initialCameraPosition: gmap,
          onMapCreated: (GoogleMapController controler) {
            _controoler.complete(controler);
          },
          markers: Set<Marker>.of(_marker),
        ),
      ),
    );
  }
}
