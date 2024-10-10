import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class converttoadress extends StatefulWidget {
  const converttoadress({super.key});

  @override
  State<converttoadress> createState() => _converttoadressState();
}

class _converttoadressState extends State<converttoadress> {
  String adress = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('google map'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(adress),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                List<Placemark> placemarks =
                    await placemarkFromCoordinates(52.2165157, 6.9437819);
                setState(() {
                  adress = placemarks.first.toString() +
                      placemarks.single.toString() +
                      placemarks.reversed.last.locality.toString();
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('convert'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
