import 'package:flutter/material.dart';
import 'package:plywood/screens/purchase_list_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
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
                  text: "View",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PurchaseListPage(),
                        ));
                  },
                ),
              ),
              SizedBox(
                width: width / 2.5,
                child: BuildElevatedButtonWidget(
                  backgroundColor: Colors.orange,
                  text: "Submit",
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
          'Purchase Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BuildTextFieldWidget(
                hintText: "Customer Name",
                icon: const Icon(Icons.person, color: Colors.white70)),
            const SizedBox(height: 20),
            BuildTextFieldWidget(
                hintText: "Customer Phone",
                icon: const Icon(Icons.phone, color: Colors.white70)),
            const SizedBox(height: 20),
            BuildTextFieldWidget(
                hintText: "Product Name",
                icon: const Icon(Icons.shopping_cart, color: Colors.white70)),
            const SizedBox(height: 20),
            BuildTextFieldWidget(
                hintText: "Quantity",
                icon: const Icon(Icons.format_list_numbered,
                    color: Colors.white70)),
            const SizedBox(height: 20),
            BuildTextFieldWidget(
                hintText: "Price",
                icon: const Icon(Icons.attach_money, color: Colors.white70)),
            const SizedBox(height: 20),
            BuildTextFieldWidget(
                hintText: "Date",
                icon: const Icon(Icons.date_range, color: Colors.white70)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
