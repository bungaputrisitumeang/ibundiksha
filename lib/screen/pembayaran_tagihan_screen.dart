import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PembayaranTagihanScreen extends StatefulWidget {
  final int saldo;
  final Function(int) onPembayaran;
  const PembayaranTagihanScreen({super.key, required this.saldo, required this.onPembayaran});

  @override
  State<PembayaranTagihanScreen> createState() => _PembayaranTagihanScreenState();
}

class _PembayaranTagihanScreenState extends State<PembayaranTagihanScreen> {
  final Map<String, int> tagihanMap = {
    'Listrik': 75000,
    'Air': 50000,
    'Internet': 100000,
    'TV Kabel': 85000,
  };

  String? _selectedTagihan;
  int _jumlahTagihan = 0;
  late int saldoSekarang;
  final TextEditingController _nomorPelangganController = TextEditingController();

  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    saldoSekarang = widget.saldo;
  }
  void _resetForm() {
    setState(() {
      _selectedTagihan = null;
      _jumlahTagihan = 0;
      _nomorPelangganController.clear();
    });
  }

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 300,
          height: 200,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Tutup'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  } 

  void _bayarTagihan() {
    if (_selectedTagihan != null && _nomorPelangganController.text.isNotEmpty && saldoSekarang >= _jumlahTagihan) {
      int sisaSaldo = saldoSekarang - _jumlahTagihan;
      widget.onPembayaran(sisaSaldo);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Transaksi Berhasil'),
          content: Text('Rp ${NumberFormat.decimalPattern('id').format(_jumlahTagihan)} telah dibayarkan'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pop(context); // Kembali ke HomeScreen
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
       _showPopup('Mohon lengkapi semua data sebelum melakukan pembayaran.');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedSaldo = formatCurrency.format(widget.saldo);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Tagihan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Saldo Anda:', style: TextStyle(fontSize: 16)),
            Text(formattedSaldo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            const Text('Jenis Tagihan', style: TextStyle(fontSize: 16)),
            DropdownButtonFormField<String>(
              value: _selectedTagihan,
              items: tagihanMap.keys.map((tagihan) {
                return DropdownMenuItem(value: tagihan, child: Text(tagihan));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTagihan = value;
                  _jumlahTagihan = tagihanMap[value] ?? 0;
                });
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),

            const Text('Jumlah Tagihan', style: TextStyle(fontSize: 16)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(formatCurrency.format(_jumlahTagihan)),
            ),
            const SizedBox(height: 16),

            const Text('Nomor Pelanggan', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _nomorPelangganController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Masukkan nomor pelanggan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: _resetForm,
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: _bayarTagihan,
                  child: const Text('Bayar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
