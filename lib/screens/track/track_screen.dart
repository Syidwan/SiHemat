import 'package:flutter/material.dart';
import 'daftar_page.dart';
import 'peta_page.dart';
import 'package:sihemat/models/vehicle_model.dart';

class TrackScreen extends StatefulWidget {
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedVehicleId = 1; // Default ke vehicle pertama
  final GlobalKey<PetaPageState> _petaPageKey = GlobalKey<PetaPageState>();

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

  void _onVehicleSelected(int vehicleId) {
    print('TrackScreen: Vehicle selected with ID: $vehicleId');
    setState(() {
      _selectedVehicleId = vehicleId;
    });

    // Update PetaPage langsung via GlobalKey
    _petaPageKey.currentState?.updateSelectedVehicle(vehicleId);

    // Pindah ke tab Peta
    _tabController.animateTo(1);
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
                color: Colors.grey.shade300,
                width: 1,
              ),
              bottom: BorderSide(
                color: Colors.grey.shade300,
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
          DaftarPage(onVehicleSelected: _onVehicleSelected),
          PetaPage(key: _petaPageKey, initialVehicleId: _selectedVehicleId),
        ],
      ),
    );
  }
}
