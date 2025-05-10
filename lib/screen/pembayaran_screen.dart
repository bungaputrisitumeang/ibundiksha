import 'package:flutter/material.dart';
import 'package:ibundiksha/screen/pembayaran_peminjaman_screen.dart';
import 'package:ibundiksha/screen/pembayaran_tagihan_screen.dart';

class PembayaranScreen extends StatelessWidget {
  final int saldo;
  final Function(int) onPembayaran;
  const PembayaranScreen({
    super.key,
    required this.saldo,
    required this.onPembayaran,
  });
  // const PembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Pilih Jenis Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Tombol pembayaran tagihan
            ElevatedButton.icon(
              icon: const Icon(Icons.receipt_long),
              label: const Text('Pembayaran Tagihan'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PembayaranTagihanScreen(
                          saldo: saldo,
                          onPembayaran: onPembayaran,
                        ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Tombol pembayaran peminjaman
            ElevatedButton.icon(
              icon: const Icon(Icons.money_off),
              label: const Text('Pembayaran Peminjaman'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PembayaranPeminjamanScreen(
                          saldo: saldo,
                          onPembayaran: onPembayaran,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
