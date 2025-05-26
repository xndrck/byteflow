import 'package:byte_flow/views/authenticated%20pages/receive_connect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:byte_flow/main.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage>
    with TickerProviderStateMixin {
  late AnimationController _radarController;
  late Animation<double> _radarScaleAnimation;
  late Animation<double> _radarOpacityAnimation;

  late AnimationController _iconController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();

    // Radar effect animation (same as SendDashboard)
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _radarScaleAnimation = Tween<double>(begin: 1, end: 1.4).animate(
      CurvedAnimation(parent: _radarController, curve: Curves.easeOut),
    );

    _radarOpacityAnimation = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(parent: _radarController, curve: Curves.easeOut),
    );

    // Floating animation for bottom container icons
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _iconAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _radarController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? Colors.white
          : ThemeProvider.darkBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'lib/icons/ai.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          'Receive Now!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: themeProvider.textColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 330,
                  height: 350,
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
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Receive',
                              style: TextStyle(
                                  color: themeProvider.containerTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Receive files with friends in quick ways!",
                          style: TextStyle(
                              color: themeProvider.containerTextColor),
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Radar effect behind button (Copied from SendDashboard)
                            AnimatedBuilder(
                              animation: _radarController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _radarScaleAnimation.value,
                                  child: Opacity(
                                    opacity: _radarOpacityAnimation.value,
                                    child: Container(
                                      width: 210,
                                      height: 210,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: themeProvider.containerTextColor
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // "Connect with Friends" button
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReceiveConnect()),
                                );
                              },
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: themeProvider.containerTextColor,
                                      width: 5),
                                  color:
                                      themeProvider.themeMode == ThemeMode.light
                                          ? Colors.blueAccent.withOpacity(0.8)
                                          : ThemeProvider.darkSecondaryColor
                                              .withOpacity(0.8),
                                ),
                                child: Center(
                                  child: Text(
                                    'CONNECT WITH FRIENDS',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeProvider.containerTextColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
                  width: 330,
                  height: 270,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: themeProvider.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          "Click 'Connect with Friends' to receive files seamlessly!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: themeProvider.containerTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _iconAnimation,
                            builder: (context, child) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.translate(
                                    offset: Offset(0, -_iconAnimation.value),
                                    child: Icon(Icons.cloud_download,
                                        size: 80,
                                        color:
                                            themeProvider.containerTextColor),
                                  ),
                                  SizedBox(height: 10),
                                  Transform.translate(
                                    offset: Offset(0, _iconAnimation.value),
                                    child: Icon(Icons.smartphone,
                                        size: 80,
                                        color:
                                            themeProvider.containerTextColor),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
