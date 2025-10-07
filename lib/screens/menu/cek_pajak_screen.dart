import 'package:flutter/material.dart';

class CekPajakScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Cek Pajak'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Image.asset(
                    'assets/images/cek_pajak.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: 32),

              Text(
                '🚧',
                style: TextStyle(fontSize: 80),
              ),

              SizedBox(height: 24),

              Text(
                'Cek Pajak',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 8),

              Text(
                'Under Construction',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),

              SizedBox(height: 24),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    Text(
                      'Fitur pengecekan pajak kendaraan sedang dalam pengembangan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    // Text(
                    //   '📄 Info pajak kendaraan',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.grey.shade600,
                    //   ),
                    // ),
                    // SizedBox(height: 4),
                    // Text(
                    //   '⏰ Reminder jatuh tempo',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.grey.shade600,
                    //   ),
                    // ),
                    // SizedBox(height: 4),
                    // Text(
                    //   '💰 Riwayat pembayaran',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.grey.shade600,
                    //   ),
                    // ),
                  ],
                ),
              ),

              SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Kembali ke Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
