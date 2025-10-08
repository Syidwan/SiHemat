class Vehicle {
  final int id;
  final String code;
  final String plate;
  final int totalKm;
  final int todayKm;
  final String status;
  final String type;
  final double latitude;
  final double longitude;
  final String? address;

  Vehicle({
    required this.id,
    required this.code,
    required this.plate,
    required this.totalKm,
    required this.todayKm,
    required this.status,
    required this.type,
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

// Dummy data global
final List<Vehicle> globalVehicles = [
  Vehicle(
    id: 1,
    code: 'M0T0125000',
    plate: 'D 634 ZBP',
    totalKm: 23000,
    todayKm: 100,
    status: 'online',
    type: 'motorcycle',
    latitude: -6.9175,
    longitude: 107.6191,
    address: 'Jl. Sukajadi No. 123, Bandung',
  ),
  Vehicle(
    id: 2,
    code: 'M0131L4000',
    plate: 'D 634 ZBP',
    totalKm: 23000,
    todayKm: 100,
    status: 'online',
    type: 'motorcycle',
    latitude: -6.9147,
    longitude: 107.6098,
    address: 'Jl. Dago No. 456, Bandung',
  ),
  Vehicle(
    id: 3,
    code: 'C4126000',
    plate: 'D 634 ZBP',
    totalKm: 23000,
    todayKm: 100,
    status: 'online',
    type: 'car',
    latitude: -6.9039,
    longitude: 107.6186,
    address: 'Jl. Pasteur No. 789, Bandung',
  ),
  Vehicle(
    id: 4,
    code: 'C4126000',
    plate: 'D 634 ZBP',
    totalKm: 23000,
    todayKm: 100,
    status: 'offline',
    type: 'motorcycle',
    latitude: -6.9344,
    longitude: 107.6048,
    address: 'Jl. Buah Batu No. 321, Bandung',
  ),
  Vehicle(
    id: 5,
    code: '4E120X1000',
    plate: 'D 634 ZBP',
    totalKm: 23000,
    todayKm: 100,
    status: 'offline',
    type: 'car',
    latitude: -6.8945,
    longitude: 107.6107,
    address: 'Jl. Setiabudhi No. 654, Bandung',
  ),
  Vehicle(
    id: 6,
    code: 'M0T0125001',
    plate: 'D 635 ABC',
    totalKm: 15000,
    todayKm: 50,
    status: 'expired',
    type: 'motorcycle',
    latitude: -6.9285,
    longitude: 107.6369,
    address: 'Jl. Soekarno Hatta No. 987, Bandung',
  ),
];