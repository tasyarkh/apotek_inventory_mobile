import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ganti dengan gambar ilustrasi atau logo lainnya
            Image.asset(
              'assets/images/welcome.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 40),
            Text(
              'Selamat Datang di Aplikasi Apotek',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Kelola inventaris apotek Anda dengan mudah dan efisien.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Mulai'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
