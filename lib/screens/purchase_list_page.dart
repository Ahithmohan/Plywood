import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_widget.dart';

class PurchaseListPage extends StatefulWidget {
  const PurchaseListPage({super.key});

  @override
  State<PurchaseListPage> createState() => _PurchaseListPageState();
}

class _PurchaseListPageState extends State<PurchaseListPage> {
  // Sample purchase list
  final List<Map<String, dynamic>> purchaseList = [
    {
      "name": "Customer Name 1",
      "date": "30/05/2025",
      "phone": "8086433900",
      "qty": "05",
      "product": "Plywood",
      "price": "5000"
    },
    {
      "name": "Customer Name 2",
      "date": "29/05/2025",
      "phone": "9876543210",
      "qty": "10",
      "product": "MDF Board",
      "price": "7500"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:
            const Text('Purchase List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: purchaseList.length,
        itemBuilder: (context, index) {
          final item = purchaseList[index];
          return Card(
            elevation: 2,
            color: Colors.grey[700],
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildTextWidget(
                      text: item["name"],
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    BuildTextWidget(
                      text: item["date"],
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Phone", item["phone"]),
                        _buildDetailRow("Qty", item["qty"]),
                        _buildDetailRow("Product", item["product"]),
                        _buildDetailRow("Price", item["price"]),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BuildElevatedButtonWidget(
                              text: "Edit",
                              backgroundColor: Colors.blue,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 10),
                            BuildElevatedButtonWidget(
                              text: "Delete",
                              backgroundColor: Colors.red,
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildTextWidget(
            text: "$label:",
            color: Colors.white70,
            fontSize: 16,
          ),
          BuildTextWidget(
            text: value,
            color: Colors.white,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
