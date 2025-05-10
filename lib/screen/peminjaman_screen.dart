import 'package:flutter/material.dart';
import 'package:ibundiksha/helper/currency_formatter.dart';
import 'package:intl/intl.dart';

class PeminjamanScreen extends StatefulWidget {
  final int saldo;
  final Function(int) onPeminjaman;
  const PeminjamanScreen({
    super.key,
    required this.saldo,
    required this.onPeminjaman,
  });
  // const PeminjamanScreen({super.key});

  @override
  State<PeminjamanScreen> createState() => _PeminjamanScreenState();
}

class _PeminjamanScreenState extends State<PeminjamanScreen> {
  final TextEditingController _nominalController = TextEditingController();
  String? selectedJangka;
  String jatuhTempo = '-';
  String estimasiBunga = '-';
  String totalPinjaman = '-';

  String getTanggalHariIni() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  void resetForm() {
    _nominalController.clear();
    setState(() {
      selectedJangka = null;
      jatuhTempo = '-';
      estimasiBunga = '-';
      totalPinjaman = '-';
    });
  }

  void updatePerhitungan() {
    final input = _nominalController.text.replaceAll('.', '');
    final nominal = int.tryParse(input) ?? 0;
    final bulan = int.tryParse(selectedJangka ?? '') ?? 0;

    final bunga = nominal * 0.05; // 5%
    final total = nominal + bunga;
    final tempo = DateTime.now().add(Duration(days: bulan * 30));

    setState(() {
      estimasiBunga = formatRupiah(bunga.toInt());
      totalPinjaman = formatRupiah(total.toInt());
      jatuhTempo = DateFormat('dd/MM/yyyy').format(tempo);
    });
  }

  String formatRupiah(int number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(number);
  }

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder:
          (context) => Center(
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
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Tutup'),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void _peminjaman() {
    int nominal =
        int.tryParse(_nominalController.text.replaceAll('.', '')) ?? 0;
    if (nominal < 10000) {
      _showPopup('Minimal peminjaman adalah Rp 10.000');
    } else {
      int sisaSaldo = widget.saldo + nominal;
      widget.onPeminjaman(sisaSaldo);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Peminjaman Berhasil'),
          content: Text('Rp ${NumberFormat.decimalPattern('id').format(nominal)} telah berhasil dipinjam'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Peminjaman')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Tanggal Hari Ini', style: TextStyle(fontSize: 16)),
            Text(getTanggalHariIni()),
            const SizedBox(height: 16),

            const Text('Nominal Peminjaman', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              inputFormatters: [CurrencyInputFormatter()],
              decoration: const InputDecoration(
                hintText: 'Masukkan jumlah peminjaman',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) {
                if (selectedJangka != null) updatePerhitungan();
              },
            ),
            const SizedBox(height: 16),

            const Text('Jangka Waktu', style: TextStyle(fontSize: 16)),
            DropdownButtonFormField<String>(
              value: selectedJangka,
              items: const [
                DropdownMenuItem(value: '1', child: Text('1 Bulan')),
                DropdownMenuItem(value: '3', child: Text('3 Bulan')),
                DropdownMenuItem(value: '6', child: Text('6 Bulan')),
                DropdownMenuItem(value: '12', child: Text('12 Bulan')),
              ],
              onChanged: (value) {
                selectedJangka = value;
                updatePerhitungan();
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),

            const Text('Jatuh Tempo', style: TextStyle(fontSize: 16)),
            Text(jatuhTempo),
            const SizedBox(height: 16),

            const Text('Estimasi Bunga (5%)', style: TextStyle(fontSize: 16)),
            Text(estimasiBunga),
            const SizedBox(height: 16),

            const Text('Total Peminjaman', style: TextStyle(fontSize: 16)),
            Text(totalPinjaman),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: resetForm,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _peminjaman();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Ajukan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
