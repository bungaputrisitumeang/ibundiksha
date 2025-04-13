import 'package:flutter/material.dart';
import 'package:ibundiksha/screen/saldo_screen.dart';
import 'package:ibundiksha/screen/transfer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue[900],
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Koperasi Undiksha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.menu, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nasabah',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Bunga Putri Situmeang'),
                          SizedBox(height: 5),
                          Text(
                            'Total Saldo Anda',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                _isVisible ? 'Rp. 82.200.000' : 'Rp. ******',
                                style: TextStyle(fontSize: 20),
                              ),
                              // SizedBox(width: 10),
                              IconButton(
                                icon: Icon(
                                  _isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                          // Text('Rp. 1.200.0000'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildMenuItem(Icons.account_balance_wallet, 'Cek Saldo', const SaldoScreen()),
                  _buildMenuItem(Icons.swap_horiz, 'Transfer', const TransferScreen() ),
                  _buildMenuItem(Icons.savings, 'Deposito', const TransferScreen()),
                  _buildMenuItem(Icons.payment, 'Pembayaran', const TransferScreen()),
                  _buildMenuItem(Icons.attach_money, 'Pinjaman', const TransferScreen()),
                  _buildMenuItem(Icons.history, 'Mutasi', const TransferScreen()),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Column(
                children: [
                  Text('Butuh Bantuan?'),
                  Text(
                    '0878-1234-1024',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
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
        SizedBox(height: 5),
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
        if (label.isNotEmpty) SizedBox(height: 5),
        if (label.isNotEmpty) Text(label),
      ],
    );
  }
}
