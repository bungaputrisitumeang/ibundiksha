import 'package:flutter/material.dart';
import 'package:ibundiksha/helper/currency_formatter.dart';
import 'package:ibundiksha/widget/card_saldo.dart';
import 'package:intl/intl.dart';

String formatRupiah(int angka) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
  return formatter.format(angka).replaceAll(',', '.') + ',00';
}

class DepositoScreen extends StatefulWidget {
  final int saldo;
  final Function(int) onDeposito;

  const DepositoScreen({super.key, required this.saldo, required this.onDeposito});

  @override
  State<DepositoScreen> createState() => _DepositoScreenState();
}

class _DepositoScreenState extends State<DepositoScreen> {
  final TextEditingController _depositoController = TextEditingController();
  String? selectedPeriode;
  String estimasiJatuhTempo = '-';
  String estimasiBunga = '-';
  late int saldoSekarang;

  @override
  void initState() {
    super.initState();
    saldoSekarang = widget.saldo;
  }

  String formatRupiah(int number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(number);
  }

  void resetForm() {
    _depositoController.clear();
    setState(() {
      selectedPeriode = null;
      estimasiJatuhTempo = '-';
      estimasiBunga = '-';
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

  void _deposito() {
    int jumlahDeposito = int.tryParse(_depositoController.text) ?? 0;
    // String nomorRekeningTujuan = _rekeningTujuanController.text.trim();

    if (jumlahDeposito == 0) {
      _showPopup('Jumlah deposito tidak boleh kosong');
      return;
    }

    if (jumlahDeposito < 100000) {
      _showPopup('Minimal jumlah deposito adalah Rp 100.000');
    } else if (jumlahDeposito > saldoSekarang) {
      _showPopup('Saldo tidak cukup');
    } else {
      int sisaSaldo = saldoSekarang - jumlahDeposito;
      widget.onDeposito(sisaSaldo);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Transaksi Berhasil'),
          content: Text('Rp ${NumberFormat.decimalPattern('id').format(jumlahDeposito)} telah ditambahkan ke rekening Deposito'),
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
      appBar: AppBar(
        title: const Text('Deposito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CardSaldo(formattedSaldo: formatRupiah(saldoSekarang)),
            const SizedBox(height: 16),

            const Text('Tambah Deposito', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _depositoController,
              keyboardType: TextInputType.number,
              inputFormatters: [CurrencyInputFormatter()],
              decoration: const InputDecoration(
                hintText: 'Masukkan jumlah deposito',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {
                if (selectedPeriode != null) _updateEstimasi();
              }),
            ),
            const SizedBox(height: 16),

            const Text('Pilih Jangka Waktu', style: TextStyle(fontSize: 16)),
            DropdownButtonFormField<String>(
              value: selectedPeriode,
              items: const [
                DropdownMenuItem(value: '1', child: Text('1 Bulan')),
                DropdownMenuItem(value: '3', child: Text('3 Bulan')),
                DropdownMenuItem(value: '6', child: Text('6 Bulan')),
                DropdownMenuItem(value: '12', child: Text('12 Bulan')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedPeriode = value;
                  _updateEstimasi();
                });
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),

            const Text('Estimasi Tanggal Jatuh Tempo:', style: TextStyle(fontSize: 16)),
            Text(estimasiJatuhTempo),
            const SizedBox(height: 16),

            const Text('Estimasi Bunga:', style: TextStyle(fontSize: 16)),
            Text(estimasiBunga),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: resetForm,
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    _deposito();
                  },
                  child: const Text('Buka Deposito'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  

  void _updateEstimasi() {
    if (_depositoController.text.isEmpty || selectedPeriode == null) {
      return;
    }

    final jumlah = int.tryParse(_depositoController.text.replaceAll('.', '')) ?? 0;
    final bulan = int.tryParse(selectedPeriode!) ?? 0;

    final jatuhTempo = DateTime.now().add(Duration(days: 30 * bulan));
    estimasiJatuhTempo = DateFormat('dd/MM/yyyy').format(jatuhTempo);

    final bunga = (jumlah * 0.05 * bulan) / 12; // estimasi bunga 4% per tahun
    estimasiBunga = formatRupiah(bunga.roundToDouble().toInt());
  }
}
