import 'package:flutter/material.dart';

class CardSaldo extends StatelessWidget {
  const CardSaldo({
    super.key,
    required this.formattedSaldo,
  });

  final String formattedSaldo;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}