import 'package:flutter/material.dart';
import 'registerScreen.dart';
import '../../screens/home/homeScreen.dart';

class LoginScreenMaulina extends StatefulWidget {
  const LoginScreenMaulina({super.key});

  @override
  State<LoginScreenMaulina> createState() => _LoginScreenMaulinaState();
}

class _LoginScreenMaulinaState extends State<LoginScreenMaulina> {
  final _usernameControllerMaulina = TextEditingController();
  final _passwordControllerMaulina = TextEditingController();

  final  Color kPrimaryBlue = Color.fromARGB(255, 37, 80, 144);
  final Color kWhite = const Color.fromARGB(255, 231, 231, 241);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: SingleChildScrollView( //agar bisa di scroll jika layar kecil
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset('assets/images/canteenqu.png', height: 150),
               const SizedBox(height: 10),             
                Text(
                  "WELCOME!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryBlue,

                  ),
                ),
                Text(
                  "Sign in to continue",
                  style: TextStyle(color: kPrimaryBlue.withOpacity(0.7)),
                ),
                const SizedBox(height: 40),

                // Username
                TextFormField(
                  controller: _usernameControllerMaulina,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color:kPrimaryBlue ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: kPrimaryBlue.withOpacity(0.4)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  controller: _passwordControllerMaulina,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: kPrimaryBlue.withOpacity(0.4)),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Tombol Login
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
                     onPressed: () {
                    // Navigate langsung ke Home (UI-only)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreenMaulina()),
                  );
                     },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 10),

                // Tombol Register
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RegisterScreenMaulina()),
                      );
                    },
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
