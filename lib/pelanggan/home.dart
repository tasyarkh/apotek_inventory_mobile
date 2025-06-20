import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add.dart';
import 'detail.dart';
import 'dart:convert';
import '../screens/beranda.dart';

class PelangganHome extends StatefulWidget {
  const PelangganHome({super.key});

  @override
  _PelangganHomeState createState() => _PelangganHomeState();
}

class _PelangganHomeState extends State<PelangganHome> {
  List pelangganList = [];
  bool isLoading = true;

  Future<void> fetchPelanggan() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:80/api_apotek/pelanggan/get_pelanggan.php'));

      if (response.statusCode == 200) {
        setState(() {
          pelangganList = json.decode(response.body);
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

  @override
  void initState() {
    super.initState();
    fetchPelanggan();
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
          'DATA PASIEN 👤',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.greenAccent[400]!,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: Colors.greenAccent[400]!),
            )
          : ListView.builder(
              itemCount: pelangganList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.greenAccent[100]!,
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
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    title: Text(
                      pelangganList[index]['nama'],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.green[800]),
                    ),
                    subtitle: Text(
                      pelangganList[index]['no_hp'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPelangganScreen(
                            id: pelangganList[index]['id'].toString(),
                            nama: pelangganList[index]['nama'],
                            alamat: pelangganList[index]['alamat'],
                            noHp: pelangganList[index]['no_hp'],
                          ),
                        ),
                      );

                      if (result == true) {
                        fetchPelanggan(); // 🔁 refresh data
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[400]!,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPelangganScreen()),
          ).then((value) {
            if (value == true) {
              fetchPelanggan(); // 🔁 refresh setelah tambah
            }
          });
        },
      ),
    );
  }
}
