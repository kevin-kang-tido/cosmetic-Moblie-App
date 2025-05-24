import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _firstNameController = TextEditingController(text: 'Anthony');
  final _lastNameController = TextEditingController(text: 'Smith');
  final _usernameController = TextEditingController(text: 'anthonysmith12');
  final _emailController = TextEditingController(text: 'anthonysmith@gmail.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFFFD740), // Yellow background
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40), // for safe keyboard space
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // App bar with title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        // Icon(Icons.menu),
                        Text(
                          "Settings",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 24),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    // Profile Image
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/profile.png'),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Form Fields
                    _buildTextField(label: "First Name", controller: _firstNameController),
                    const SizedBox(height: 16),
                    _buildTextField(label: "Last Name", controller: _lastNameController),
                    const SizedBox(height: 16),
                    _buildTextField(label: "Username", controller: _usernameController),
                    const SizedBox(height: 16),
                    _buildTextField(label: "Email", controller: _emailController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
