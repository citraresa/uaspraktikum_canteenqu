import 'package:shared_preferences/shared_preferences.dart';

class SessionServicerasya {
    final String _sessionKeyrasya = 'isLoggedIn_rasya';

    // Untuk menyimpan status login (true/false)
    Future<void> saveSessionrasya(bool status) async {
        final pref = await SharedPreferences.getInstance();
        await pref.setBool(_sessionKeyrasya, status);
    }
    
    // Untuk memeriksa apakah user sudah login
    Future<bool> isLoggedInrasya() async {
        final pref = await SharedPreferences.getInstance();
        return pref.getBool(_sessionKeyrasya) ?? false;
    }
    
    // Untuk menghapus session (logout)
    Future<void> clearSessionrasya() async {
        final pref = await SharedPreferences.getInstance();
        await pref.remove(_sessionKeyrasya);
    }
}