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

  // Tax Information
  final String? taxStartDate;
  final String? taxEndDate;
  final String? stnkEndDate;
  final String? color;
  final String? brand;
  final String? model;

  // Tax Costs
  final int? pajakKendaraan;
  final int? swdkllj;
  final int? pnbpStnk;
  final int? pnbpTnkb;
  final int? adminStnk;
  final int? adminTnkb;
  final int? penerbitan;

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
    this.taxStartDate,
    this.taxEndDate,
    this.stnkEndDate,
    this.color,
    this.brand,
    this.model,
    this.pajakKendaraan,
    this.swdkllj,
    this.pnbpStnk,
    this.pnbpTnkb,
    this.adminStnk,
    this.adminTnkb,
    this.penerbitan,
  });

  // Computed property untuk total pajak
  int get totalPajak {
    return (pajakKendaraan ?? 0) +
        (swdkllj ?? 0) +
        (pnbpStnk ?? 0) +
        (pnbpTnkb ?? 0) +
        (adminStnk ?? 0) +
        (adminTnkb ?? 0) +
        (penerbitan ?? 0);
  }
}

// Dummy data global (UPDATE)
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
    taxStartDate: '12 Jan 2026',
    taxEndDate: '12 Jan 2027',
    stnkEndDate: '12 Jan 2030',
    color: 'WHITE BLUE',
    brand: 'HONDA',
    model: 'ACH1M21B04 A/T',
    pajakKendaraan: 100000,
    swdkllj: 0,
    pnbpStnk: 66100,
    pnbpTnkb: 0,
    adminStnk: 35000,
    adminTnkb: 0,
    penerbitan: 0,
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
    taxStartDate: '15 Mar 2026',
    taxEndDate: '15 Mar 2027',
    stnkEndDate: '15 Mar 2030',
    color: 'RED',
    brand: 'YAMAHA',
    model: 'NMAX 155',
    pajakKendaraan: 95000,
    swdkllj: 35000,
    pnbpStnk: 66100,
    pnbpTnkb: 0,
    adminStnk: 35000,
    adminTnkb: 0,
    penerbitan: 0,
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
    taxStartDate: '20 Jun 2026',
    taxEndDate: '20 Jun 2027',
    stnkEndDate: '20 Jun 2031',
    color: 'BLACK',
    brand: 'TOYOTA',
    model: 'AVANZA 1.3 G MT',
    pajakKendaraan: 250000,
    swdkllj: 143000,
    pnbpStnk: 100000,
    pnbpTnkb: 0,
    adminStnk: 50000,
    adminTnkb: 25000,
    penerbitan: 0,
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
    taxStartDate: '05 Feb 2026',
    taxEndDate: '05 Feb 2027',
    stnkEndDate: '05 Feb 2030',
    color: 'BLUE',
    brand: 'SUZUKI',
    model: 'GSX-R150',
    pajakKendaraan: 110000,
    swdkllj: 35000,
    pnbpStnk: 66100,
    pnbpTnkb: 0,
    adminStnk: 35000,
    adminTnkb: 0,
    penerbitan: 0,
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
    taxStartDate: '10 Aug 2026',
    taxEndDate: '10 Aug 2027',
    stnkEndDate: '10 Aug 2031',
    color: 'SILVER',
    brand: 'DAIHATSU',
    model: 'XENIA 1.3 R MT',
    pajakKendaraan: 230000,
    swdkllj: 143000,
    pnbpStnk: 100000,
    pnbpTnkb: 0,
    adminStnk: 50000,
    adminTnkb: 25000,
    penerbitan: 0,
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
    taxStartDate: '01 Jan 2025',
    taxEndDate: '01 Jan 2026',
    stnkEndDate: '01 Jan 2030',
    color: 'GREEN',
    brand: 'KAWASAKI',
    model: 'NINJA 250',
    pajakKendaraan: 120000,
    swdkllj: 35000,
    pnbpStnk: 66100,
    pnbpTnkb: 0,
    adminStnk: 35000,
    adminTnkb: 0,
    penerbitan: 0,
  ),
];
