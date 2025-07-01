import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController();
  late TextEditingController _phoneController;
  @override
  void initState() {
    super.initState();
    final admin =
        Provider.of<LoginProvider>(context, listen: false).adminDetails;

    _usernameController = TextEditingController(text: admin?.username ?? '');
    _emailController = TextEditingController(text: admin?.email ?? '');
    _phoneController = TextEditingController(text: admin?.contactNumber ?? '');
  }

  void _handleUpdate(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final success = await loginProvider.updateAdminDetails(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
      _emailController.text.trim(),
      _phoneController.text.trim(),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Admin details updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update admin details'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BuildTextFieldWidget(
                    controller: _usernameController,
                    hintText: "User Name",
                    icon: const Icon(Icons.person, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    hintText: "Password",
                    icon: const Icon(Icons.password, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    controller: _emailController,
                    hintText: "Email",
                    icon: const Icon(Icons.email, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    controller: _phoneController,
                    hintText: "Phone Number",
                    icon: const Icon(Icons.phone, color: Colors.white70)),
                SizedBox(
                  height: 40,
                ),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return SizedBox(
                      width: width / 1.5,
                      child: loginProvider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            )
                          : BuildElevatedButtonWidget(
                              text: "Submit",
                              backgroundColor: Colors.orange,
                              onPressed: () async {
                                final success =
                                    await loginProvider.updateAdminDetails(
                                  _usernameController.text.trim(),
                                  _passwordController.text.trim(),
                                  _emailController.text.trim(),
                                  _phoneController.text.trim(),
                                );

                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Admin details updated successfully'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  loginProvider.fetchAdminDetails();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Failed to update admin details'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    hintText: "Company Name",
                    icon: const Icon(Icons.business, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    hintText: "Company Address",
                    icon: const Icon(Icons.location_on, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    hintText: "Email",
                    icon: const Icon(Icons.email, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    hintText: "Phone Number",
                    icon: const Icon(Icons.phone, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    hintText: "Pin Code",
                    icon: const Icon(Icons.pin, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    hintText: "GST Number",
                    icon: const Icon(Icons.numbers, color: Colors.white70)),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: width / 1.5,
                  child: BuildElevatedButtonWidget(
                    text: "Submit",
                    backgroundColor: Colors.orange,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
