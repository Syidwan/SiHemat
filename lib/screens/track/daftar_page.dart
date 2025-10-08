import 'package:flutter/material.dart';
import 'package:sihemat/models/vehicle_model.dart';

class DaftarPage extends StatefulWidget {
  final Function(int) onVehicleSelected;

  DaftarPage({required this.onVehicleSelected});

  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final TextEditingController _searchController = TextEditingController();
  String _activeFilter = 'semua';
  String _searchQuery = '';

  List<Vehicle> get _filteredVehicles {
    return globalVehicles.where((vehicle) {
      final matchesSearch =
          vehicle.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              vehicle.plate.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter =
          _activeFilter == 'semua' || vehicle.status == _activeFilter;
      return matchesSearch && matchesFilter;
    }).toList();
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

  void _handleDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Kendaraan'),
        content:
            Text('Apakah Anda yakin ingin menghapus kendaraan dengan ID: $id?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                globalVehicles.removeWhere((v) => v.id == id);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kendaraan berhasil dihapus')),
              );
            },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _handleInfo(int id) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text('🚧'),
            SizedBox(width: 8),
            Text('Under Construction'),
          ],
        ),
        content: Text('Fitur info detail kendaraan sedang dalam pengembangan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Cari',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),

        // Filter Tabs
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['semua', 'online', 'offline', 'expired'].map((filter) {
              final isActive = _activeFilter == filter;
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(
                    filter[0].toUpperCase() + filter.substring(1),
                    style: TextStyle(
                      color: isActive ? Colors.black87 : Colors.grey,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  selected: isActive,
                  onSelected: (selected) {
                    setState(() => _activeFilter = filter);
                  },
                  backgroundColor: Color(0xFFF5F5F5),
                  selectedColor: Colors.white,
                  side: BorderSide(
                    color: isActive ? Colors.grey.shade300 : Colors.transparent,
                    width: isActive ? 2 : 0,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: 8),

        // Vehicle List
        Expanded(
          child: _filteredVehicles.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada kendaraan ditemukan',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: _filteredVehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = _filteredVehicles[index];
                    return InkWell(
                      onTap: () => widget.onVehicleSelected(vehicle.id),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: Color(0xFFE0E0E0),
                            child: Icon(
                              vehicle.type == 'motorcycle'
                                  ? Icons.two_wheeler
                                  : Icons.directions_car,
                              size: 28,
                              color: Colors.black54,
                            ),
                          ),
                          title: Text(
                            vehicle.code,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.speed,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    '${vehicle.totalKm}km',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: 16),
                                  Icon(Icons.calendar_today,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    '${vehicle.todayKm}km',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    vehicle.plate,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    vehicle.status[0].toUpperCase() +
                                        vehicle.status.substring(1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor(vehicle.status),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert),
                            onSelected: (value) {
                              if (value == 'info') {
                                _handleInfo(vehicle.id);
                              } else if (value == 'delete') {
                                _handleDelete(vehicle.id);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'info',
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline, size: 20),
                                    SizedBox(width: 8),
                                    Text('Info'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_outline,
                                        size: 20, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Delete',
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
