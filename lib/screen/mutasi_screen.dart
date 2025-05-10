import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MutasiScreen extends StatelessWidget {
  MutasiScreen({super.key});

  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final formatDate = DateFormat('dd MMM yyyy');

  // Dummy data mutasi
  final List<Map<String, dynamic>> mutasiList = [
    {'jenis': 'Peminjaman', 'nominal': 2000000, 'tanggal': DateTime(2025, 5, 1)},
    {'jenis': 'Pembayaran Tagihan', 'nominal': -75000, 'tanggal': DateTime(2025, 5, 2)},
    {'jenis': 'Transfer Masuk', 'nominal': 500000, 'tanggal': DateTime(2025, 5, 3)},
    {'jenis': 'Pembayaran Peminjaman', 'nominal': -500000, 'tanggal': DateTime(2025, 5, 4)},
    {'jenis': 'Transfer Keluar', 'nominal': -100000, 'tanggal': DateTime(2025, 5, 5)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutasi Transaksi'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: mutasiList.length,
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final mutasi = mutasiList[index];
          final isDebit = mutasi['nominal'] < 0;

          return ListTile(
            leading: Icon(
              isDebit ? Icons.arrow_upward : Icons.arrow_downward,
              color: isDebit ? Colors.red : Colors.green,
            ),
            title: Text(mutasi['jenis'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(formatDate.format(mutasi['tanggal'])),
            trailing: Text(
              formatCurrency.format(mutasi['nominal']),
              style: TextStyle(
                color: isDebit ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
