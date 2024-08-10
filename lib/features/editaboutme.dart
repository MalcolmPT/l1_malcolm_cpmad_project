import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // Import Firestore
import 'package:l1_malcolm_cpmad_project/features/profile.dart';
import 'package:l1_malcolm_cpmad_project/services/firebaseauth_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditAboutMe extends StatefulWidget {
  const EditAboutMe({super.key});

  @override
  _EditAboutMeState createState() => _EditAboutMeState();
}

class _EditAboutMeState extends State<EditAboutMe> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  File? _profileImage;
  String? _currentImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData(); 
  }


  Future<void> _fetchUserData() async {
    final userData = await _authService.fetchUserData();
    setState(() {
      _usernameController.text = userData['username'] ?? '';
      _descriptionController.text = userData['description'] ?? '';
      _currentImageUrl = userData['imageUrl'] ?? '';
    });
  }
  
  

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() async {
    final username = _usernameController.text.trim();
    final description = _descriptionController.text.trim();

    if (username.isEmpty || description.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields", gravity: ToastGravity.TOP);
      return;
    }

    String? imageUrl;
    if (_profileImage != null) {
      imageUrl = await _authService.uploadProfileImage(_profileImage!);
    } else {
      imageUrl = _currentImageUrl; 
    }

    bool success = await _authService.updateUserProfile(
      username: username,
      description: description,
      imageUrl: imageUrl,
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                ),
                const Text(
                  "Password Change",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Text("Edit my Profile", style:TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.black,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : (_currentImageUrl != null && _currentImageUrl!.isNotEmpty
                        ? NetworkImage(_currentImageUrl!) as ImageProvider
                        : null),
                child: _profileImage == null && (_currentImageUrl == null || _currentImageUrl!.isEmpty)
                    ? const Icon(Icons.camera_alt, color: Colors.white, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36.0),
                ),
                contentPadding: const EdgeInsets.only(left: 30.0),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              obscureText: false,
              maxLines: null,
              minLines: 10,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36.0),
                ),
                contentPadding: const EdgeInsets.only(left: 30.0, top: 15.0),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 4,
                backgroundColor: const Color(0xFF1A2947),
                padding: const EdgeInsets.fromLTRB(167, 10, 167, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36.0),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
