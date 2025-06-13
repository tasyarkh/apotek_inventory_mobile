import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buat Akun',
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
              'images/register.png',
              height: 300,
              fit: BoxFit.fill,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Nama Lengkap",
                prefixIcon: Icon(Icons.account_circle_outlined),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "No. Hp",
                prefixIcon: Icon(Icons.phone),
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
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF68A77C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Registrasi'),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
