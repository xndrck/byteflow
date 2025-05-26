import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:byte_flow/main.dart';

class Web extends StatelessWidget {
  const Web({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          'Fast & secure web file transfers!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: themeProvider.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
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
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Center(
                            child: Text(
                              'WEB SHARE',
                              style: TextStyle(
                                  color: themeProvider.containerTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Transfer Files Through the Web in Just a Few Clicks!",
                          style: TextStyle(
                              color: themeProvider.containerTextColor,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                          child: Column(
                        children: [
                          Text(
                            "Step 1:  Connect to the Hotspot",
                            style: TextStyle(
                                fontSize: 17,
                                color: themeProvider.containerTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Ask your friends to connect to the hotspot named: Infinix Note 11S",
                            style: TextStyle(
                              fontSize: 10,
                              color: themeProvider.containerTextColor,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Step 2:  Access the Web Interface",
                            style: TextStyle(
                                fontSize: 17,
                                color: themeProvider.containerTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Once connected, they should open a web browser and navigate to",
                            style: TextStyle(
                              fontSize: 10,
                              color: themeProvider.containerTextColor,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "http://192.168.43.1:2999 ",
                            style: TextStyle(
                                fontSize: 15,
                                color: themeProvider.containerTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "OR simply scan the QR code for quick access.",
                            style: TextStyle(
                                fontSize: 10,
                                color: themeProvider.containerTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.qr_code_2_sharp,
                            size: 230,
                            color: themeProvider.containerTextColor,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
