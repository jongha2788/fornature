import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrcodeScanner extends StatefulWidget {
  @override
  _QrcodeScannerState createState() => _QrcodeScannerState();
}

class _QrcodeScannerState extends State<QrcodeScanner> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _outputController;

  @override
  initState() {
    super.initState();
    this._outputController = new TextEditingController();
  }

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
        title: Text('QR 스캐너'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: this._outputController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.wrap_text),
                    hintText: 'QR 값이 표시됩니다.',
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                this._buttonGroup( context ),
                SizedBox(height: 70),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buttonGroup(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/qr.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: () async {
                bool snackbarflag = await _scanPhoto();
                SnackBar snackBar;
                if (snackbarflag == true) {
                  print("성공");
                   snackBar = new SnackBar(
                           content: new Text('제로웨이스트 매장을 방문하여, 1회 방문 기록이 추가되었습니다.'));
                                Scaffold.of(context).showSnackBar(snackBar);
                }
                 else {
                  print("실패");
                  snackBar = new SnackBar(
                                    content:
                                        new Text('해당 QR 코드가 아닙니다. 다시 시도해주세요'));
                                Scaffold.of(context).showSnackBar(snackBar);

                }
              },
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/qr.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan Photo")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      this._outputController.text = barcode;
    }
  }

  Future<bool> _scanPhoto() async {
    await Permission.storage.request();
    String barcode = await scanner.scanPhoto();
    this._outputController.text = barcode;
    if (this._outputController.text == null)
      return false;
    else {
      if (this._outputController.text == "chgodrlf") return true;
    }
    return false;
  }


  Future _scanBytes() async {
    File _image;
    final picker = ImagePicker();
    final file = await picker.getImage(source: ImageSource.camera);
    if (file == null) return;
    _image = File(file.path);
    Uint8List bytes = _image.readAsBytesSync();
    String barcode = await scanner.scanBytes(bytes);
    this._outputController.text = barcode;
  }
}
