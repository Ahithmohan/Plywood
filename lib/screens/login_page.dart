import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plywood/screens/home_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';
import 'package:plywood/widgets/build_text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin(BuildContext context) async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both username and password.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    final success = await loginProvider.login(username, password);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginProvider>(context);
    print(loginProvider.adminId);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Plywood',
                  style:
                      GoogleFonts.spicyRice(color: Colors.white, fontSize: 39),
                ),
                Text(
                  "!",
                  style:
                      GoogleFonts.spicyRice(color: Colors.orange, fontSize: 39),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BuildTextFieldWidget(
                controller: _usernameController,
                hintText: "john@gmail.com",
                icon: Icon(Icons.email, color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: BuildTextFieldWidget(
                controller: _passwordController,
                hintText: "Password",
                icon: Icon(Icons.lock, color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BuildTextWidget(
                  text: "Forgot password?",
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            loginProvider.isLoading
                ? CircularProgressIndicator(color: Colors.orange)
                : SizedBox(
                    width: width / 1.5,
                    child: BuildElevatedButtonWidget(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      text: "Login",
                      onPressed: () {
                        _handleLogin(context);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
