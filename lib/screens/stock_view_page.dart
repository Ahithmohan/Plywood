import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../provider/product_provider.dart';
import '../widgets/build_elevated_button_widget.dart';

class StockViewPage extends StatefulWidget {
  final String productId;

  const StockViewPage({super.key, required this.productId});

  @override
  State<StockViewPage> createState() => _StockViewPageState();
}

class _StockViewPageState extends State<StockViewPage> {
  ProductModel? product;
  bool isLoading = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    try {
      final fetchedProduct = await provider.getProductById(widget.productId);
      setState(() {
        product = fetchedProduct;
        isLoading = false;
        print(product!.stock);
      });
    } catch (e) {
      print("Failed to load product: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Stock View',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width,
                    height: height / 2.9,
                    child: Image.network(
                        fit: BoxFit.cover,
                        "https://static.wixstatic.com/media/ad6d92_1b87846d01fa4e8ebf4aacbea990156c~mv2.jpg/v1/fill/w_556,h_354,al_c,lg_1,q_80,enc_avif,quality_auto/ad6d92_1b87846d01fa4e8ebf4aacbea990156c~mv2.jpg"),
                  ),
                  SizedBox(
                    height: 05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 2, bottom: 2, left: 5, right: 5),
                      child: Text(
                        'Product Details',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category: ${product!.category}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Available Stock: 120',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Grade: ${product!.grade}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price: \$${product!.price}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Size: ${product!.size}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Thickness: ${product!.thickness}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        BuildElevatedButtonWidget(
                          text: product!.stock ? "Stock In" : "Stock Out",
                          backgroundColor:
                              product!.stock ? Colors.green : Colors.red,
                          onPressed: () async {
                            final provider = Provider.of<ProductProvider>(
                                context,
                                listen: false);
                            final success = await provider.toggleProductStock(
                                product!.id, product!.stock);

                            if (success) {
                              Navigator.pop(
                                  context, true); // ✅ return true to StockPage
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Failed to update stock status"),
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
    );
  }
}
