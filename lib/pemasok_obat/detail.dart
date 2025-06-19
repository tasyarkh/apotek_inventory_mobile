import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit.dart';

class DetailPemasokScreen extends StatelessWidget {
  final Map<String, dynamic> pemasok;

  const DetailPemasokScreen({super.key, required this.pemasok});

  Future<void> _deletePemasok(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:80/api_apotek/pemasok_obat/delete_pemasok_obat.php'),
      body: {
        'kode_perusahaan': pemasok['kode_perusahaan'].toString(),
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pemasok berhasil dihapus')),
        );
        Navigator.pop(context, true); // Kembali ke home dan trigger refresh
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus pemasok: ${result['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus pemasok')),
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus pemasok ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal',
                  style: TextStyle(color: Colors.greenAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus',
                  style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.of(context).pop(); // tutup dialog
                _deletePemasok(context); // lanjutkan proses hapus
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pemasok', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Detail Pemasok',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text('Nama Perusahaan: ${pemasok['nama_perusahaan']}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Alamat Perusahaan: ${pemasok['alamat_perusahaan']}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Email: ${pemasok['email']}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('No Kontak: ${pemasok['no_kontak']}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[400],
                      ),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditPemasokScreen(pemasok: pemasok),
                          ),
                        );
                        if (result == true) {
                          Navigator.pop(context, true); // Kembali ke Home dan trigger refresh
                        }
                      },
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      icon: const Icon(Icons.delete),
                      label: const Text('Hapus'),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
