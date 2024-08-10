import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:l1_malcolm_cpmad_project/features/Profile.dart';
import 'package:l1_malcolm_cpmad_project/features/editaboutme.dart';
import 'package:l1_malcolm_cpmad_project/services/firebaseauth_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  void _saveProfile() async {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields", gravity: ToastGravity.TOP);
      return;
    }

    if (newPassword != confirmPassword) {
      Fluttertoast.showToast(msg: "Passwords do not match", gravity: ToastGravity.TOP);
      return;
    }

    final email = _fbAuth.currentUser?.email ?? '';

    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "User email not found", gravity: ToastGravity.TOP);
      return;
    }

    final currentPassword = await _promptForCurrentPassword(context);

    if (currentPassword == null) {
      Fluttertoast.showToast(msg: "Password change canceled", gravity: ToastGravity.TOP);
      return;
    }

    bool success = await _authService.changePassword(
      email: email,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    if (success) {
      Fluttertoast.showToast(msg: "Profile updated successfully", gravity: ToastGravity.TOP);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  Future<String?> _promptForCurrentPassword(BuildContext context) async {
    String? currentPassword;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Re-authenticate"),
          content: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Current Password",
            ),
            onChanged: (value) {
              currentPassword = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );

    return currentPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  "Your Profile",
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                const Text(
                  "About Me",
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditAboutMe()),
                    );
                    
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  iconSize: 30,
                ),
              ],
            ),
            SizedBox(height: 30,),
            Text("Change Password", style:TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            const SizedBox(height: 30),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'New Password',
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
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm New Password',
                hintStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36.0),
                ),
                contentPadding: const EdgeInsets.only(left: 30.0),
              ),
            ),
            Expanded(child: Image.asset("images/EditProfile.png")),
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
