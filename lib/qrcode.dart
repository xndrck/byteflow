import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  bool isScanning = true;
  String? scannedData;
  late AnimationController _controller;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (isScanning && capture.barcodes.isNotEmpty) {
      setState(() {
        isScanning = false;
        scannedData = capture.barcodes.first.rawValue ?? "No Data";
      });

      // Reset scanning effect after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          isScanning = true;
          scannedData = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("QR Scanner", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // QR Scanner
          MobileScanner(onDetect: _onDetect),

          // Frosted Glass Effect
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Scanning UI
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // QR Code Frame
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Frame Glow
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueAccent, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),

                  // Scanning Line
                  AnimatedBuilder(
                    animation: _scanAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: _scanAnimation.value * 230,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: 5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent, Colors.cyan],
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Display Scanned QR Link
              scannedData != null
                  ? Column(
                      children: [
                        Text(
                          "Scanned QR Code:",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            scannedData!,
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      "Align the QR code within the frame",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
