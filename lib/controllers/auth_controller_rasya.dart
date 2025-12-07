import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// FIXXX

class AuthControllerrasya {
  final FirebaseAuth _authrasya = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ===== LOGIN =====
  Future<bool> loginUserrasya(String email, String password) async {
    try {
      await _authrasya.signInWithEmailAndPassword(
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
        throw e.message ?? 'Terjadi kesalahan login';
      }
    }
  }

  // ===== REGISTER =====
  Future<bool> registerUserrasya(
    String fullName,
    String username,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _authrasya
          .createUserWithEmailAndPassword(email: email, password: password);

      // Simpan semua data ke Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullname': fullName,
        'username': username,
        'email': email,
        'password': password, 
      });

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'Email sudah terdaftar';
      } else {
        throw e.message ?? 'Terjadi kesalahan registrasi';
      }
    }
  }

  // ===== LOGOUT =====
  Future<void> logoutUserrasya() async {
    await _authrasya.signOut();
  }
}
