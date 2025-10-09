import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sihemat/screens/login_screen.dart';
import 'package:sihemat/screens/dashboard_screen.dart';
import 'package:sihemat/utils/session_manager.dart';

class LoginPage extends StatefulWidget {
  final String role;
  const LoginPage({super.key, required this.role});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final platNomorController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    platNomorController.dispose();
    super.dispose();
  }

  // validasi email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email harus diisi";
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return "Format email tidak valid";
    return null;
  }

  // validasi password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Kata sandi harus diisi";
    if (value.length < 6) return "Minimal 6 karakter";
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    if (!hasLetter || !hasNumber) {
      return "Password harus berisi huruf dan angka";
    }
    return null;
  }

  // validasi plat nomor
  String? _validatePlatNomor(String? value) {
    if (value == null || value.isEmpty) return "Plat nomor harus diisi";
    return null;
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      // simpan role ke SessionManager
      SessionManager.userRole = widget.role;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login berhasil sebagai ${widget.role}")),
      );

      // arahkan ke dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),

                // Logo
                Center(
                  child: Image.asset(
                    'assets/images/sihemat_logo.png',
                    width: screenHeight * 0.28,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // Title
                Text(
                  widget.role == "pengguna"
                      ? "Login Pengguna"
                      : widget.role == "korporasi"
                          ? "Login Korporasi"
                          : "Login Guest",
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Field sesuai role
                if (widget.role == "pengguna" ||
                    widget.role == "korporasi") ...[
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email Anda",
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Kata Sandi",
                      prefixIcon: const Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 16),
                ],

                if (widget.role == "pengguna" || widget.role == "guest") ...[
                  TextFormField(
                    controller: platNomorController,
                    decoration: InputDecoration(
                      hintText: "Plat Nomor",
                      prefixIcon: const Icon(Icons.confirmation_num),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validatePlatNomor,
                  ),
                  const SizedBox(height: 16),
                ],

                // Tombol Login
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onLoginPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const Spacer(),

                // Pilihan Login
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    "Pilihan Login",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: screenHeight * 0.018,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
