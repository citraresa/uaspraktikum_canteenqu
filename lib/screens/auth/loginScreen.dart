import 'package:canteenqu/controllers/auth_controller_rasya.dart';
import 'package:canteenqu/screens/home/HomeScreen.dart';
import 'package:canteenqu/services/session_service_rasya.dart';
import 'package:flutter/material.dart';
import 'registerScreen.dart';

// FIXXXX

class LoginScreenMaulina extends StatefulWidget {
  const LoginScreenMaulina({super.key});

  @override
  State<LoginScreenMaulina> createState() => _LoginScreenMaulinaState();
}

class _LoginScreenMaulinaState extends State<LoginScreenMaulina> {
  final _emailController_maulina = TextEditingController();
  final _passwordController_maulina = TextEditingController();
  final _formKeyrasya = GlobalKey<FormState>(); // 🔹 Form key
  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);
  final Color kWhite = const Color.fromARGB(255, 231, 231, 241);
  bool _loadingrasya = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKeyrasya,
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
                      color: kPrimaryBlue),
                ),
                Text(
                  "Sign in to continue",
                  style: TextStyle(color: kPrimaryBlue.withOpacity(0.7)),
                ),
                const SizedBox(height: 40),

                // EMAIL
                TextFormField(
                  controller: _emailController_maulina,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryBlue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryBlue.withOpacity(0.4))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!value.contains('@') || !value.endsWith('.com')) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // PASSWORD
                TextFormField(
                  controller: _passwordController_maulina,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: kPrimaryBlue),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryBlue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryBlue.withOpacity(0.4))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: _loadingrasya ? null : loginRasya,
                    child: _loadingrasya
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  ),
                ),
                const SizedBox(height: 10),

                // REGISTER BUTTON
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
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 // LOGIN FUNCTION
  Future<void> loginRasya() async {
    if (!_formKeyrasya.currentState!.validate()) return;

    final email = _emailController_maulina.text.trim();
    final password = _passwordController_maulina.text.trim();

    setState(() => _loadingrasya = true);

    try {
      bool success =
          await AuthControllerrasya().loginUserrasya(email, password);
      if (success) {
        await SessionServicerasya().saveSessionrasya(true);
        if (!mounted) return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeScreenMaulina()));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Error: $e")));
    } finally {
      if (mounted) {
        setState(() => _loadingrasya = false);
      }
    }
  }
}
