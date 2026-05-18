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
    _username.value = prefs.getString('username') ?? '';
    
    if (_isLoggedIn.value) {
      Get.offAllNamed(Routes.MAIN);
    }
  }

  Future<void> login(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      
      _isLoggedIn.value = true;
      _username.value = username;
      
      Get.offAllNamed(Routes.MAIN);
    } else {
      Get.snackbar('Error', 'Username and password cannot be empty');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    _isLoggedIn.value = false;
    _username.value = '';
    
    Get.offAllNamed(Routes.LOGIN);
  }
}
