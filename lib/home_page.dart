import 'package:flutter/material.dart';
import 'qr_scanner_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.8 / 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRScannerPage(
                            isInbound: true,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue,
                      child: Text(
                        '입고',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRScannerPage(
                            isInbound: false,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.lightGreen,
                      child: Text(
                        '출고',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRScannerPage(
                      isInbound: null,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.redAccent[100],
                child: Text(
                  '이동',
                  style: TextStyle(
                    fontSize: screenWidth * 1.5 / 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
