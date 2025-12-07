import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:canteenqu/models/userKt.dart';

class AuthController_rasya {
  final FirebaseAuth _auth_rasya = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ===== LOGIN =====
  Future<bool> loginUser_rasya(String email, String password) async {
    try {
      await _auth_rasya.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'Akun dengan email $email tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        throw 'Password salah';
      } else {
        throw Error();
      }
    }
  }

  Future<bool> registerUser_rasya(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential userCredential = await _auth_rasya
          .createUserWithEmailAndPassword(email: email, password: password);

      // 2️⃣ Simpan semua data ke Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullname': fullname,
        'username': username,
        'email': email,
        'password': password, // Hanya untuk demo, tidak aman di produksi
      });

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'Email sudah terdaftar';
      } else {
        throw Error();
      }
    }
  }

  // ===== LOGOUT =====
  Future<void> logoutUser_rasya() async {
    await _auth_rasya.signOut();
  }
}
