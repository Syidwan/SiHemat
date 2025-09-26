import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../models/vehicle.dart';
import 'under_construction_screen.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;

  VehicleDetailScreen({required this.vehicle});

  final List<MenuItem> menuItems = [
    MenuItem(
      id: 'vehicle',
      icon: Icons.directions_car,
      label: 'Kendaraan',
      color: Colors.red,
    ),
    MenuItem(
      id: 'maintenance',
      icon: Icons.build,
      label: 'Cek Perawatan',
      color: Colors.red,
    ),
    MenuItem(
      id: 'speedometer',
      icon: Icons.speed,
      label: 'Speedometer',
      color: Colors.red,
    ),
    MenuItem(
      id: 'reports',
      icon: Icons.receipt_long,
      label: 'Cek Pajak',
      color: Colors.orange,
    ),
    MenuItem(
      id: 'troubleshoot',
      icon: Icons.build_circle,
      label: 'Troubleshoot',
      color: Colors.orange,
    ),
    MenuItem(
      id: 'bantuan',
      icon: Icons.headset_mic,
      label: 'Bantuan',
      color: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  vehicle.emoji,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo,',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Nirwan Rasyid Ridlo',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Vehicle Display
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                Text(
                  vehicle.emoji,
                  style: TextStyle(fontSize: 80),
                ),
                SizedBox(height: 16),
                Text(
                  vehicle.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  vehicle.type,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          
          // Menu Grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnderConstructionScreen(
                            title: item.label,
                          ),
                        ),
                      );
                    },
                    child: Container(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: item.color,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(
                              item.icon,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              label: 'Track',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Akun',
            ),
          ],
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey.shade400,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}