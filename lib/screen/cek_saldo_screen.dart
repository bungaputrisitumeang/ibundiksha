import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CekSaldoScreen extends StatelessWidget {
  final int saldo;

  const CekSaldoScreen({super.key, required this.saldo});

  @override
  Widget build(BuildContext context) {
    // Format saldo menjadi Rp x.xxx.xxx,00
    final formattedSaldo = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(saldo);

    return Scaffold(
      appBar: AppBar(title: const Text('Cek Saldo')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_balance_wallet, color: Colors.white, size: 40),
              const SizedBox(height: 10),
              const Text(
                'Total Saldo Anda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                formattedSaldo,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
