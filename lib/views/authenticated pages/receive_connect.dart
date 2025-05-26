import 'package:byte_flow/views/authenticated%20pages/dashboard.dart';
import 'package:byte_flow/views/authenticated%20pages/receive_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:byte_flow/main.dart';

class ReceiveConnect extends StatefulWidget {
  const ReceiveConnect({super.key});

  @override
  State<ReceiveConnect> createState() => _ReceiveConnectState();
}

class _ReceiveConnectState extends State<ReceiveConnect>
    with TickerProviderStateMixin {
  late AnimationController _rocketController;
  late Animation<double> _rocketAnimation;

  late AnimationController _radarController;
  late Animation<double> _radarScaleAnimation;
  late Animation<double> _radarOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // Rocket floating animation (now more subtle)
    _rocketController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _rocketAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _rocketController, curve: Curves.easeInOut),
    );

    // Radar animation (Contracting circles)
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _radarScaleAnimation = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(parent: _radarController, curve: Curves.easeIn),
    );

    _radarOpacityAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _radarController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _rocketController.dispose();
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Landing in Progress,Waiting for Sender!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: themeProvider.textColor,
                            ),
                          ),
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
                  height: 600,
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
                              'Rocket Thrusters: Connecting…',
                              style: TextStyle(
                                  color: themeProvider.containerTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(Icons.wifi,
                                size: 20,
                                color:
                                    themeProvider.themeMode == ThemeMode.light
                                        ? Colors.black45
                                        : Colors.white70),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Establish a connection to start receiving files.",
                          style: TextStyle(
                              color: themeProvider.containerTextColor),
                        ),
                      ),
                      SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _radarController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _radarScaleAnimation.value,
                                  child: Opacity(
                                    opacity: _radarOpacityAnimation.value,
                                    child: Container(
                                      width: 300,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: themeProvider
                                                .containerTextColor,
                                            width: 5),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: themeProvider.containerTextColor,
                                    width: 3),
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _rocketAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _rocketAnimation.value),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color:
                                              themeProvider.containerTextColor,
                                          width: 1),
                                    ),
                                    child: Icon(
                                      Icons.qr_code_2_rounded,
                                      size: 150,
                                      color: themeProvider.themeMode ==
                                              ThemeMode.light
                                          ? Colors.black87
                                          : themeProvider.containerTextColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 70),
                      Center(
                        child: Text(
                          "Ready to receive? Let's start the transfer!",
                          style: TextStyle(
                            color: themeProvider.containerTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReceiveProgress()),
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              child: Center(
                                child: Text(
                                  'See Progress',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardPage()),
                                (route) => false,
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              child: Center(
                                child: Text(
                                  'Back to Home',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
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
