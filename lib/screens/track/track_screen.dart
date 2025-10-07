import 'package:flutter/material.dart';
import 'daftar_page.dart';
import 'peta_page.dart';

class TrackScreen extends StatefulWidget {
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48), // tinggi area TabBar
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade300, // warna garis abu di atas
                width: 1, // ketebalan garis
              ),
              bottom: BorderSide(
                color: Colors.grey.shade300, // opsional: garis bawah juga
                width: 1,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Color(0xFFE53935),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFFE53935),
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(text: 'Daftar'),
              Tab(text: 'Peta'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DaftarPage(),
          PetaPage(),
        ],
      ),
    );
  }
}
