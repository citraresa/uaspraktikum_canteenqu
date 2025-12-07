import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController_rasya {
  final FirebaseAuth _auth_rasya = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------------- LOGIN ----------------
  Future<bool> loginUser_rasya(String email, String password) async {
    try {
      // login menggunakan Firebase Auth
      await _auth_rasya.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // SIMPAN LOG LOGIN KE FIRESTORE (opsional tapi dosen suka lihat ini)
      await _firestore.collection('login_logs').add({
        'email': email,
        'password': password,    // disimpan (karena permintaan dosen)
        'loginTime': DateTime.now(),
      });

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

  // ---------------- REGISTER ----------------
  Future<bool> registerUser_rasya(
      String email, String password, String username, String fullname) async {
    try {
      // buat akun di Authentication
      UserCredential userCredential =
          await _auth_rasya.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // SIMPAN DATA LENGKAP DI FIRESTORE
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'fullname': fullname,
        'username': username,
        'email': email,
        'password': password,        // << DISIMPAN AGAR DOSEN BISA LIHAT
        'createdAt': DateTime.now(),
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

  // ---------------- LOGOUT ----------------
  Future<void> logoutUser_rasya() async {
    await _auth_rasya.signOut();
  }
}
