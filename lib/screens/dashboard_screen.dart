import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import 'vehicle_selection_screen.dart';
import 'under_construction_screen.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';


final List<String> newsImages = [
  'assets/images/news1.png',
]; 

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<MenuItem> menuItems = [
    MenuItem(
      id: 'vehicle',
      assetPath: 'assets/images/tambah_unit.png',
      label: 'Tambah Unit',
      color: const Color.fromARGB(255, 255, 255, 255),
    ),
    MenuItem(
      id: 'maintenance',
      assetPath: 'assets/images/cek_kendaraan.png',
      label: 'Cek Kendaraan',
      color: Colors.white,
    ),
    MenuItem(
      id: 'speedometer',
      assetPath: 'assets/images/speedometer.png',
      label: 'Speedometer',
      color: Colors.white,
    ),
    MenuItem(
      id: 'reports',
      assetPath: 'assets/images/cek_pajak.png',
      label: 'Cek Pajak',
      color: Colors.white,
    ),
    MenuItem(
      id: 'troubleshoot',
      assetPath: 'assets/images/toubleshoot.png',
      label: 'Troubleshoot',
      color: Colors.white,
    ),
    MenuItem(
      id: 'bantuan',
      assetPath: 'assets/images/bantuan.png',
      label: 'Bantuan',
      color: Colors.white,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 1) { // Track
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UnderConstructionScreen(title: 'Track'),
        ),
      );
    } else if (index == 2) { // Akun
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UnderConstructionScreen(title: 'Akun'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/sihemat_logo.png',
                  height: 40, // bisa disesuaikan
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications_outlined),
                      onPressed: () {},
                      color: Colors.grey.shade600,
                    ),
                    IconButton(
                      icon: Icon(Icons.settings_outlined),
                      onPressed: () {},
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Content
      Expanded(
        child: Column(
          children: [
            // Brand Banner
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
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
                  children: [
  // Slider Berita
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 160,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 6),
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                      ),
                      items: List.generate(4, (index) {
                        if (index < newsImages.length) {
                          // Slide berita dari gambar
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              newsImages[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        } else {
                          // Slide placeholder jika berita kurang dari 4
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Tidak ada berita terkini",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),

            // Profile + Menu (menyatu full layar bawah)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // User Profile
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Halo,',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  'Nirwan Rasyid Ridlo',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.fullscreen),
                            onPressed: () {},
                            color: Colors.grey.shade400,
                            iconSize: 32,
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 1, color: Colors.grey.shade300),

                    // Menu Grid
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      color: item.color,
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all( // outline lingkaran
                                        color: Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: item.assetPath != null
                                            ? Image.asset(
                                                item.assetPath!,
                                                fit: BoxFit.contain,
                                              )
                                            : Icon(
                                                item.icon,
                                                size: 32,
                                                color: item.color,
                                              ),
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
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      ]),
      
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey.shade400,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}