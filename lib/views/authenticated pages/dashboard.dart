import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:byte_flow/main.dart';
import 'package:byte_flow/qrcode.dart';
import 'package:byte_flow/views/authenticated%20pages/receive.dart';
import 'package:byte_flow/views/authenticated%20pages/send.dart';
import 'package:byte_flow/views/authenticated%20pages/web.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();

    // Pulse animation controller
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_lastBackPressed == null ||
        DateTime.now().difference(_lastBackPressed!) > Duration(seconds: 2)) {
      _lastBackPressed = DateTime.now();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Press back again to exit',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: ThemeProvider.lightPrimaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return false;
    }
    return true;
  }

  void _showInfoDialog(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'About ByteFlow',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ByteFlow is a fast and secure file transfer app that allows you to:',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            _buildInfoItem(
              icon: Icons.send,
              text: 'Send files quickly to nearby devices',
              themeProvider: themeProvider,
            ),
            _buildInfoItem(
              icon: Icons.download,
              text: 'Receive files from friends',
              themeProvider: themeProvider,
            ),
            _buildInfoItem(
              icon: Icons.web,
              text: 'Share files through web interface',
              themeProvider: themeProvider,
            ),
            _buildInfoItem(
              icon: Icons.qr_code,
              text: 'Connect using QR codes',
              themeProvider: themeProvider,
            ),
          ],
        ),
        backgroundColor: themeProvider.gradientColors[0],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Got it!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String text,
    required ThemeProvider themeProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarButton({
    required String label,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        double scale = 1.0 + (_pulseController.value * 0.15);
        double opacity = 1.0 - (_pulseController.value * 0.5);

        return GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: opacity,
                child: Container(
                  width: 140 * scale,
                  height: 140 * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imagePath, width: 30),
                    SizedBox(height: 5),
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "ByteFlow",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: themeProvider.themeMode == ThemeMode.light
              ? Colors.white
              : ThemeProvider.darkBackgroundColor,
          iconTheme: IconThemeData(color: themeProvider.textColor),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => _showInfoDialog(context, themeProvider),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Image.asset(
                        'lib/icons/ai.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Hello',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeProvider.textColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Jim Shendrick!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: themeProvider.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: ClipOval(
                        child: GestureDetector(
                          onTap: () async {
                            String? scannedResult = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QRScannerScreen()),
                            );

                            if (scannedResult != null) {
                              print("Scanned QR Code: $scannedResult");
                            }
                          },
                          child: Icon(Icons.qr_code_scanner,
                              size: 70, color: themeProvider.textColor),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // First Container - File Transfer
                Center(
                  child: Container(
                    width: 330,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: themeProvider.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'File Transfer',
                                style: TextStyle(
                                    color: themeProvider.containerTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  var themeProvider =
                                      Provider.of<ThemeProvider>(context,
                                          listen: false);
                                  themeProvider.toggleTheme();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Provider.of<ThemeProvider>(context)
                                                  .themeMode ==
                                              ThemeMode.light
                                          ? Icons.dark_mode
                                          : Icons.light_mode,
                                      size: 25,
                                      color: themeProvider.containerTextColor,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              "Transfer files with friends in quick ways!",
                              style: TextStyle(
                                  color: themeProvider.containerTextColor)),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildRadarButton(
                              label: "Send",
                              imagePath: 'lib/icons/sendfile.png',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SendDashboard()));
                              },
                            ),
                            _buildRadarButton(
                              label: "Receive",
                              imagePath: 'lib/icons/in.png',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReceivePage()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Second Container - Web Share
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Web()),
                      );
                    },
                    child: Container(
                      width: 330,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: themeProvider.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset('lib/icons/rocket.png',
                                width: 70, height: 70),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Text('WEB SHARE',
                                    style: TextStyle(
                                        color: themeProvider.containerTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                    'Now, there are easier ways to\ntransfer files with a browser.',
                                    style: TextStyle(
                                        color:
                                            themeProvider.containerTextColor)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 330,
                  height: 120,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: themeProvider.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Friends / Devices',
                          style: TextStyle(
                              fontSize: 15,
                              color: themeProvider.containerTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              child: ClipOval(
                                child: Image.asset(
                                  'lib/photos/jim.jpg',
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              child: ClipOval(
                                child: Image.asset(
                                  'lib/photos/jim1.jpg',
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              child: ClipOval(
                                child: Image.asset(
                                  'lib/photos/jim3.jpg',
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 60,
                              child: ClipOval(
                                child: Image.asset(
                                  'lib/photos/jim2.jpg',
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 80,
                              child: ClipOval(
                                child: Image.asset(
                                  'lib/photos/jim5.JPG',
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 100,
                              child: CircleAvatar(
                                backgroundColor:
                                    themeProvider.themeMode == ThemeMode.light
                                        ? ThemeProvider.lightSecondaryColor
                                        : ThemeProvider.darkSecondaryColor,
                                radius: 25,
                                child: Icon(
                                  Icons.plus_one,
                                  size: 40,
                                  color: themeProvider.containerTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 330,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: themeProvider.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
