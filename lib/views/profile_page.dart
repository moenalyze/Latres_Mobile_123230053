import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE8E9),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.pink),
            const SizedBox(height: 16),
            Center(
              child: Obx(
                () => Text(
                  _authController.username,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Kesan:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Praktikum Mobile IF-B seru, aslabnya baik. Bismillah A',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Pesan:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Semoga aslabnya naik gaji dan sejahtera hidupnya',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Konfirmasi Logout',
                  middleText: 'Apakah Anda yakin ingin keluar?',
                  textConfirm: 'Ya',
                  textCancel: 'Batal',
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.red,
                  cancelTextColor: Colors.red,
                  onConfirm: () {
                    _authController.logout();
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
