import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../main.dart';
import 'dashboard.dart';

// Model class for file data
class FileData {
  final String id;
  String name;
  String extension;
  String imagePath;
  final DateTime createdAt;

  FileData({
    required this.id,
    required this.name,
    required this.extension,
    required this.imagePath,
    required this.createdAt,
  });
}

class ReceiveProgress extends StatefulWidget {
  const ReceiveProgress({super.key});

  @override
  State<ReceiveProgress> createState() => _ReceiveProgressState();
}

class _ReceiveProgressState extends State<ReceiveProgress> {
  final ImagePicker _picker = ImagePicker();
  final List<String> _extensions = ['.jpg', '.png', '.pdf', '.docx'];
  late List<FileData> files;

  @override
  void initState() {
    super.initState();
    files = [
      FileData(
        id: '1',
        name: 'Sample File',
        extension: '.jpg',
        imagePath: 'lib/photos/jim.jpg',
        createdAt: DateTime.now(),
      ),
    ];
  }

  Future<void> _pickImage(ImageSource source, FileData file) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile != null) {
        setState(() {
          file.imagePath = pickedFile.path;
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

  void _showImageSourceDialog(FileData file) {
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
                  _pickImage(ImageSource.gallery, file);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera, file);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpdateDialog(
      BuildContext context, ThemeProvider themeProvider, FileData file) {
    final TextEditingController nameController =
        TextEditingController(text: file.name);
    String? selectedExtension = file.extension;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Update File',
            style: TextStyle(
              color: themeProvider.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image preview and picker
                GestureDetector(
                  onTap: () => _showImageSourceDialog(file),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: themeProvider.containerTextColor,
                        width: 2,
                      ),
                    ),
                    child: file.imagePath.startsWith('lib/')
                        ? Image.asset(
                            file.imagePath,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(file.imagePath),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                // Name field
                TextField(
                  controller: nameController,
                  style: TextStyle(color: themeProvider.textColor),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle:
                        TextStyle(color: themeProvider.containerTextColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: themeProvider.containerTextColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: themeProvider.containerTextColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.white.withOpacity(0.1),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
                // Extension dropdown
                DropdownButtonFormField<String>(
                  value: selectedExtension,
                  items: _extensions
                      .map((ext) => DropdownMenuItem(
                            value: ext,
                            child: Text(ext,
                                style:
                                    TextStyle(color: themeProvider.textColor)),
                          ))
                      .toList(),
                  onChanged: (val) => selectedExtension = val,
                  decoration: InputDecoration(
                    labelText: 'File Extension',
                    labelStyle:
                        TextStyle(color: themeProvider.containerTextColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: themeProvider.containerTextColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: themeProvider.containerTextColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.white.withOpacity(0.1),
                    filled: true,
                  ),
                  dropdownColor: themeProvider.themeMode == ThemeMode.light
                      ? Colors.white
                      : ThemeProvider.darkBackgroundColor,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: themeProvider.textColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  file.name = nameController.text;
                  file.extension = selectedExtension ?? file.extension;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeProvider.lightPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.light
          ? Colors.white
          : ThemeProvider.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.themeMode == ThemeMode.light
            ? Colors.white
            : ThemeProvider.darkBackgroundColor,
        iconTheme: IconThemeData(color: themeProvider.textColor),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "ByteFlow",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
                          'Your Sent Files',
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
              // Files List
              if (files.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No files found',
                        style: TextStyle(
                          color: themeProvider.textColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _navigateToDashboard(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeProvider.lightPrimaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Back to Dashboard',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    ...files.map((file) => _buildFlashcard(
                          context,
                          themeProvider,
                          file,
                          () => _deleteFile(context, file.id),
                        )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _navigateToDashboard(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeProvider.lightPrimaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back to Dashboard',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteFile(BuildContext context, String fileId) {
    // TODO: Implement delete functionality when Firebase is added
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File deleted successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildFlashcard(
    BuildContext context,
    ThemeProvider themeProvider,
    FileData file,
    VoidCallback onDelete,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeProvider.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Row(
              children: [
                // Image preview
                GestureDetector(
                  onTap: () => _showImageSourceDialog(file),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: file.imagePath.startsWith('lib/')
                          ? Image.asset(
                              file.imagePath,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(file.imagePath),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // File information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        file.name,
                        style: TextStyle(
                          color: themeProvider.containerTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Extension: ${file.extension}',
                        style: TextStyle(
                          color:
                              themeProvider.containerTextColor.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Created: ${_formatDate(file.createdAt)}',
                        style: TextStyle(
                          color:
                              themeProvider.containerTextColor.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Action buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: themeProvider.containerTextColor,
                      ),
                      onPressed: () =>
                          _showUpdateDialog(context, themeProvider, file),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: themeProvider.containerTextColor,
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
