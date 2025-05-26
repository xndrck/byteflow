import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart';
import 'package:byte_flow/views/authenticated pages/dashboard.dart';

class ViewSentFiles extends StatefulWidget {
  const ViewSentFiles({super.key});

  @override
  State<ViewSentFiles> createState() => _ViewSentFilesState();
}

class _ViewSentFilesState extends State<ViewSentFiles> {
  String? _selectedExtension;
  final TextEditingController _nameController = TextEditingController();
  String? _selectedPhotoPath;
  final ImagePicker _picker = ImagePicker();

  final List<String> _extensions = ['.jpg', '.png', '.pdf', '.docx'];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedPhotoPath = pickedFile.path;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
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
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          'Send Your Files',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: themeProvider.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: themeProvider.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: GestureDetector(
                          onTap: _showImageSourceDialog,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: themeProvider.containerTextColor,
                                  width: 2),
                            ),
                            child: _selectedPhotoPath == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo,
                                          size: 50,
                                          color:
                                              themeProvider.containerTextColor),
                                      const SizedBox(height: 12),
                                      Text('Choose Photo',
                                          style: TextStyle(
                                              color: themeProvider
                                                  .containerTextColor,
                                              fontSize: 16)),
                                    ],
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      File(_selectedPhotoPath!),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: _nameController,
                          style: TextStyle(color: themeProvider.textColor),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                color: themeProvider.containerTextColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: themeProvider.containerTextColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: themeProvider.containerTextColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedExtension,
                          items: _extensions
                              .map((ext) => DropdownMenuItem(
                                    value: ext,
                                    child: Text(ext,
                                        style: TextStyle(
                                            color: themeProvider.textColor)),
                                  ))
                              .toList(),
                          onChanged: (val) =>
                              setState(() => _selectedExtension = val),
                          decoration: InputDecoration(
                            labelText: 'File Extension',
                            labelStyle: TextStyle(
                                color: themeProvider.containerTextColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: themeProvider.containerTextColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: themeProvider.containerTextColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                          ),
                          dropdownColor:
                              themeProvider.themeMode == ThemeMode.light
                                  ? Colors.white
                                  : ThemeProvider.darkBackgroundColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement create logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeProvider.lightPrimaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Create',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeProvider.lightPrimaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Back to Dashboard',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
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
