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
  final _emailController_Maulina = TextEditingController();
  final _passwordController_Maulina = TextEditingController();
  final _confirmPasswordController_Maulina = TextEditingController();

  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);
  final Color kWhite = const Color.fromARGB(255, 231, 231, 241);

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
                controller: _emailController_Maulina,
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
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Register ditekan (UI-only)"),
                      ),
                    );
                  },
                  child: const Text(
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
