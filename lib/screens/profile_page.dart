import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plywood/screens/settings_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        bottomNavigationBar: Container(
          height: height / 4,
          width: width,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width / 2.5,
                  child: BuildElevatedButtonWidget(
                    backgroundColor: Colors.grey[900],
                    text: "Settings",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ));
                    },
                  ),
                ),
                SizedBox(
                  width: width / 2.5,
                  child: BuildElevatedButtonWidget(
                    backgroundColor: Colors.red,
                    text: "Logout",
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Profile Details',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width / 2,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.orange,
                ),
                child: Center(
                  child: BuildTextWidget(
                    text: "Company Details",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Plywood Company',
                    style: GoogleFonts.spicyRice(
                        color: Colors.white, fontSize: 29),
                  ),
                  Text(
                    '!',
                    style: GoogleFonts.spicyRice(
                        color: Colors.orange, fontSize: 29),
                  ),
                ],
              ),
              BuildTextWidget(
                text:
                    "The Western India Plywoods Ltd Baliapatam, Kannur,Kerala, India",
                color: Colors.white,
                fontSize: 18,
              ),
              BuildTextWidget(
                text: "PIN: 964645",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "plywood12@gmail.com",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "Phone: 8086433977",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "GST: 27AABFP6165G1Z6",
                color: Colors.white,
                fontSize: 18,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: width / 2,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.orange,
                ),
                child: Center(
                  child: BuildTextWidget(
                    text: "Admin Details",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BuildTextWidget(
                text: "User: Admin",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "plywood12@gmail.com",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "Phone: 8086433977",
                fontSize: 18,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
