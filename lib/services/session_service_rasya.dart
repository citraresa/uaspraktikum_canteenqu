import 'package:shared_preferences/shared_preferences.dart';

// FIXXXX
class SessionServicerasya {
  final String _sessionKeyrasya = 'isLoggedIn_rasya';

  // SIMPAN STATUS LOGIN
  Future<void> saveSessionrasya(bool status) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_sessionKeyrasya, status);
  }

  // CEK STATUS LOGIN
  Future<bool> isLoggedInrasya() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_sessionKeyrasya) ?? false;
  }

  // HAPUS SESSION
  Future<void> clearSessionrasya() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_sessionKeyrasya);
  }
}
