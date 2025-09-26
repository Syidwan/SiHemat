import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import 'vehicle_detail_screen.dart';

class VehicleSelectionScreen extends StatelessWidget {
  final List<Vehicle> vehicles = [
    Vehicle(id: 1, name: 'Motor Trail', emoji: '🏍️', type: 'Trail Bike'),
    Vehicle(id: 2, name: 'Motor Sport', emoji: '🏍️', type: 'Sport Bike'),
    Vehicle(id: 3, name: 'Motor Matic', emoji: '🛵', type: 'Automatic'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Pilih Kendaraan'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: vehicles.map((vehicle) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehicleDetailScreen(vehicle: vehicle),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      vehicle.emoji,
                      style: TextStyle(fontSize: 48),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehicle.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            vehicle.type,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}