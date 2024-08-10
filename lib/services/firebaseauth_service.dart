import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FirebaseAuthService {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<User?> signIn({String? email, String? password}) async {
    try {
      UserCredential ucred = await _fbAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      User? user = ucred.user;
      debugPrint("Sign in successful! userid: ${ucred.user?.uid}, user: $user.");
      return user!;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "Login unsuccessful",
          gravity: ToastGravity.TOP,
          backgroundColor: Color(0xCCFFFFFF),
          textColor: Colors.black,
          fontSize: 16.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2);
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signUp({
  String? email,
  String? password,
  String? username,
  File? profileImageFile,
  File? backgroundImageFile,
}) async {
  debugPrint("Sign up");
  try {
    UserCredential ucred = await _fbAuth.createUserWithEmailAndPassword(
        email: email!, password: password!);
    User? user = ucred.user;

    if (user != null) {
      await user.updateDisplayName(username);
      await user.reload();
      user = _fbAuth.currentUser;

      String profileImageUrl = '';
      String backgroundImageUrl = '';

      // Upload profile image if provided
      if (profileImageFile != null) {
        final profileStorageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${user?.uid}.jpg');
        await profileStorageRef.putFile(profileImageFile);
        profileImageUrl = await profileStorageRef.getDownloadURL();
      }

      // Upload background image if provided
      if (backgroundImageFile != null) {
        final backgroundStorageRef = FirebaseStorage.instance
            .ref()
            .child('background_images/${user?.uid}.jpg');
        await backgroundStorageRef.putFile(backgroundImageFile);
        backgroundImageUrl = await backgroundStorageRef.getDownloadURL();
      }

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('Users').doc(user?.uid).set({
        'uid': user?.uid,
        'username': username,
        'email': email,
        'password': password, // Storing passwords in Firestore is not recommended
        'createdAt': FieldValue.serverTimestamp(),
        'description': "This user is not interesting",
        'image': profileImageUrl,
        'background': backgroundImageUrl,
      });

      debugPrint("Sign up successful! userid: ${ucred.user?.uid}, user: $user.");
      return user!;
    }
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    return null;
  } catch (e) {
    return null;
  }
}


  Future<void> signOut() async {
    await _fbAuth.signOut();
  }

  Future<bool> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // Re-authenticate the user
      User? user = _fbAuth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(newPassword);
        Fluttertoast.showToast(
            msg: "Password changed successfully",
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 2);
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "User not found",
            gravity: ToastGravity.TOP,  
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 2);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message ?? "An error occurred",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2);
      return false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "An unexpected error occurred",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2);
      return false;
    }
  }

  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final email = _fbAuth.currentUser?.email ?? '';
      final storageRef = _storage.ref().child('profile_images/$email.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to upload image: $e", gravity: ToastGravity.TOP);
      return null;
    }
  }

  Future<bool> updateUserProfile({
    required String username,
    required String description,
    String? imageUrl,
  }) async {
    final email = _fbAuth.currentUser?.email ?? '';

    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "User email not found", gravity: ToastGravity.TOP);
      return false;
    }

    try {
      QuerySnapshot snapshot = await _firestore.collection('Users').where('email', isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;

        Map<String, dynamic> updateData = {
          'username': username,
          'description': description,
        };

        if (imageUrl != null) {
          updateData['image'] = imageUrl;
        }

        await _firestore.collection('Users').doc(docId).update(updateData);

        Fluttertoast.showToast(msg: "Profile updated successfully", gravity: ToastGravity.TOP);
        return true;
      } else {
        Fluttertoast.showToast(msg: "User not found in database", gravity: ToastGravity.TOP);
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to update profile: $e", gravity: ToastGravity.TOP);
      return false;
    }
  }

  Future<Map<String, String?>> fetchUserData() async {
    final user = _fbAuth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Users').doc(user.uid);
      final doc = await docRef.get();

      if (doc.exists) {
        return {
          'imageUrl': doc['image'] ?? '',
          'username': doc['username'] ?? 'User',
          'backgroundUrl': doc['background'] ?? '',
          'description': doc['description'] ?? '',
        };
      } else {
        return {
          'imageUrl': '',
          'username': 'User',
          'backgroundUrl': '',
          'description' : 'This user is not very interesting'
        };
      }
    } else {
      return {
        'imageUrl': '',
        'username': 'User',
        'backgroundUrl': '',
        'description' : 'This user is not very interesting'
      };
    }
  }
  Future<void> submitFeedback({
    required String subject,
    required String description,
    required BuildContext context,
  }) async {
    try {
      User? user = _fbAuth.currentUser;
      if (user != null) {
        await _firestore.collection('Feedbacks').add({
          'email': user.email,
          'subject': subject.trim(),
          'description': description.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to submit feedback')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit feedback: $e')),
      );
    }
  }

Future<String?> uploadBackgroundImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      try {
        final user = _fbAuth.currentUser;
        if (user != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('background_images/${user.uid}.jpg');
          await storageRef.putFile(file);
          final downloadUrl = await storageRef.getDownloadURL();

          await _firestore.collection('Users').doc(user.uid).update({'background': downloadUrl});

          return downloadUrl; // Return the download URL on success
        }
      } catch (e) {
        return null; // Return null on failure
      }
    }
    return null; // Return null if no file was picked
  }

  Future<bool> removeBackgroundImage() async {
    try {
      final user = _fbAuth.currentUser;
      if (user != null) {
        final storageRef = _storage.ref().child('background_images/${user.uid}.jpg');

        await storageRef.delete(); 

        await _firestore.collection('Users').doc(user.uid).update({'background': ''}); 

        return true; 
      }
    } catch (e) {
      print('Failed to remove background image: $e');
    }
    return false; // Failure
  }
  
}




