import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sihemat/screens/dashboard_screen.dart';
import 'package:sihemat/screens/register_selection.dart';
import 'package:sihemat/utils/session_manager.dart';

class RegisterPage extends StatefulWidget {
  final String role; // "pengguna" atau "korporasi"
  const RegisterPage({super.key, required this.role});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk field
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final platNomorController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    companyNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    platNomorController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Validasi umum
  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "$fieldName harus diisi";
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email harus diisi";
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return "Format email tidak valid";
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password harus diisi";
    if (value.length < 6) return "Minimal 6 karakter";
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    if (!hasLetter || !hasNumber) {
      return "Password harus berisi huruf dan angka";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty)
      return "Konfirmasi password harus diisi";
    if (value != passwordController.text) return "Password tidak cocok";
    return null;
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      // Simpan role ke session
      SessionManager.userRole = widget.role;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registrasi berhasil sebagai ${widget.role}")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
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
            child: ListView(
              children: [
                SizedBox(height: screenHeight * 0.05),
                Text(
                  widget.role == "pengguna"
                      ? "Registrasi Pengguna"
                      : "Registrasi Korporasi",
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                if (widget.role == "pengguna") ...[
                  // Nama Depan & Nama Belakang dalam satu baris
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: "Nama Depan",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (v) => _validateNotEmpty(v, "Nama Depan"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            hintText: "Nama Belakang",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (v) =>
                              _validateNotEmpty(v, "Nama Belakang"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: "Nomor Telepon",
                      prefixIcon: Icon(Icons.phone),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) => _validateNotEmpty(v, "Nomor Telepon"),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: platNomorController,
                    decoration: InputDecoration(
                      hintText: "Plat Nomor",
                      prefixIcon: Icon(Icons.confirmation_num),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) => _validateNotEmpty(v, "Plat Nomor"),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Konfirmasi Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validateConfirmPassword,
                  ),
                ],
                if (widget.role == "korporasi") ...[
                  TextFormField(
                    controller: companyNameController,
                    decoration: InputDecoration(
                      hintText: "Nama Perusahaan",
                      prefixIcon: Icon(Icons.business),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) => _validateNotEmpty(v, "Nama Perusahaan"),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Konfirmasi Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validateConfirmPassword,
                  ),
                ],
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onRegisterPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterSelection(),
                      ),
                    );
                  },
                  child: Text(
                    "Kembali ke Pilihan Registrasi",
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
