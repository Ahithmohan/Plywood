import 'package:flutter/material.dart';
import 'package:plywood/provider/purchase_provider.dart';
import 'package:plywood/screens/purchase_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_widget.dart';
import 'package:provider/provider.dart';

class PurchaseListPage extends StatefulWidget {
  const PurchaseListPage({super.key});

  @override
  State<PurchaseListPage> createState() => _PurchaseListPageState();
}

class _PurchaseListPageState extends State<PurchaseListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PurchaseProvider>(context, listen: false).fetchPurchases());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PurchaseProvider>(context);
    final purchaseList = provider.purchaseList;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:
            const Text('Purchase List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : purchaseList.isEmpty
              ? const Center(
                  child: Text("No purchases found",
                      style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  itemCount: purchaseList.length,
                  itemBuilder: (context, index) {
                    final item = purchaseList[index];
                    return Card(
                      elevation: 2,
                      color: Colors.grey[700],
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BuildTextWidget(
                                text: item.customerName,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              BuildTextWidget(
                                text: item.date,
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
                                  _buildDetailRow("Phone", item.customerNumber),
                                  _buildDetailRow(
                                      "Qty", item.quantity.toString()),
                                  _buildDetailRow("Product", item.product),
                                  _buildDetailRow(
                                      "Price", item.price.toString()),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      BuildElevatedButtonWidget(
                                        text: "Edit",
                                        backgroundColor: Colors.blue,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PurchasePage(
                                                id: item.id,
                                                customerName: item.customerName,
                                                customerNumber:
                                                    item.customerNumber,
                                                product: item.product,
                                                quantity: item.quantity,
                                                price: item.price,
                                                date: item.date,
                                              ),
                                            ),
                                          );
                                        },
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
