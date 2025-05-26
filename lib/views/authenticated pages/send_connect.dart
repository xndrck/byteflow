import 'package:byte_flow/views/authenticated%20pages/dashboard.dart';
import 'package:byte_flow/views/authenticated%20pages/viewsentfiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:byte_flow/main.dart';

class SendConnect extends StatefulWidget {
  final bool isSender;

  const SendConnect({super.key, this.isSender = true});

  @override
  State<SendConnect> createState() => _SendConnectState();
}

class _SendConnectState extends State<SendConnect>
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

    // Radar animation (Expanding or Contracting circles based on role)
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // For sender: expanding circles, for receiver: contracting circles
    _radarScaleAnimation = widget.isSender
        ? Tween<double>(begin: 1, end: 2).animate(
            CurvedAnimation(parent: _radarController, curve: Curves.easeOut),
          )
        : Tween<double>(begin: 2, end: 1).animate(
            CurvedAnimation(parent: _radarController, curve: Curves.easeIn),
          );

    _radarOpacityAnimation = widget.isSender
        ? Tween<double>(begin: 0.5, end: 0).animate(
            CurvedAnimation(parent: _radarController, curve: Curves.easeOut),
          )
        : Tween<double>(begin: 0, end: 0.5).animate(
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
    final screenSize = MediaQuery.of(context).size;
    final containerWidth =
        screenSize.width * 0.9 > 330 ? 330.0 : screenSize.width * 0.9;

    // Text content based on sender/receiver role
    final String titleText =
        widget.isSender ? 'Click the avatar to send!' : 'Waiting to receive...';

    final String statusText = widget.isSender
        ? "Oops! The hotspot isn't fired up yet!"
        : "Ready to receive files!";

    final String actionText = widget.isSender
        ? "Turn it on to start sharing files seamlessly!"
        : "Waiting for sender to connect...";

    final String buttonText = widget.isSender
        ? "Ready to connect? Pick a device and let's go!"
        : "Ready to receive? Let's establish a connection!";

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
              // Centered AI icon and title text in a single row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'lib/icons/ai.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    titleText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width < 350 ? 18 : 20,
                      color: themeProvider.textColor,
                    ),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                statusText,
                                style: TextStyle(
                                    color: themeProvider.containerTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.width < 350 ? 13 : 15),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Icon(
                                widget.isSender ? Icons.wifi : Icons.wifi_find,
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
                          actionText,
                          style: TextStyle(
                              color: themeProvider.containerTextColor),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Animated Radar Effect
                            AnimatedBuilder(
                              animation: _radarController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _radarScaleAnimation.value,
                                  child: Opacity(
                                    opacity: _radarOpacityAnimation.value,
                                    child: Container(
                                      width: screenSize.width < 350 ? 250 : 300,
                                      height:
                                          screenSize.width < 350 ? 250 : 300,
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
                            // Middle Circle (Static)
                            Container(
                              width: screenSize.width < 350 ? 150 : 200,
                              height: screenSize.width < 350 ? 150 : 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: themeProvider.containerTextColor,
                                    width: 3),
                              ),
                            ),
                            // Inner Circle with Animation
                            AnimatedBuilder(
                              animation: _rocketAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _rocketAnimation.value),
                                  child: Container(
                                    width: screenSize.width < 350 ? 80 : 100,
                                    height: screenSize.width < 350 ? 80 : 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color:
                                              themeProvider.containerTextColor,
                                          width: 1),
                                    ),
                                    child: Image.asset(
                                      widget.isSender
                                          ? 'lib/icons/rocket1.png'
                                          : 'lib/icons/in.png',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 90),
                      Center(
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            color: themeProvider.containerTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
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
                                    builder: (context) => ViewSentFiles()),
                              );
                            },
                            child: Container(
                              width: containerWidth * 0.43,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: themeProvider.containerTextColor)),
                              child: Center(
                                child: Text(
                                  'View Sent Files',
                                  style: TextStyle(
                                      color: themeProvider.containerTextColor,
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
                              width: containerWidth * 0.43,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: themeProvider.containerTextColor)),
                              child: Center(
                                child: Text(
                                  'Back to Home',
                                  style: TextStyle(
                                      color: themeProvider.containerTextColor,
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
