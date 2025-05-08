import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

String formatRupiah(int angka) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
  return formatter.format(angka).replaceAll(',', '.') + ',00';
}


class TransferScreen extends StatefulWidget {
  final int saldoAwal;
  final Function(int) onTransfer;

  const TransferScreen({super.key, required this.saldoAwal, required this.onTransfer});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _rekeningTujuanController = TextEditingController();
  final List<String> _bankList = [
    'Mandiri', 'BNI', 'BRI', 'BCA', 'BPD Bali', 'BSI', 'Danamon', 'SeaBank', 'Bank Jago', 'DANA', 'OVO', 'GOPAY', 'Jenius'
  ];
  String selectedBank = 'Mandiri';
  late int saldoSekarang;

  @override
  void initState() {
    super.initState();
    saldoSekarang = widget.saldoAwal;
  }

  String formatRupiah(int amount) {
  final formatter = NumberFormat.decimalPattern('id');
  return 'Rp ${formatter.format(amount)},00';
  }



  void _transfer() {
    int jumlahTransfer = int.tryParse(_controller.text) ?? 0;
    String nomorRekeningTujuan = _rekeningTujuanController.text.trim();

    if (nomorRekeningTujuan.isEmpty) {
      _showPopup('Nomor rekening tujuan tidak boleh kosong');
      return;
    }

    if (jumlahTransfer < 10000) {
      _showPopup('Minimal transfer adalah Rp 10.000');
    } else if (jumlahTransfer > saldoSekarang) {
      _showPopup('Saldo tidak cukup');
    } else {
      int sisaSaldo = saldoSekarang - jumlahTransfer;
      widget.onTransfer(sisaSaldo);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Transfer Berhasil'),
          content: Text('Rp ${NumberFormat.decimalPattern('id').format(jumlahTransfer)} telah ditransfer ke rekening $nomorRekeningTujuan dari bank $selectedBank'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transfer Saldo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo saat ini', style: TextStyle(fontSize: 16)),
            Text(formatRupiah(saldoSekarang), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedBank,
              items: _bankList.map((bank) {
                return DropdownMenuItem<String>(
                  value: bank,
                  child: Text(bank),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBank = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nama Bank',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _rekeningTujuanController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nomor Rekening Tujuan',
                border: OutlineInputBorder(),
              ),
            ),
             SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah transfer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _transfer,
                child: Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
