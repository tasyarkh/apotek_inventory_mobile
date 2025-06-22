import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add.dart';
import 'detail.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class PemasokObatHome extends StatefulWidget {
  const PemasokObatHome({super.key});

  @override
  State<PemasokObatHome> createState() => _PemasokObatHomeState();
}

class _PemasokObatHomeState extends State<PemasokObatHome> {
  List pemasokList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPemasok();
  }

  Future<void> fetchPemasok() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:80/api_apotek/pemasok_obat/get_pemasok_obat.php'));

      if (response.statusCode == 200) {
        setState(() {
          pemasokList = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load pemasok');
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

  void _printPemasokList() async {
            final pdf = pw.Document();

            pdf.addPage(
              pw.MultiPage(
                build: (context) => [
                  pw.Text('Laporan Data Pemasok Apotek',
                      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 16),
                  pw.Table.fromTextArray(
                    headers: ['Perusahaan', 'Alamat', 'Email'],
                    data: pemasokList.map((pemasok) {
                      return [
                        pemasok['nama_perusahaan'] ?? '',
                        pemasok['alamat_perusahaan'] ?? '',
                        pemasok['email'] ?? '',
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DAFTAR PEMASOK OBAT 🏭',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue[400],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              _printPemasokList(); // Fungsi print
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: Colors.lightBlue[400]))
          : ListView.builder(
              itemCount: pemasokList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.lightBlue.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.lightBlue[700],
                      child: const Icon(Icons.location_city, color: Colors.white),
                    ),
                    title: Text(
                      pemasokList[index]['nama_perusahaan'],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.lightBlue[700]),
                    ),
                    subtitle: Text(
                      pemasokList[index]['no_kontak'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Colors.lightBlue[400]),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPemasokScreen(pemasok: pemasokList[index]),
                        ),
                      );
                      if (result == true) {
                        fetchPemasok(); // refresh otomatis setelah edit
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[400],
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPemasokScreen()),
          ).then((_) => fetchPemasok());
        },
      ),
    );
  }
}
