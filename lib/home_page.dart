import 'package:flutter/material.dart';
import 'qr_scanner_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRScannerPage(
                          isInbound: true,
                        ),
                      ),
                    );
                  },
                  child: const Text('입고'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRScannerPage(
                          isInbound: false,
                        ),
                      ),
                    );
                  },
                  child: const Text('출고'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRScannerPage(
                      isInbound: null,
                    ),
                  ),
                );
              },
              child: const Text('이동'),
            ),
          ],
        ),
      ),
    );
  }
}
