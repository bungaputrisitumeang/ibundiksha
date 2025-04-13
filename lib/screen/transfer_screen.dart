import 'package:flutter/material.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Halaman Transfer"),),
      body: Center( 
        child: Text('Halaman Transfer Saldo'),
      ),
    );
  }
}