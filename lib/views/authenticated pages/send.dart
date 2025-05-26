import 'package:byte_flow/views/authenticated%20pages/send_connect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:byte_flow/main.dart';

class SendDashboard extends StatefulWidget {
  const SendDashboard({super.key});

  @override
  State<SendDashboard> createState() => _SendDashboardState();
}

class _SendDashboardState extends State<SendDashboard>
    with TickerProviderStateMixin {
  late AnimationController _deviceController;
  late Animation<double> _deviceAnimation;

  late AnimationController _radarController;
  late Animation<double> _radarScaleAnimation;
  late Animation<double> _radarOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // Floating smartphones animation
    _deviceController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _deviceAnimation = Tween<double>(begin: -30, end: 30).animate(
      CurvedAnimation(parent: _deviceController, curve: Curves.easeInOut),
    );

    // Radar effect for "Connect with Friends" button
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
  }

  @override
  void dispose() {
    _deviceController.dispose();
    _radarController.dispose();
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
                          'Send Now!',
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
                              'Send',
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
                          "Send files with friends in quick ways!",
                          style: TextStyle(
                              color: themeProvider.containerTextColor),
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Radar effect behind button
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
                            // Button with text
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SendConnect()),
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
                          "Click 'Connect with Friends' to experience fast and easy file sharing!",
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
                            animation: _deviceAnimation,
                            builder: (context, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.translate(
                                    offset: Offset(_deviceAnimation.value, 0),
                                    child: Icon(Icons.smartphone,
                                        size: 80,
                                        color:
                                            themeProvider.containerTextColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Icon(Icons.wifi,
                                        size: 40,
                                        color: themeProvider.containerTextColor
                                            .withOpacity(0.7)),
                                  ),
                                  Transform.translate(
                                    offset: Offset(-_deviceAnimation.value, 0),
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
