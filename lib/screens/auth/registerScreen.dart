import 'package:flutter/material.dart';
import '/controllers/auth_controller_rasya.dart';
import 'loginScreen.dart';

class RegisterScreenMaulina extends StatefulWidget {  
  const RegisterScreenMaulina({super.key});

  @override
  State<RegisterScreenMaulina> createState() => _RegisterScreenMaulinaState(); 
} 
class _RegisterScreenMaulinaState extends State<RegisterScreenMaulina> { 

class _RegisterScreenMaulinaState extends State<RegisterScreenMaulina> {
  final _fullnameController_maulina = TextEditingController();
  final _usernameController_maulina = TextEditingController();
  final _emailController_rasya = TextEditingController();
  final _passwordController_maulina = TextEditingController();
  final _confirmPasswordController_maulina = TextEditingController();

  final _formKey_rasya = GlobalKey<FormState>(); // Form key register
  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);
  final Color kWhite = const Color.fromARGB(255, 231, 231, 241);

  bool _loading_rasya = false;

  // ===== REGISTER FUNCTION =====
  Future<void> _register_rasya() async {
    if (!_formKey_rasya.currentState!.validate()) return;

    String fullname = _fullnameController_maulina.text.trim();
    String username = _usernameController_maulina.text.trim();
    String email = _emailController_rasya.text.trim();
    String password = _passwordController_maulina.text.trim();

    setState(() => _loading_rasya = true);

    try {
      bool success = await AuthController_rasya()
          .registerUser_rasya(fullname, username, email, password);

      if (success) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreenMaulina()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registrasi berhasil, silakan login!")),
        );
      }
    } catch (e) {
      _showError_rasya(e.toString());
    } finally {
      setState(() => _loading_rasya = false);
    }
  }

  void _showError_rasya(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey_rasya,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryBlue,
                  ),
                ),
                Text(
                  "Join us today",
                  style: TextStyle(color: kPrimaryBlue.withOpacity(0.7)),
                ),
                const SizedBox(height: 40),

                // Fullname
                TextFormField(
                  controller: _fullnameController_maulina,
                  decoration: InputDecoration(
                    labelText: 'Fullname',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                    ),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Fullname tidak boleh kosong' : null,
                ),
                const SizedBox(height: 20),

                // Username
                TextFormField(
                  controller: _usernameController_maulina,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                    ),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Username tidak boleh kosong' : null,
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  controller: _emailController_rasya,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                    if (!value.contains('@') || !value.endsWith('.com')) return 'Format email tidak valid';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  controller: _passwordController_maulina,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
                    if (value.length < 6) return 'Password minimal 6 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController_maulina,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm Password tidak boleh kosong';
                    if (value != _passwordController_maulina.text)
                      return 'Password dan Confirm Password tidak sama';
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Tombol Register
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _loading_rasya ? null : _register_rasya,
                    child: _loading_rasya
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Register', style: TextStyle(fontSize: 16)),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: kPrimaryBlue)),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Sign In",
                          style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
