import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plywood/screens/home_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';
import 'package:plywood/widgets/build_text_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
            SizedBox(
              width: width / 1.5,
              child: BuildElevatedButtonWidget(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                text: "Login",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
