import 'package:byte_flow/views/authenticated%20pages/components/actions.dart';
import 'package:byte_flow/views/authenticated%20pages/send_connect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:byte_flow/main.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "ByteFlow",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Image.asset('lib/icons/ai.png', width: 50, height: 50),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tap, Share, Done!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Quickly share your files with ease.",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 350,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [Color(0xFF3D5AFE), Color(0xFF81A4FD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('lib/icons/white_folder.png', width: 20),
                      SizedBox(width: 8),
                      Text(
                        "Home > Internal Storage > Files",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildFileCategory(
                    title: "Images",
                    subtitle: "(jpg, png, webp, heic, etc...)",
                    icons: [
                      JActions(
                          image: 'lib/icons/gallery.png',
                          text: 'IMG1.jpg',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/gallery.png',
                          text: 'IMG2.jpg',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/gallery.png',
                          text: 'IMG3.jpg',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/gallery.png',
                          text: 'IMG4.jpg',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/plus.png',
                          text: 'More',
                          themeProvider: themeProvider),
                    ],
                  ),
                  _buildFileCategory(
                    title: "Videos",
                    subtitle: "(mp4, mkv, mov, avi, etc...)",
                    icons: [
                      JActions(
                          image: 'lib/icons/video.png',
                          text: 'VID1.mp4',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/video.png',
                          text: 'VID2.mkv',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/video.png',
                          text: 'VID3.mov',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/video.png',
                          text: 'VID4.avi',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/plus.png',
                          text: 'More',
                          themeProvider: themeProvider),
                    ],
                  ),
                  _buildFileCategory(
                    title: "Music",
                    subtitle: "(mp3, aac, ogg, m4a, etc...)",
                    icons: [
                      JActions(
                          image: 'lib/icons/playlist.png',
                          text: 'PLAY1.mp3',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/playlist.png',
                          text: 'PLAY2.acc',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/playlist.png',
                          text: 'PLAY3.ogg',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/playlist.png',
                          text: 'PLAY4.m4a',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/plus.png',
                          text: 'More',
                          themeProvider: themeProvider),
                    ],
                  ),
                  _buildFileCategory(
                    title: "Docs",
                    subtitle: "(doc, txt, pdf, ppt, etc...)",
                    icons: [
                      JActions(
                          image: 'lib/icons/folder.png',
                          text: 'DOC1.doc',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/folder.png',
                          text: 'DOC2.txt',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/folder.png',
                          text: 'DOC3.pdf',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/folder.png',
                          text: 'DOC4.ppt',
                          themeProvider: themeProvider),
                      JActions(
                          image: 'lib/icons/plus.png',
                          text: 'More',
                          themeProvider: themeProvider),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SendConnect()),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 280,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              'Share Files',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFileCategory(
      {required String title,
      required String subtitle,
      required List<Widget> icons}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            subtitle,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: icons,
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
