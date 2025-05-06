import 'package:flutter/material.dart';

class CekSaldoScreen extends StatelessWidget {
  final int saldo;

  const CekSaldoScreen({super.key, required this.saldo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Saldo')),
      body: Center(
        child: Text('Saldo Anda: Rp $saldo',
            style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
