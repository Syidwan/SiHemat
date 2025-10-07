import 'package:flutter/material.dart';
import 'package:sihemat/screens/menu/bantuan_screen.dart';
import 'package:sihemat/screens/menu/cek_kendaraan_screen.dart';
import 'package:sihemat/screens/menu/cek_pajak_screen.dart';
import 'package:sihemat/screens/menu/speedometer_screen.dart';
import 'package:sihemat/screens/menu/tambah_unit_screen.dart';
import 'package:sihemat/screens/menu/troubleshoot_screen.dart';
import '../models/menu_item.dart';
import 'under_construction_screen.dart';
import 'track/track_screen.dart';
import 'account_screen.dart';
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
  int? _selectedMenuIndex;

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
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        // Brand Banner
        Padding(
          padding: EdgeInsets.all(10),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 170,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 6),
              enlargeCenterPage: true,
              viewportFraction: 0.9,
            ),
            items: List.generate(4, (index) {
              if (index < newsImages.length) {
                // Slide berita
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      newsImages[index],
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                );
              } else {
                // Slide placeholder
                return Container(
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
        ),

        // Profile + Menu
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
                          onTapDown: (_) {
                            setState(() {
                              _selectedMenuIndex = index;
                            });
                          },
                          onTapUp: (_) {
                            setState(() {
                              _selectedMenuIndex = null;
                            });

                            Widget targetScreen;

                            switch (item.id) {
                              case 'vehicle':
                                targetScreen = TambahUnitScreen();
                                break;
                              case 'maintenance':
                                targetScreen = CekKendaraanScreen();
                                break;
                              case 'speedometer':
                                targetScreen = SpeedometerScreen();
                                break;
                              case 'reports':
                                targetScreen = CekPajakScreen();
                                break;
                              case 'troubleshoot':
                                targetScreen = TroubleshootScreen();
                                break;
                              case 'bantuan':
                                targetScreen = BantuanScreen();
                                break;
                              default:
                                targetScreen = Scaffold(
                                  body: Center(
                                      child: Text("Halaman belum tersedia")),
                                );
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => targetScreen),
                            );
                          },
                          onTapCancel: () {
                            setState(() {
                              _selectedMenuIndex = null;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: _selectedMenuIndex == index
                                      ? Colors.grey.shade200
                                      : item.color,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: _selectedMenuIndex == index
                                        ? Colors.grey.shade200
                                        : Colors.grey.shade400,
                                    width: _selectedMenuIndex == index ? 3 : 2,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header
          Material(
            elevation: 4, 
            shadowColor: Colors.black.withOpacity(0.2),
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 12,
                left: 16,
                right: 16,
                bottom: 12,
              ),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/sihemat_logo.png',
                    height: 40,
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
          ),
          // Content dengan IndexedStack
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildHomeContent(),
                TrackScreen(),
                AccountScreen(),
              ],
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
