import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPelangganScreen extends StatefulWidget {
  const AddPelangganScreen({super.key});

  @override
  _AddPelangganScreenState createState() => _AddPelangganScreenState();
}

class _AddPelangganScreenState extends State<AddPelangganScreen> {
  late TextEditingController _namaController;
  late TextEditingController _alamatController;
  late TextEditingController _noHpController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController();
    _alamatController = TextEditingController();
    _noHpController = TextEditingController();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  Future<void> _addPelanggan() async {
    if (_namaController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _noHpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:80/api_apotek/pelanggan/add_pelanggan.php'),
      body: {
        'nama': _namaController.text,
        'alamat': _alamatController.text,
        'no_hp': _noHpController.text,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(responseData['success']
                ? 'Data berhasil ditambahkan'
                : 'Gagal menambahkan data')),
      );
      if (responseData['success']) Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menambahkan data')),
      );
    }
  }

  InputDecoration _buildInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.black),
      prefixIcon: Icon(icon, color: Colors.greenAccent[400]!),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent[400]!),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black54),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pelanggan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.greenAccent[400]!,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _namaController,
              decoration: _buildInputDecoration('Nama', Icons.person),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alamatController,
              decoration: _buildInputDecoration('Alamat', Icons.home),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noHpController,
              decoration: _buildInputDecoration('No HP', Icons.phone),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _addPelanggan,
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[400]!,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
