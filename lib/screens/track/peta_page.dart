/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetaPage extends StatefulWidget {
  const PetaPage({super.key});

  @override
  State<PetaPage> createState() => PetaPageState();
}

class PetaPageState extends State<PetaPage> {
  static const ptLen = LatLng(-6.949411068037853, 107.61946062733901);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: ptLen,
          zoom: 13,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('sourceLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: ptLen,
          )
        },
      ));
}*/

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sihemat/models/vehicle_model.dart';

class PetaPage extends StatefulWidget {
  final int initialVehicleId;

  PetaPage({Key? key, required this.initialVehicleId}) : super(key: key);

  @override
  PetaPageState createState() => PetaPageState();
}

class PetaPageState extends State<PetaPage> {
  late int _currentVehicleIndex;
  double _bottomSheetHeight = 250.0;
  final double _minSheetHeight = 150.0;
  final double _maxSheetHeight = 500.0;
  bool _isExpanded = false;

  // Uncomment jika sudah install flutter_map
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    print('PetaPage initState: initialVehicleId = ${widget.initialVehicleId}');
    _mapController = MapController();
    
    // Set initial index berdasarkan initialVehicleId
    _currentVehicleIndex = globalVehicles.indexWhere((v) => v.id == widget.initialVehicleId);
    
    if (_currentVehicleIndex == -1) {
      print('PetaPage initState: Vehicle not found, defaulting to 0');
      _currentVehicleIndex = 0;
    } else {
      print('PetaPage initState: Found vehicle at index $_currentVehicleIndex (${_currentVehicle.code})');
    }
    
    // Center map setelah build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerMapToCurrentVehicle();
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  // Method public untuk update dari parent (TrackScreen)
  void updateSelectedVehicle(int vehicleId) {
    print('PetaPage updateSelectedVehicle: Updating to vehicle ID $vehicleId');
    final newIndex = globalVehicles.indexWhere((v) => v.id == vehicleId);
    
    if (newIndex != -1 && newIndex != _currentVehicleIndex) {
      print('PetaPage updateSelectedVehicle: Found at index $newIndex (${globalVehicles[newIndex].code})');
      setState(() {
        _currentVehicleIndex = newIndex;
      });
      _centerMapToCurrentVehicle();
    } else {
      print('PetaPage updateSelectedVehicle: Vehicle not found or already selected');
    }
  }

  Vehicle get _currentVehicle {
    return globalVehicles[_currentVehicleIndex];
  }

  void _centerMapToCurrentVehicle() {
    print('PetaPage _centerMapToCurrentVehicle: Centering to ${_currentVehicle.code}');
    // Uncomment jika sudah install flutter_map
    _mapController.move(
      LatLng(_currentVehicle.latitude, _currentVehicle.longitude),
      15.0,
    );
    
    // Trigger rebuild untuk update UI
    if (mounted) {
      setState(() {});
    }
  }

  void _onMarkerTap(int vehicleId) {
    print('PetaPage _onMarkerTap: Marker tapped with ID $vehicleId');
    final index = globalVehicles.indexWhere((v) => v.id == vehicleId);
    if (index != -1 && index != _currentVehicleIndex) {
      print('PetaPage _onMarkerTap: Switching to index $index (${globalVehicles[index].code})');
      setState(() {
        _currentVehicleIndex = index;
      });
      _centerMapToCurrentVehicle();
    }
  }

  void _nextVehicle() {
    setState(() {
      _currentVehicleIndex = (_currentVehicleIndex + 1) % globalVehicles.length;
      print('PetaPage _nextVehicle: Switched to index $_currentVehicleIndex (${_currentVehicle.code})');
    });
    _centerMapToCurrentVehicle();
  }

  void _previousVehicle() {
    setState(() {
      _currentVehicleIndex = (_currentVehicleIndex - 1 + globalVehicles.length) % globalVehicles.length;
      print('PetaPage _previousVehicle: Switched to index $_currentVehicleIndex (${_currentVehicle.code})');
    });
    _centerMapToCurrentVehicle();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'online':
        return Colors.green;
      case 'offline':
        return Colors.grey;
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Stack(
      children: [
        // Map Container - Menggunakan Placeholder
        // Ganti dengan FlutterMap setelah install package
        Container(
          color: Color(0xFFE5E5E5),
          child: Stack(
            children: [
              // Background Map Area
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 100,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Flutter Map Area',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Current Location:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Lat: ${_currentVehicle.latitude.toStringAsFixed(4)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Long: ${_currentVehicle.longitude.toStringAsFixed(4)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Vehicle Markers (Clickable)
              ...globalVehicles.asMap().entries.map((entry) {
                final index = entry.key;
                final vehicle = entry.value;
                final isSelected = vehicle.id == _currentVehicle.id;
                
                // Positioning markers in a grid-like pattern for demo
                final left = 50.0 + (index % 3) * 100.0;
                final top = 150.0 + (index ~/ 3) * 120.0;
                
                return Positioned(
                  left: left,
                  top: top,
                  child: GestureDetector(
                    onTap: () => _onMarkerTap(vehicle.id),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.all(isSelected ? 16 : 12),
                          decoration: BoxDecoration(
                            color: _getStatusColor(vehicle.status),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: isSelected ? 4 : 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected 
                                    ? _getStatusColor(vehicle.status).withOpacity(0.6)
                                    : Colors.black.withOpacity(0.3),
                                blurRadius: isSelected ? 12 : 6,
                                spreadRadius: isSelected ? 2 : 0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            vehicle.type == 'motorcycle'
                                ? Icons.two_wheeler
                                : Icons.directions_car,
                            color: Colors.white,
                            size: isSelected ? 28 : 20,
                          ),
                        ),
                        if (isSelected) ...[
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              vehicle.code,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        
        
        // CONTOH IMPLEMENTASI FLUTTER MAP (Uncomment setelah install package)
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(_currentVehicle.latitude, _currentVehicle.longitude),
            zoom: 15.0,
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.all,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.siheman',
            ),
            MarkerLayer(
              markers: globalVehicles.map((vehicle) {
                final isSelected = vehicle.id == _currentVehicle.id;
                return Marker(
                  point: LatLng(vehicle.latitude, vehicle.longitude),
                  width: isSelected ? 80 : 60,
                  height: isSelected ? 80 : 60,
                  child: GestureDetector(
                    onTap: () => _onMarkerTap(vehicle.id),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.all(isSelected ? 14 : 10),
                          decoration: BoxDecoration(
                            color: _getStatusColor(vehicle.status),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: isSelected ? 4 : 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected 
                                    ? _getStatusColor(vehicle.status).withOpacity(0.6)
                                    : Colors.black.withOpacity(0.3),
                                blurRadius: isSelected ? 12 : 6,
                                spreadRadius: isSelected ? 2 : 0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            vehicle.type == 'motorcycle'
                                ? Icons.two_wheeler
                                : Icons.directions_car,
                            color: Colors.white,
                            size: isSelected ? 26 : 18,
                          ),
                        ),
                        if (isSelected) ...[
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              vehicle.code,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        

        // Navigation Buttons (Left Side) - Untuk ganti kendaraan
        Positioned(
          left: 16,
          top: screenHeight * 0.4 - 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _previousVehicle,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 48,
                  color: Colors.grey.shade300,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _nextVehicle,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Control Buttons (Right Side)
        Positioned(
          right: 16,
          top: screenHeight * 0.35 - 60,
          child: Column(
            children: [
              // Recenter Button
              Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      _centerMapToCurrentVehicle();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Centering to ${_currentVehicle.code}'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.my_location,
                        color: Colors.blue.shade700,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              // GPS Location Button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Getting current GPS location'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.gps_fixed,
                        color: Colors.grey.shade700,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Draggable Bottom Sheet
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                _bottomSheetHeight -= details.delta.dy;
                _bottomSheetHeight = _bottomSheetHeight.clamp(
                  _minSheetHeight,
                  _maxSheetHeight,
                );
                _isExpanded = _bottomSheetHeight > 300;
              });
            },
            onVerticalDragEnd: (details) {
              // Snap to min or mid height based on velocity
              setState(() {
                if (details.primaryVelocity! > 300) {
                  // Swipe down - minimize
                  _bottomSheetHeight = _minSheetHeight;
                  _isExpanded = false;
                } else if (details.primaryVelocity! < -300) {
                  // Swipe up - maximize
                  _bottomSheetHeight = _maxSheetHeight;
                  _isExpanded = true;
                } else {
                  // Snap to nearest
                  if (_bottomSheetHeight < 200) {
                    _bottomSheetHeight = _minSheetHeight;
                    _isExpanded = false;
                  } else if (_bottomSheetHeight < 350) {
                    _bottomSheetHeight = 250.0;
                    _isExpanded = false;
                  } else {
                    _bottomSheetHeight = _maxSheetHeight;
                    _isExpanded = true;
                  }
                }
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _bottomSheetHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag Handle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_isExpanded) {
                          _bottomSheetHeight = 250.0;
                          _isExpanded = false;
                        } else {
                          _bottomSheetHeight = _maxSheetHeight;
                          _isExpanded = true;
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vehicle Code and Status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _currentVehicle.code,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(_currentVehicle.status)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  _currentVehicle.status[0].toUpperCase() +
                                      _currentVehicle.status.substring(1),
                                  style: TextStyle(
                                    color: _getStatusColor(_currentVehicle.status),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4),

                          // Plate Number
                          Text(
                            _currentVehicle.plate,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),

                          SizedBox(height: 12),

                          // Address
                          if (_currentVehicle.address != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on,
                                    size: 18, color: Colors.grey.shade600),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _currentVehicle.address!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          SizedBox(height: 16),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: _buildActionButton(
                                  icon: Icons.person_pin_circle,
                                  label: 'Lacak',
                                  color: Colors.blue,
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _buildActionButton(
                                  icon: Icons.play_circle,
                                  label: 'Playback',
                                  color: Colors.green,
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _buildActionButton(
                                  icon: Icons.speed,
                                  label: 'Speedometer',
                                  color: Colors.red,
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _buildActionButton(
                                  icon: Icons.info,
                                  label: 'Informasi',
                                  color: Colors.orange,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),

                          // Stats
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                _buildStatRow(
                                  'Kilometer total',
                                  '${_currentVehicle.totalKm}km',
                                ),
                                SizedBox(height: 12),
                                _buildStatRow(
                                  'Kilometer hari ini',
                                  '${_currentVehicle.todayKm}km',
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}