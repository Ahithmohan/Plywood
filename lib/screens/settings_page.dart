import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                    hintText: "User Name",
                    icon: const Icon(Icons.person, color: Colors.white70)),
                SizedBox(
                  height: 20,
                ),
                BuildTextFieldWidget(
                    hintText: "Password",
                    icon: const Icon(Icons.password, color: Colors.white70)),
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
