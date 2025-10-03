import 'package:cosmetic/screen/theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'language_screen.dart';
import 'login_screent.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _languageController = TextEditingController(text: 'Language');

  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
      _emailController.text = user?.email ?? "";
      if (user?.displayName != null) {
        final parts = user!.displayName!.split(" ");
        _firstNameController.text = parts.isNotEmpty ? parts.first : "";
        _lastNameController.text =
        parts.length > 1 ? parts.sublist(1).join(" ") : "";
      }
    });
  }

  Future<void> _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final fullName =
      "${_firstNameController.text} ${_lastNameController.text}".trim();

      await user.updateDisplayName(fullName);
      await user.reload();

      setState(() {
        _user = FirebaseAuth.instance.currentUser;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // App bar with title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Settings",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 24),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Edit Profile",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    // Profile Image
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                        const AssetImage('assets/images/profile.png'),
                        child: _user?.displayName != null
                            ? Text(
                          _user!.displayName![0],
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Form Fields
                    _buildTextField(
                        label: "First Name", controller: _firstNameController),
                    const SizedBox(height: 16),
                    _buildTextField(
                        label: "Last Name", controller: _lastNameController),
                    const SizedBox(height: 16),
                    _buildTextField(
                        label: "Email",
                        controller: _emailController,
                        enabled: false),
                    const SizedBox(height: 16),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                        ),
                        child: const Text("Save",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),

                    ListTile(
                      title: Text("language".tr),
                      subtitle: Text(
                        "${Get.locale!.languageCode == "en" ? "english".tr : "khmer".tr}",
                      ),
                      onTap: () {
                        Get.to(LanguageScreen());
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text("theme".tr),
                      subtitle: Text("light".tr),
                      onTap: () {
                        Get.to(ThemeScreen());
                      },
                    ),
                    const Divider(),

                    // Logout button
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text("Logout",
                          style: TextStyle(color: Colors.red)),
                      onTap: _logout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        TextField(
          controller: controller,
          enabled: enabled,
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
