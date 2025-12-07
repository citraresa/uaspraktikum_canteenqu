import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';

class RegisterScreenMaulina extends StatefulWidget {  
  const RegisterScreenMaulina({super.key});

  @override
  State<RegisterScreenMaulina> createState() => _RegisterScreenMaulinaState(); 
} 
class _RegisterScreenMaulinaState extends State<RegisterScreenMaulina> { 

  final _fullnameController_Maulina = TextEditingController(); 
  final _usernameController_Maulina = TextEditingController();
  final _emailController_rasya = TextEditingController();
  final _passwordController_Maulina = TextEditingController(); //variabel controller untuk mengambil input password
  final _confirmPasswordController_Maulina = TextEditingController(); //variabel controller untuk mengambil input confirm password

  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);
  final Color kWhite = const Color.fromARGB(255, 231, 231, 241);

  bool _loading = false;

  // REGISTER FUNCTION 
  Future<void> _register() async {
    String fullname = _fullnameController_Maulina.text.trim();
    String username = _usernameController_Maulina.text.trim();
    String email = _emailController_rasya.text.trim();
    String password = _passwordController_Maulina.text.trim();
    String confirmPassword = _confirmPasswordController_Maulina.text.trim();

    // VALIDASI
    if (fullname.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showError("Semua field harus diisi");
      return;
    }

    if (password != confirmPassword) {
      _showError("Password dan Confirm Password tidak sama");
      return;
    }

    setState(() => _loading = true);

    try {
      // 1. Firebase Auth Register
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCred.user!.uid;

      // 2. Simpan data user ke Firestore
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "fullname": fullname,
        "username": username,
        "email": email,
        "uid": uid,
        "created_at": DateTime.now(),
      });

      if (!mounted) return;

      // 3. Redirect ke Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreenMaulina()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registrasi berhasil, silakan login!")),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Terjadi kesalahan");
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
                controller: _fullnameController_Maulina,
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
              ),
              const SizedBox(height: 20),

              // Username
              TextFormField(
                controller: _usernameController_Maulina,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: kPrimaryBlue),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryBlue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                  ),
                ),
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
                    borderSide:
                        BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Password
              TextFormField(
                controller: _passwordController_Maulina,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: kPrimaryBlue),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryBlue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController_Maulina,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: kPrimaryBlue),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryBlue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                  ),
                ),
                obscureText: true,
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
                  onPressed: _loading ? null : _register,
                  child: _loading
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
