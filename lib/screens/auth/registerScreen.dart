import 'package:flutter/material.dart';
import 'package:canteenqu/controllers/auth_controller_rasya.dart';
import 'loginScreen.dart';

// FIXXXXX

class RegisterScreenMaulina extends StatefulWidget {
  const RegisterScreenMaulina({super.key});

  @override
  State<RegisterScreenMaulina> createState() => _RegisterScreenMaulinaState();
}

class _RegisterScreenMaulinaState extends State<RegisterScreenMaulina> {
  final _fullnameController_maulina = TextEditingController();
  final _usernameController_maulina = TextEditingController();
  final _emailController_maulina = TextEditingController();
  final _passwordController_maulina = TextEditingController();
  final _confirmPasswordController_maulina = TextEditingController();

  final _formKeyrasya = GlobalKey<FormState>(); // Form key register

  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);
  final Color kWhite = const Color.fromARGB(255, 231, 231, 241);
  bool _loadingrasya = false;

  // REGISTER FUNCTION
  Future<void> _registerrasya() async {
    if (!_formKeyrasya.currentState!.validate()) return;

    String fullname = _fullnameController_maulina.text.trim();
    String username = _usernameController_maulina.text.trim();
    String email = _emailController_maulina.text.trim();
    String password = _passwordController_maulina.text.trim();

    setState(() => _loadingrasya = true);

    try {
      bool success = await AuthControllerrasya().registerUserrasya(
        fullname,
        username,
        email,
        password,
      );

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
      _showErrorrasya(e.toString());
    } finally {
      setState(() => _loadingrasya = false);
    }
  }

  void _showErrorrasya(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKeyrasya,
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
                      borderSide: BorderSide(
                        color: kPrimaryBlue.withOpacity(0.4),
                      ),
                    ),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Fullname tidak boleh kosong'
                      : null,
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
                      borderSide: BorderSide(
                        color: kPrimaryBlue.withOpacity(0.4),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Username tidak boleh kosong';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  controller: _emailController_maulina,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryBlue.withOpacity(0.4),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Email tidak boleh kosong';
                    final emailRegex = RegExp(r'^[\w-\.]+@gmail\.com$');
                    if (!emailRegex.hasMatch(value))
                      return 'Email harus menggunakan format @gmail.com';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  controller: _passwordController_maulina,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryBlue.withOpacity(0.4),
                      ),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password tidak boleh kosong';
                    if (value.length < 6) return 'Password minimal 6 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController_maulina,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryBlue.withOpacity(0.4),
                      ),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Confirm Password tidak boleh kosong';
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
                    onPressed: _loadingrasya ? null : _registerrasya,
                    child: _loadingrasya
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Register',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: kPrimaryBlue),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: kPrimaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
