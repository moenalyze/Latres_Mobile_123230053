import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.app_registration,
                    size: 100,
                    color: Colors.pink,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sign up to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 48),
                  TextFormField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.black54),
                      prefixIcon: const Icon(Icons.person_outline, color: Colors.pink),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.pink, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.pink.withOpacity(0.05),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Username tidak boleh kosong';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black54),
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.pink),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.pink, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.pink.withOpacity(0.05),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password tidak boleh kosong';
                      if (v.length < 6) return 'Password minimal 6 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(color: Colors.black54),
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.pink),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.pink, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.pink.withOpacity(0.05),
                    ),
                    validator: (v) {
                      if (v != _passwordController.text) return 'Konfirmasi password tidak cocok';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final error = await _authController.register(
                            _usernameController.text,
                            _passwordController.text,
                            _confirmPasswordController.text,
                          );
                          if (error != null) {
                            Get.snackbar('Error', error, backgroundColor: Colors.redAccent, colorText: Colors.white);
                          } else {
                            Get.snackbar('Success', 'Registrasi berhasil! Silakan login.', backgroundColor: Colors.green, colorText: Colors.white);
                            Get.offNamed(Routes.LOGIN);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () => Get.offNamed(Routes.LOGIN),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
