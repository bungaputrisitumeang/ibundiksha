import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Peminjaman {
  final DateTime jatuhTempo;
  final int jumlah;
  bool isSelected;

  Peminjaman({
    required this.jatuhTempo,
    required this.jumlah,
    this.isSelected = false,
  });
}

class PembayaranPeminjamanScreen extends StatefulWidget {
  final int saldo;
  final Function(int) onPembayaran;

  const PembayaranPeminjamanScreen({
    super.key,
    required this.saldo,
    required this.onPembayaran,
  });

  @override
  State<PembayaranPeminjamanScreen> createState() =>
      _PembayaranPeminjamanScreenState();
}

class _PembayaranPeminjamanScreenState
    extends State<PembayaranPeminjamanScreen> {
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  final formatDate = DateFormat('dd/MM/yyyy');

  late int saldoSekarang;

  List<Peminjaman> peminjamanList = [
    Peminjaman(
      jatuhTempo: DateTime.now().add(Duration(days: 7)),
      jumlah: 150000,
    ),
    Peminjaman(
      jatuhTempo: DateTime.now().add(Duration(days: 14)),
      jumlah: 200000,
    ),
    Peminjaman(
      jatuhTempo: DateTime.now().add(Duration(days: 21)),
      jumlah: 100000,
    ),
  ];

  @override
  void initState() {
    super.initState();
    saldoSekarang = widget.saldo;
  }

  void _bayarTerpilih() {
    final selectedList = peminjamanList.where((p) => p.isSelected).toList();

    if (selectedList.isEmpty) {
      _showPopup('Pilih minimal satu pinjaman untuk dibayar.');
      return;
    }

    int totalBayar = selectedList.fold(0, (sum, p) => sum + p.jumlah);

    if (totalBayar > saldoSekarang) {
      _showPopup('Saldo tidak cukup untuk membayar pinjaman terpilih.');
      return;
    }

    setState(() {
      saldoSekarang -= totalBayar;
      peminjamanList.removeWhere((p) => p.isSelected);
    });

    widget.onPembayaran(saldoSekarang);
    _showPopup('Pinjaman terpilih berhasil dibayar.');
  }

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (peminjamanList.isEmpty) Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedSaldo = formatCurrency.format(saldoSekarang);
    int totalTerpilih = peminjamanList
        .where((p) => p.isSelected)
        .fold(0, (sum, p) => sum + p.jumlah);

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran Peminjaman')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Saldo Anda:', style: TextStyle(fontSize: 16)),
            Text(
              formattedSaldo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text(
              'Pilih Pinjaman yang Akan Dibayar:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            if (peminjamanList.isEmpty)
              const Text('Tidak ada pinjaman yang perlu dibayar.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: peminjamanList.length,
                  itemBuilder: (context, index) {
                    final pinjam = peminjamanList[index];
                    return Card(
                      child: CheckboxListTile(
                        title: Text(
                          'Jatuh Tempo: ${formatDate.format(pinjam.jatuhTempo)}',
                        ),
                        subtitle: Text(
                          'Jumlah: ${formatCurrency.format(pinjam.jumlah)}',
                        ),
                        value: pinjam.isSelected,
                        onChanged: (value) {
                          setState(() {
                            pinjam.isSelected = value ?? false;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

            Text(
              'Total Terpilih: ${formatCurrency.format(totalTerpilih)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  peminjamanList.any((p) => p.isSelected)
                      ? _bayarTerpilih
                      : null,
              child: const Text('Bayar Terpilih'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
