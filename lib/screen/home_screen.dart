import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transfer_screen.dart';
import 'cek_saldo_screen.dart'; // Pastikan import ini ada

String formatRupiah(int angka) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
  return formatter.format(angka).replaceAll(',', '.') + ',00';
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isVisible = false;
  int saldo = 82200000;

  String formatRupiah(int amount) {
    final formatter = NumberFormat.decimalPattern('id');
    return 'Rp ${formatter.format(amount)}';
  }

  void _updateSaldo(int newSaldo) {
    setState(() {
      saldo = newSaldo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Bagian header
            Container(
              width: double.infinity,
              color: Colors.blue[900],
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Koperasi Undiksha',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.menu, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            // Bagian informasi nasabah dan saldo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nasabah', style: TextStyle(fontWeight: FontWeight.bold)),
                          const Text('Bunga Putri Situmeang'),
                          const SizedBox(height: 5),
                          const Text('Total Saldo Anda', style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _isVisible ? 'Rp ${formatRupiah(saldo)}' : 'Rp ******',
                                style: const TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Grid menu
            Expanded(
  child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildMenuItem(Icons.account_balance_wallet, 'Cek Saldo', CekSaldoScreen(saldo: saldo)),
            _buildMenuItem(Icons.swap_horiz, 'Transfer', TransferScreen(saldoAwal: saldo, onTransfer: _updateSaldo)),
            _buildMenuItem(Icons.savings, 'Deposito', null),
            _buildMenuItem(Icons.payment, 'Pembayaran', null),
            _buildMenuItem(Icons.attach_money, 'Pinjaman', null),
            _buildMenuItem(Icons.history, 'Mutasi', null),
          ],
        ),
  ),
    
    ),
            
            // Bagian informasi tambahan
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Column(
                children: [
                  const Text('Informasi Tambahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Untuk informasi lebih lanjut, silahkan hubungi customer service kami.'),
                ],
              ),
            ),
            const SizedBox(height: 10)
,
            const Spacer(),
            
            // Bagian footer
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Column(
                children: [
                  const Text('Butuh Bantuan?'),
                  const Text('0878-1234-1024', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomMenuItem(Icons.settings, 'Setting'),
                      _buildBottomMenuItem(Icons.qr_code, ''),
                      _buildBottomMenuItem(Icons.person, 'Profile'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, Widget? destination) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue[900]),
          const SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildBottomMenuItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Colors.blue[900]),
        if (label.isNotEmpty) const SizedBox(height: 5),
        if (label.isNotEmpty) Text(label),
      ],
    );
  }
}
