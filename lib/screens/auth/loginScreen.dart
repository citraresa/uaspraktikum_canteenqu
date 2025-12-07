import 'package:flutter/material.dart';
import 'registerScreen.dart';
import '/screens/home/homeScreen.dart';
import '/controllers/auth_controller_rasya.dart';
import '/services/session_service_rasya.dart';


class LoginScreenMaulina extends StatefulWidget {
  const LoginScreenMaulina({super.key});

  @override
  State<LoginScreenMaulina> createState() => _LoginScreenMaulinaState();
}

<<<<<<< HEAD
 class _LoginScreenMaulinaState extends State<LoginScreenMaulina> {
  final _emailController_rasya = TextEditingController(); //variabel controller untuk mengambil input email
  final _passwordControllerMaulina = TextEditingController(); //variabel controller untuk mengambil input password
=======
class _LoginScreenMaulinaState extends State<LoginScreenMaulina> {
  final _emailController_maulina = TextEditingController();
  final _passwordController_maulina = TextEditingController();

  final _formKey_rasya = GlobalKey<FormState>(); // 🔹 Form key
>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9

  final Color kPrimaryBlue = const Color.fromARGB(255, 37, 80, 144);
  final Color kWhite = const Color.fromARGB(255, 231, 231, 241);

<<<<<<< HEAD
  String? _emailErrorText;
  String? _passwordErrorText;

  // VALIDASI EMAIL (Rasya)
  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!email.contains('@')) {
      return 'Format email tidak valid';
    }
    return null;
  }

  // VALIDASI PASSWORD(Rasya)
  String? _validatePassword(String? pass) {
    if (pass == null || pass.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (pass.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }
//anggota 2
=======
  bool _loading_rasya = false; 

>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: kWhite, 
      body: Center( 
        child: SingleChildScrollView( 
          padding: const EdgeInsets.all(16),
<<<<<<< HEAD
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Image.asset('assets/images/canteenqu.png', height: 150), 
              const SizedBox(height: 10), 

            //tampilan welcome 
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
              // EMAIL
              TextField(
                controller: _emailController_rasya,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: kPrimaryBlue),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryBlue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                  ),
                  errorText: _emailErrorText,
=======
          child: Form(
            key: _formKey_rasya,
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
>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9
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
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
<<<<<<< HEAD

                    // LOGIN (Firebase)
                    try {
                      bool success = await AuthController_rasya()
                          .loginUser_rasya(email, password);

                      if (success) {
                        // SIMPAN SESSION(rasya)
                        await SessionService_rasya().saveSession_rasya(true);

                        // NAVIGASI pushReplacement
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HomeScreenMaulina(),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Error: $e")),
                      );
=======
                    if (!value.contains('@') || !value.endsWith('.com')) {
                      return 'Format email tidak valid';
>>>>>>> fe4441891b47dfa989f352b5491a04c38c3477f9
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
                      borderSide: BorderSide(color: kPrimaryBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryBlue.withOpacity(0.4)),
                    ),
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _loading_rasya ? null : loginRasya,
                    child: _loading_rasya
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
                          builder: (context) => const RegisterScreenMaulina(),
                        ),
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

  // LOGIN FUNCTION menggunakan AuthController
  Future<void> loginRasya() async {
    if (!_formKey_rasya.currentState!.validate()) return;

    final email = _emailController_maulina.text.trim();
    final password = _passwordController_maulina.text.trim();

    setState(() => _loading_rasya = true);

    try {
      bool success = await AuthController_rasya().loginUser_rasya(email, password);

      if (success) {
        await SessionServicerasya().saveSessionrasya(true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenMaulina()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Error: $e")),
      );
    } finally {
      setState(() => _loading_rasya = false);
    }
  }
}
