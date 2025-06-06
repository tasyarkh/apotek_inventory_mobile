import 'package:flutter/material.dart';
import 'beranda.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN RM APPS',
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12),
          children: [
            Image.asset(
              'images/login.png',
              height: 200,
              fit: BoxFit.fill,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock_clock_outlined),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Beranda()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, 
                foregroundColor: Colors.white,  // Warna teks
                padding: const EdgeInsets.symmetric(vertical: 16), // Tinggi tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // Tidak terlalu rounded
                ),
              ),
              child: const Text('Login'),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
