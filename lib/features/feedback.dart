import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/services/firebaseauth_service.dart';
import 'drawer.dart';
import 'profile.dart'; // Assuming this is where the profile page is located

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();
  String imageUrl = ''; 

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userData = await _authService.fetchUserData();
    setState(() {
      imageUrl = userData['imageUrl'] ?? '';
    });
  }

  void _submitFeedback() async {
    final subject = _subjectController.text.trim();
  final description = _descriptionController.text.trim();

  if (subject.isEmpty || description.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill in both the subject and description')),
    );
    return; 
  }
    await _authService.submitFeedback(
      subject: _subjectController.text.trim(),
      description: _descriptionController.text.trim(),
      context: context
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback submitted successfully')),
    );

    _subjectController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAE9DD),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.black,
              iconSize: 50,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 6.0,
        actions: [
          Hero(
            tag: 'profile-image-hero',
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.grey,
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : null,
                  child: imageUrl.isEmpty
                      ? const Icon(Icons.person, size: 46, color: Colors.white)
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    hintText: 'Subject',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                    contentPadding: const EdgeInsets.only(left: 30.0),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  minLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(30.0, 30, 0, 0),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset("images/Feedback.png"),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitFeedback,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: const Color(0xFF1A2947),
                    padding: const EdgeInsets.fromLTRB(160, 10, 160, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
