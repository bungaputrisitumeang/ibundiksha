import 'package:flutter/material.dart';
import 'package:ibundiksha/widget/card_saldo.dart';
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
      body: CardSaldo(formattedSaldo: formattedSaldo),
    );
  }
}
