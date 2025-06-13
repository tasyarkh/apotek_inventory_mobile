import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class EditObatScreen extends StatefulWidget {
  final String kode_obat;
  final String nama_obat;
  final String stock;
  final String tgl_kadaluarsa;

  const EditObatScreen({
    super.key,
    required this.kode_obat,
    required this.nama_obat,
    required this.stock,
    required this.tgl_kadaluarsa,
  });

  @override
  _EditObatScreenState createState() => _EditObatScreenState();
}

class _EditObatScreenState extends State<EditObatScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaObatController;
  late TextEditingController _stockController;
  late TextEditingController _tglKadaluarsaController;

  @override
  void initState() {
    super.initState();
    _namaObatController = TextEditingController(text: widget.nama_obat);
    _stockController = TextEditingController(text: widget.stock);
    _tglKadaluarsaController =
        TextEditingController(text: widget.tgl_kadaluarsa);
  }

  @override
  void dispose() {
    _namaObatController.dispose();
    _stockController.dispose();
    _tglKadaluarsaController.dispose();
    super.dispose();
  }

  Future<void> _updateObat() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:80/api_apotek/daftar_obat/edit_daftar_obat.php'),
        body: {
          'kode_obat': widget.kode_obat,
          'nama_obat': _namaObatController.text,
          'stock': _stockController.text,
          'tgl_kadaluarsa': _tglKadaluarsaController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data obat berhasil diperbarui')),
          );

          Navigator.pop(context, true); // Sinyal berhasil
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Gagal memperbarui data')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal terhubung ke server')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }


  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.teal[400]!),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.teal[400]!),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Obat'),
        backgroundColor: Colors.teal[400]!,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaObatController,
                decoration: _buildInputDecoration('Nama Obat'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama Obat tidak boleh kosong' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _stockController,
                decoration: _buildInputDecoration('Stock'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Stock tidak boleh kosong' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _tglKadaluarsaController,
                decoration: _buildInputDecoration('Tanggal Kadaluarsa'),
                validator: (value) =>
                    value!.isEmpty ? 'Tanggal Kadaluarsa tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400]!,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: _updateObat,
                child: const Text('Perbarui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
