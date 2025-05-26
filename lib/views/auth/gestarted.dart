import 'package:byte_flow/views/authenticated%20pages/dashboard.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool isLoading = false;

  void getCredentials() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isLoading = false; // Hide loading indicator
    });

    // Navigate only after loading completes
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D5AFE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 110,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Welcome to",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "ByteFlow",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF3D5AFE))),
                child: Image.asset('lib/icons/rocket1.png'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Data Transfer and File Sharing app",
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  if (!isLoading) {
                    getCredentials(); // Call function (navigation will happen inside it)
                  }
                },
                child: Container(
                  width: 340,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(color: Colors.indigoAccent)),
                  child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.indigoAccent,
                            )
                          : Text("Get Started",
                              style: TextStyle(
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ))),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "By clicking Get Started you agree to Recognotes",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print("Term's of use");
                  },
                  child: Container(
                    child: Text(
                      "Term's of use",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  " and ",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    print("Privacy policy");
                  },
                  child: Container(
                    child: Text(
                      "Privacy policy",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
