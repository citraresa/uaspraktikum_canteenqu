import 'package:shared_preferences/shared_preferences.dart';

class SessionService_rasya {
    final String _sessionKey_rasya = 'isLoggedIn_rasya';

    // WAJIB: Definisikan fungsi dengan Watermark Code
    Future<void> saveSession_rasya(bool status) async {
        final pref = await SharedPreferences.getInstance();
        await pref.setBool(_sessionKey_rasya, status);
    }
    
    // Fungsi lain (IsLoggedIn) juga wajib ber-watermark
    Future<bool> isLoggedIn_rasya() async {
        final pref = await SharedPreferences.getInstance();
        return pref.getBool(_sessionKey_rasya) ?? false;
    }
    
    // Fungsi Clear Session (untuk Logout)
    Future<void> clearSession_rasya() async {
        final pref = await SharedPreferences.getInstance();
        await pref.remove(_sessionKey_rasya);
    }
}