import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit.dart';

class DetailStafScreen extends StatelessWidget {
  final String id;
  final String nama;
  final String alamat;
  final String tglLahir;
  final String tmpLahir;
  final String noHp;

  const DetailStafScreen({super.key, 
    required this.id,
    required this.nama,
    required this.alamat,
    required this.tglLahir,
    required this.tmpLahir,
    required this.noHp,
  });

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus staf ini?'),
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
                Navigator.pop(context, true);
                _deleteStaf(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteStaf(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:80/api_apotek/staf_apotek/delete_staf.php'),
      body: {'id': id},
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dihapus')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus data: ${result['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Staf', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen[400]!,
        elevation: 0,
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
                _buildDetailRow('Nama', nama),
                const SizedBox(height: 12),
                _buildDetailRow('Alamat', alamat),
                const SizedBox(height: 12),
                _buildDetailRow('Tanggal Lahir', tglLahir),
                const SizedBox(height: 12),
                _buildDetailRow('Tempat Lahir', tmpLahir),
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
                          builder: (context) => EditStafScreen(
                            id: id,
                            nama: nama,
                            alamat: alamat,
                            tglLahir: tglLahir,
                            tmpLahir: tmpLahir,
                            noHp: noHp,
                          ),
                        ),
                      ).then((result) {
                        if (result == true) {
                          Navigator.pop(context, true); // Kembali ke Home dan trigger refresh
                        }
                      });

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen[400]!,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
