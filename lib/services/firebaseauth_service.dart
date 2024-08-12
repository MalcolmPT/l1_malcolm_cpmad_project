import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FirebaseAuthService {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //login.dart
  Future<User?> signIn({String? email, String? password}) async {
    try {
      UserCredential ucred = await _fbAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      User? user = ucred.user;
      debugPrint("Sign in successful! userid: ${ucred.user?.uid}, user: $user.");
      return user!;
    } on FirebaseAuthException {
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

  //singup.dart
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

      if (profileImageFile != null) {
        final profileStorageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${user?.uid}.jpg');
        await profileStorageRef.putFile(profileImageFile);
        profileImageUrl = await profileStorageRef.getDownloadURL();
      }

      if (backgroundImageFile != null) {
        final backgroundStorageRef = FirebaseStorage.instance
            .ref()
            .child('background_images/${user?.uid}.jpg');
        await backgroundStorageRef.putFile(backgroundImageFile);
        backgroundImageUrl = await backgroundStorageRef.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('Users').doc(user?.uid).set({
        'uid': user?.uid,
        'username': username,
        'email': email,
        'password': password,
        'createdAt': FieldValue.serverTimestamp(),
        'description': "This user is not interesting",
        'image': profileImageUrl,
        'background': backgroundImageUrl,
      });

      
      await user!.sendEmailVerification();
      Fluttertoast.showToast(msg: "Verification email sent.", gravity: ToastGravity.TOP);

      debugPrint("Sign up successful! userid: ${ucred.user?.uid}, user: $user.");
      return user;
    }
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    return null;
  } catch (e) {
    return null;
  }
  return null;
}


  //profile.dart
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

  //editaboutme.dart
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
        //Create map of updateData with username and description
        Map<String, dynamic> updateData = {
          'username': username,
          'description': description,
        };
        
        //use earlier map to add image index in map and update with param
        if (imageUrl != null) {
          updateData['image'] = imageUrl;
        }

        await _firestore.collection('Users').doc(docId).update(updateData); //Update using map

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

  //All pages with profile pic shown
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

  //feedback.dart
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

//homepage.dart
Future<String?> uploadBackgroundImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      try {
        final user = _fbAuth.currentUser;                         //Authenticate current user
        if (user != null) {
          final storageRef = FirebaseStorage.instance             //creates instance for FirebaseStorage
              .ref()
              .child('background_images/${user.uid}.jpg');
          await storageRef.putFile(file);                         //Store file in that instance
          final downloadUrl = await storageRef.getDownloadURL();  //Get the downloadURL of the instance + file

          await _firestore.collection('Users').doc(user.uid).update({'background': downloadUrl}); //updates firestore collection of new background

          return downloadUrl; 
        }
      } catch (e) {
        return null; 
      }
    }
    return null;
  }
  //homepage.dart
  Future<bool> removeBackgroundImage() async {
    try {
      final user = _fbAuth.currentUser;
      if (user != null) {
        final storageRef = _storage.ref().child('background_images/${user.uid}.jpg'); //creates instance for FirebaseStorage

        await storageRef.delete(); //deletem instance

        await _firestore.collection('Users').doc(user.uid).update({'background': ''});  //Make background field empty instead of deleting

        return true; 
      }
    } catch (e) {
      print('Failed to remove background image: $e');
    }
    return false; // Failure
  }
  //progress.dart & homepage.dart (for bar chart and progress2)
  Future<Map<String, int>> fetchActivityData() async {

    //Initializes map
    Map<String, int> stepsData = {  
      'Monday': 0,
      'Tuesday': 0,
      'Wednesday': 0,
      'Thursday': 0,
      'Friday': 0,
      'Saturday': 0,
      'Sunday': 0,
    };

    try {
      final user = _fbAuth.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('Activity')
            .where('uid', isEqualTo: user.uid)  //uid field within Activity collection
            .get();
        //assign initialized map earlier with values from firestore
        if (querySnapshot.docs.isNotEmpty) {
          final doc = querySnapshot.docs.first;
          stepsData['Monday'] = doc['Monday'] ?? 0;
          stepsData['Tuesday'] = doc['Tuesday'] ?? 0;
          stepsData['Wednesday'] = doc['Wednesday'] ?? 0;
          stepsData['Thursday'] = doc['Thursday'] ?? 0;
          stepsData['Friday'] = doc['Friday'] ?? 0;
          stepsData['Saturday'] = doc['Saturday'] ?? 0;
          stepsData['Sunday'] = doc['Sunday'] ?? 0;
        }
      }
    } catch (e) {
      print('Error fetching activity data: $e');
    }
    
    return stepsData;
  }

  //homepage.dart & activity.dart
  Future<int> fetchTodaySteps() async {
    int todaySteps = 0;

    try {
      final user = _fbAuth.currentUser;
      if (user != null) {
        final todayStepsData = await _firestore
            .collection('TodaysSteps')
            .where('uid', isEqualTo: user.uid)
            .get();

        if (todayStepsData.docs.isNotEmpty) {
          todaySteps = todayStepsData.docs.first['steps'] ?? 0;
        }
      }
    } catch (e) {
      print('Error fetching today\'s steps: $e');
    }

    return todaySteps;
  }

  //progress2.dart
  Future<Map<String, dynamic>> fetchDayData() async {
    User? user = _fbAuth.currentUser;

    if (user != null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Activity')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        return doc.data() as Map<String, dynamic>;
      }
    }

    return {};
  } 

  //forgot_password.dart
  Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
    if (email.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter your email",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      await _fbAuth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Password reset email sent",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.of(context).pop(); // Go back to the previous screen
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Error occurred",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}




