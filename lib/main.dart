import 'package:flutter/material.dart';
import 'package:inv_apt_mobile/pemasok_obat/home.dart';
import 'stock_obat_in_out/home.dart';
import 'pelanggan/home.dart';
import 'staf_apotek/home.dart';
import 'daftar_obat/home.dart';
import 'stock_obat_view_search/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INVENTORY APOTEK RM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'APOTEK RAKYAT MANDIRI 🏥',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildMenuCard(
              context,
              icon: Icons.medical_services,
              title: 'Daftar Obat',
              color: Colors.teal[400]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DaftarObatHome()),
                );
              },
            ),
            _buildMenuCard(
              context,
              icon: Icons.people,
              title: 'Pasien',
              color: Colors.greenAccent[400]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PelangganHome()),
                );
              },
            ),
            _buildMenuCard(
              context,
              icon: Icons.person,
              title: 'Staf Apotek',
              color: Colors.lightGreen[400]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StafHome()),
                );
              },
            ),
            _buildMenuCard(
              context,
              icon: Icons.location_city_outlined,
              title: 'Supplier Obat',
              color: Colors.lightBlue[400]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PemasokObatHome()),
                );
              },
            ),
            _buildMenuCard(
              context,
              icon: Icons.medical_information_sharp,
              title: 'Stok Obat',
              color: Colors.redAccent[400]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StockObatHome()),
                );
              },
            ),
            _buildMenuCard(
              context,
              icon: Icons.manage_search,
              title: 'Cari & Lihat Stok Obat',
              color: Colors.purpleAccent[400]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StockObatViewHome()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        splashColor: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: color,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
