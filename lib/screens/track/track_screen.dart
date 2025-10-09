import 'package:flutter/material.dart';
import 'daftar_page.dart';
import 'peta_page.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

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
    print('==========================================');
    print('TrackScreen._onVehicleSelected CALLED!');
    print('Vehicle ID selected: $vehicleId');
    print('Previous selectedVehicleId: $_selectedVehicleId');

    setState(() {
      _selectedVehicleId = vehicleId;
    });
    print('State updated! New selectedVehicleId: $_selectedVehicleId');

    // Pindah ke tab Peta dulu
    print('Switching to Peta tab (index 1)...');
    _tabController.animateTo(1);

    // Delay untuk memastikan PetaPage sudah di-render
    Future.delayed(Duration(milliseconds: 100), () {
      // Update PetaPage langsung via GlobalKey
      print('Calling PetaPage.updateSelectedVehicle($vehicleId)...');

      if (_petaPageKey.currentState == null) {
        print('❌ ERROR: _petaPageKey.currentState is NULL!');
        print('PetaPage might not be initialized yet.');
      } else {
        print('✅ PetaPage state found, calling updateSelectedVehicle...');
        _petaPageKey.currentState?.updateSelectedVehicle(vehicleId);
      }
    });

    print('==========================================');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48), // tinggi area TabBar
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
            labelColor: const Color(0xFFE53935),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFFE53935),
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
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
