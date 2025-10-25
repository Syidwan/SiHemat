import 'package:flutter/material.dart';
import 'package:sihemat/screens/login_screen.dart';
// Import LoginScreen - sesuaikan dengan path Anda
// import 'package:your_app/screens/auth/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Profile Section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFE53935),
            ),
            padding: EdgeInsets.fromLTRB(24, 60, 24, 32),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Color(0xFF5DADE2),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 16),

                // Name and Role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nirwan Rasyid Ridlo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Akun Pemilik',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Menu List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: 'Edit Profil',
                  onTap: () {
                    // Navigate to Edit Profile
                    _showUnderConstruction(context, 'Edit Profil');
                  },
                ),

                _buildMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'Pengaturan',
                  onTap: () {
                    // Navigate to Settings
                    _showUnderConstruction(context, 'Pengaturan');
                  },
                ),

                _buildMenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifikasi',
                  onTap: () {
                    // Navigate to Notifications
                    _showUnderConstruction(context, 'Notifikasi');
                  },
                ),

                _buildMenuItem(
                  icon: Icons.description_outlined,
                  title: 'Laporan',
                  onTap: () {
                    // Navigate to Reports
                    _showUnderConstruction(context, 'Laporan');
                  },
                ),

                _buildMenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'Konfigurasi',
                  onTap: () {
                    // Navigate to Configuration
                    _showUnderConstruction(context, 'Konfigurasi');
                  },
                ),

                _buildMenuItem(
                  icon: Icons.mail_outline,
                  title: 'Umpan Balik',
                  onTap: () {
                    // Navigate to Feedback
                    _showUnderConstruction(context, 'Umpan Balik');
                  },
                ),

                _buildMenuItem(
                  icon: Icons.info_outline,
                  title: 'Tentang',
                  onTap: () {
                    // Navigate to About
                    _showAboutDialog(context);
                  },
                ),

                SizedBox(height: 16),

                // Logout Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: OutlinedButton(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Ganti Akun / Keluar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey.shade400,
          size: 28,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showUnderConstruction(BuildContext context, String feature) {
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
        content: Text('Fitur $feature sedang dalam pengembangan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFFE53935)),
            SizedBox(width: 8),
            Text('Tentang'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SiHeman',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text('Smart Energy Tracker App'),
            SizedBox(height: 16),
            Text('Versi: 1.0.0'),
            SizedBox(height: 8),
            Text('© 2025 SiHeman Team'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Keluar'),
        content: Text('Apakah Anda yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _performLogout(context);
            },
            child: Text(
              'Keluar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _performLogout(BuildContext context) {
    // TODO: Clear local storage/session
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    // TODO: Clear user token/session from API
    // await AuthService.logout();

    // Navigate to LoginScreen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false, // Remove all previous routes
    );

    // Show success message
    // Note: SnackBar won't show because we've navigated away
    // You can show it in LoginScreen instead if needed
  }
}
