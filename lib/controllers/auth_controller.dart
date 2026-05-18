import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  final _username = ''.obs;
  String get username => _username.value;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    _username.value = prefs.getString('auth_logged_in_user') ?? '';
    
    if (_isLoggedIn.value) {
      Get.offAllNamed(Routes.MAIN);
    }
  }

  Future<String?> register(String username, String password, String confirmPassword) async {
    if (username.trim().isEmpty) return 'Username tidak boleh kosong.';
    if (password.isEmpty) return 'Password tidak boleh kosong.';
    if (password.length < 6) return 'Password minimal 6 karakter.';
    if (password != confirmPassword) return 'Konfirmasi password tidak cocok.';

    final prefs = await SharedPreferences.getInstance();
    final existingUser = prefs.getString('auth_username');
    if (existingUser != null && existingUser == username.trim()) {
      return 'Username sudah terdaftar. Silakan gunakan username lain.';
    }

    await prefs.setString('auth_username', username.trim());
    await prefs.setString('auth_password', password);
    return null;
  }

  Future<void> login(String username, String password) async {
    if (username.trim().isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final savedUsername = prefs.getString('auth_username');
      final savedPassword = prefs.getString('auth_password');

      if (savedUsername == null || savedPassword == null) {
        Get.snackbar('Error', 'Akun tidak ditemukan. Silakan daftar terlebih dahulu.');
        return;
      }
      if (savedUsername != username.trim() || savedPassword != password) {
        Get.snackbar('Error', 'Username atau password salah.');
        return;
      }

      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('auth_logged_in_user', username.trim());
      
      _isLoggedIn.value = true;
      _username.value = username.trim();
      
      Get.offAllNamed(Routes.MAIN);
    } else {
      Get.snackbar('Error', 'Username and password cannot be empty');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('auth_logged_in_user');
    
    _isLoggedIn.value = false;
    _username.value = '';
    
    Get.offAllNamed(Routes.LOGIN);
  }
}
