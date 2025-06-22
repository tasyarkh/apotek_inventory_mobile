import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add.dart';
import 'detail.dart';
import 'dart:convert';
import '../screens/beranda.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DaftarObatHome extends StatefulWidget {
  const DaftarObatHome({super.key});

  @override
  _DaftarObatHomeState createState() => _DaftarObatHomeState();
}

class _DaftarObatHomeState extends State<DaftarObatHome> {
  List daftarObatList = [];
  bool isLoading = true;

  Future<void> fetchDaftarObat() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:80/api_apotek/daftar_obat/get_daftar_obat.php'));

      if (response.statusCode == 200) {
        setState(() {
          daftarObatList = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  void _printObatList() async {
            final pdf = pw.Document();

            pdf.addPage(
              pw.MultiPage(
                build: (context) => [
                  pw.Text('Laporan Data Obat Apotek',
                      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 16),
                  pw.Table.fromTextArray(
                    headers: ['Nama Obat', 'Stok', 'Kadaluarsa'],
                    data: daftarObatList.map((obat) {
                      return [
                        obat['nama_obat'] ?? '',
                        obat['stock'] ?? '',
                        obat['tgl_kadaluarsa'] ?? '',
                      ];
                    }).toList(),
                  ),
                ],
              ),
            );

            await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async => pdf.save(),
            );
          }

  @override
  void initState() {
    super.initState();
    fetchDaftarObat();
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
              MaterialPageRoute(builder: (_) => const Beranda()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'DAFTAR OBAT 💊',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[400]!,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              _printObatList(); // Fungsi print
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.teal[400]!))
          : ListView.builder(
              itemCount: daftarObatList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.teal[100]!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.medical_services, color: Colors.black87),
                    ),
                    title: Text(
                      daftarObatList[index]['nama_obat'],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.green[800]),
                    ),
                    subtitle: Text(
                      'Stock: ${daftarObatList[index]['stock']}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    trailing: Text(
                      'Exp: ${daftarObatList[index]['tgl_kadaluarsa']}',
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailObatScreen(
                            kode_obat: daftarObatList[index]['kode_obat'].toString(),
                            nama_obat: daftarObatList[index]['nama_obat'],
                            stock: daftarObatList[index]['stock'].toString(),
                            tgl_kadaluarsa: daftarObatList[index]['tgl_kadaluarsa'],
                          ),
                        ),
                      );

                      if (result == true) {
                        fetchDaftarObat(); // refresh setelah edit/hapus
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[400]!,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddObatScreen()),
          );

          if (result == true) {
            fetchDaftarObat(); // refresh setelah tambah
          }
        },
      ),
    );
  }
}
