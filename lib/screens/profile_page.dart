import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plywood/screens/settings_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/company_provider.dart';
import '../provider/login_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginProvider>(context, listen: false).fetchAdminDetails();
      Provider.of<CompanyProvider>(context, listen: false)
          .fetchCompanyDetails();
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final admin = Provider.of<LoginProvider>(context).adminDetails;
    final company = Provider.of<CompanyProvider>(context).companyDetails;
    if (admin == null || company == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.orange),
        ),
      );
    }
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
                  Expanded(
                    child: Text(
                      company["companyName"] ?? 'Plywood Company',
                      style: GoogleFonts.spicyRice(
                        color: Colors.white,
                        fontSize: 29,
                      ),
                      overflow: TextOverflow.ellipsis, // prevent overflow
                    ),
                  ),
                ],
              ),
              BuildTextWidget(
                text: company["address"] ??
                    "The Western India Plywoods Ltd Baliapatam, Kannur,Kerala, India",
                color: Colors.white,
                fontSize: 18,
              ),
              BuildTextWidget(
                text: "PIN: ${company["pincode"] ?? "670561"}",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "Gmail: ${company["email"] ?? "plywood12@gmail.com"}",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "Phone: ${company["contactNumber"] ?? "1234567890"}",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "GST: ${company["gstin"] ?? "27AAAPL1234A1Z5"}",
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
                text: "User Name: ${admin!.username}",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "Email: ${admin.email}",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "Phone: ${admin.contactNumber}",
                fontSize: 18,
                color: Colors.white,
              ),
              BuildTextWidget(
                text: "Created: ${admin.createdAt}",
                fontSize: 18,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
