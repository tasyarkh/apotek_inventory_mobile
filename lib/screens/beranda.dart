import 'package:flutter/material.dart';
import 'package:inv_apt_mobile/pemasok_obat/home.dart';
import 'package:inv_apt_mobile/stock_obat_in_out/home.dart';
import 'package:inv_apt_mobile/pelanggan/home.dart';
import 'package:inv_apt_mobile/staf_apotek/home.dart';
import 'package:inv_apt_mobile/daftar_obat/home.dart';
import 'package:inv_apt_mobile/stock_obat_view_search/home.dart';
import 'package:inv_apt_mobile/screens/splash.dart';
import 'profile_page.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('images/avatar.jpg'), // Ganti dengan path asset kamu
                radius: 18,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
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
                        MaterialPageRoute(
                            builder: (_) => const DaftarObatHome()),
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
                        MaterialPageRoute(
                            builder: (_) => const PelangganHome()),
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
                        MaterialPageRoute(builder: (_) => const StafHome()),
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
                        MaterialPageRoute(builder: (_) => PemasokObatHome()),
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
                        MaterialPageRoute(
                            builder: (_) => const StockObatHome()),
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
                        MaterialPageRoute(
                            builder: (_) => const StockObatViewHome()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => SplashScreen()),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
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
