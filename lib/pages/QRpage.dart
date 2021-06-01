import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class QrcodeScanner extends StatefulWidget {
  @override
  _QrcodeScannerState createState() => _QrcodeScannerState();
}

class _QrcodeScannerState extends State<QrcodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Feather.x),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          title: Text('QR SCANNER'),
          centerTitle: true,
        ),
       body : Center(child: Text("Mapping"),),
       ) ;
  }
}