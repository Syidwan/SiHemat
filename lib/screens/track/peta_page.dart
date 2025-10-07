// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PetaPage extends StatefulWidget {
//   const PetaPage({super.key});

//   @override
//   State<PetaPage> createState() => PetaPageState();
// }

// class PetaPageState extends State<PetaPage> {
//   static const ptLen = LatLng(-6.949411068037853, 107.61946062733901);

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//           body: GoogleMap(
//         initialCameraPosition: const CameraPosition(
//           target: ptLen,
//           zoom: 13,
//         ),
//         markers: {
//           const Marker(
//             markerId: MarkerId('sourceLocation'),
//             icon: BitmapDescriptor.defaultMarker,
//             position: ptLen,
//           )
//         },
//       ));
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PetaPage extends StatefulWidget {
  const PetaPage({super.key});

  @override
  State<PetaPage> createState() => _PetaPageState();
}

class _PetaPageState extends State<PetaPage> {
  static const LatLng ptLen = LatLng(-6.949411068037853, 107.61946062733901);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: ptLen,
          initialZoom: 15,
        ),
        children: [
          // Layer peta dasar (OpenStreetMap)
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.sihemat',
          ),

          // Marker lokasi
          MarkerLayer(
            markers: [
              Marker(
                point: ptLen,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: [
                  LatLng(-6.2, 106.8),
                  LatLng(-6.25, 106.82),
                ],
                color: Colors.blue,
                strokeWidth: 4,
              ),
            ],
          )
        ],
      ),
    );
  }
}
