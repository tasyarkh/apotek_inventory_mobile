import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit.dart';
import 'package:inv_apt_mobile/pelanggan/home.dart';
class DetailPelangganScreen extends StatelessWidget {
  final String id;
  final String nama;
  final String alamat;
  final String noHp;

  const DetailPelangganScreen({
    super.key,
    required this.id,
    required this.nama,
    required this.alamat,
    required this.noHp,
  });

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content:
              const Text('Apakah Anda yakin ingin menghapus pelanggan ini?'),
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
                Navigator.pop(context, true); // Tutup dialog
                _deletePelanggan(context); // Panggil fungsi hapus
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePelanggan(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            "http://localhost:80/api_apotek/pelanggan/delete_pelanggan.php"),
        body: {
          'id': id.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          // Tampilkan notifikasi berhasil
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil dihapus')),
          );

          // Arahkan ke halaman Home dan hapus semua route sebelumnya
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PelangganHome()),
        );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal: ${data['message']}')),
          );
        }
      } else {
        print('Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const PelangganHome()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'DATA PASIEN 👤',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.greenAccent[400]!,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Nama', nama),
                const SizedBox(height: 12),
                _buildDetailRow('Alamat', alamat),
                const SizedBox(height: 12),
                _buildDetailRow('No HP', noHp),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPelangganScreen(
                              id: id,
                              nama: nama,
                              alamat: alamat,
                              noHp: noHp,
                            ),
                          ),
                        ).then((result) {
                          if (result == true) {
                            Navigator.pop(context, true); // ✅ Trigger refresh
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent[400]!,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () => _showDeleteConfirmationDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Hapus'),
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
