import 'package:flutter/material.dart';

class InfoPopupWidget extends StatefulWidget {
  @override
  _InfoPopupWidgetState createState() => _InfoPopupWidgetState();
}

class _InfoPopupWidgetState extends State<InfoPopupWidget> {
  bool showInfo = true;

  @override
  void initState() {
    super.initState();

    // Sembunyikan setelah 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showInfo = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return showInfo
        ? Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey[200],
            child: Column(
              children: const [
                Text(
                  'Informasi Tambahan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Untuk informasi lebih lanjut, silahkan hubungi customer service kami.'),
              ],
            ),
          )
        : const SizedBox(); // Kosong setelah menghilang
  }
}
