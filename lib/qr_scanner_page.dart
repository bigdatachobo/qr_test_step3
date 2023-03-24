import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'database.dart';
import 'empty_space.dart';
import 'home_page.dart';

class QRScannerPage extends StatefulWidget {
  final bool? isInbound;
  final bool isMoving;
  final String? selectedLocationKey;

  QRScannerPage({
    required this.isInbound,
    this.isMoving = false,
    this.selectedLocationKey,
  });

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  QRViewController? _controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Timer? _timer;
  bool _isQRCodeDetected = false;

  final RegExp pattern = RegExp(r'^[A-Z]\d{5}_\d{10}$');

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // QR 코드가 스캔 되고 이전에 표시된 경고 대화 상자가 없는 경우
      if (!_isQRCodeDetected && scanData.code != null) {
        // QR 코드가 정규식 패턴과 일치 하는 경우
        if (pattern.hasMatch(scanData.code!)) {
          _isQRCodeDetected = true;
          _controller?.pauseCamera();
          if (widget.isMoving) {
            processMove(context, scanData.code!);
          } else {
            processQRCode(context, scanData.code!, widget.isInbound);
          }
        } else {
          // 이전에 표시된 경고 대화 상자가 없는 경우
          if (!_isQRCodeDetected) {
            // 경고 대화 상자를 표시 중임을 나타내기 위해 _isQRCodeDetected를 true로 설정
            _isQRCodeDetected = true;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Invalid code format'),
                content: const Text('The code must be \nin the format of \n"B00000_0000000000".'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _controller?.resumeCamera();
                      // 경고 대화상자를 닫은 후, _isQRCodeDetected를 false로 설정하여 다음 경고 대화상자를 표시할 수 있게 함
                      _isQRCodeDetected = false;
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      }
    });
  }

  Future<void> processMove(BuildContext context, String code) async {
    // Get empty spaces
    final emptySpaces = await getEmptySpaces();
    if (emptySpaces.isEmpty) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('No empty spaces available.'),
              actions: [
              TextButton(
              onPressed: () => Navigator.of(context).pop(),

                child: const Text('OK'),
              ),
              ],
          ),
      );
    } else {
      // Show empty spaces and let the user choose a new location
      final newLocationKey = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmptySpacePage(),
        ),
      );
      if (newLocationKey != null) {
        await moveItem(code, newLocationKey);
        Navigator.of(context).pop(true);
      } else {
        _controller?.resumeCamera();
        _isQRCodeDetected = false;
      }
    }
  }

  Future<void> processQRCode(BuildContext context, String code, bool? isInbound) async {
    if (isInbound == true) {
      await addOrUpdateItem(code, widget.selectedLocationKey!);
    } else if( isInbound == false) {
      await setItemAsOutbound(code);
    }
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Center(
            child: SpinKitRing(
              color: Theme.of(context).primaryColor,
              lineWidth: 3,
            ),
          ),
        ],
      ),
    );
  }
}
