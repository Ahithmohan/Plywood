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
        backgroundColor: Colors.grey[900],
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
                                  _buildDetailRow("Total Amount",
                                      item.totalAmount.toString()),
                                  const Divider(
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(height: 10),
                                  ...item.products.map((product) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildDetailRow("Product",
                                            product['product'] ?? ''),
                                        _buildDetailRow("Quantity",
                                            product['quantity'].toString()),
                                        _buildDetailRow("Price",
                                            product['price'].toString()),
                                        // _buildDetailRow("Balance",
                                        //     product['balance'].toString()),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }).toList(),
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
                                                date: item.date,
                                                products: List<
                                                        Map<String,
                                                            dynamic>>.from(
                                                    item.products), // ✅
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      BuildElevatedButtonWidget(
                                        text: "Delete",
                                        backgroundColor: Colors.red,
                                        onPressed: () async {
                                          final confirm =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.grey[900],
                                              title: const Text(
                                                  "Confirm Delete",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              content: const Text(
                                                  "Are you sure you want to delete this purchase?",
                                                  style: TextStyle(
                                                      color: Colors.white70)),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: const Text("Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child: const Text("Delete",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (confirm == true) {
                                            final success = await Provider.of<
                                                        PurchaseProvider>(
                                                    context,
                                                    listen: false)
                                                .deletePurchase(item.id);
                                            if (!mounted) return;

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  success
                                                      ? "Purchase deleted successfully"
                                                      : "Failed to delete purchase",
                                                ),
                                                backgroundColor: success
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                            );
                                          }
                                        },
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
