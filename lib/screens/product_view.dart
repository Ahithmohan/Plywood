import 'package:flutter/material.dart';
import 'package:plywood/screens/add_product_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../provider/product_provider.dart';

class ProductView extends StatefulWidget {
  final String productId;

  const ProductView({super.key, required this.productId});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductModel? product;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductDetails();
  }

  // Future<void> fetchProductDetails() async {
  //   try {
  //     final response = await Dio().get(
  //       "https://plywood-backend-t3v1.onrender.com/api/Plywood/${widget.productId}",
  //     );
  //     setState(() {
  //       product = ProductModel.fromJson(response.data);
  //       print(product!.name);
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print("Failed to load product: $e");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
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
      bottomNavigationBar: Container(
        height: height / 9,
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
                  backgroundColor: Colors.green,
                  text: "Edit",
                  // onPressed: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => AddProductPage(
                  //           product: product,
                  //         ),
                  //       ));
                  // },
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductPage(product: product),
                      ),
                    );

                    if (result == true) {
                      fetchProductDetails(); // <- fetch latest data from server
                    }
                  },
                ),
              ),
              SizedBox(
                width: width / 2.5,
                child: BuildElevatedButtonWidget(
                  backgroundColor: Colors.red,
                  text: "Delete",
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.grey[900],
                        title: const Text(
                          "Confirm Deletion",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: const Text(
                          "Are you sure you want to delete this product?",
                          style: TextStyle(color: Colors.white70),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Delete",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      final provider =
                          Provider.of<ProductProvider>(context, listen: false);
                      final success =
                          await provider.deleteProduct(widget.productId);

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Product deleted successfully")),
                        );
                        Navigator.pop(context); // go back to product list
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Failed to delete product")),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Product View',
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
                              await fetchProductDetails(); // Refresh the product state

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(product!.stock
                                    ? "Stock marked as Out"
                                    : "Stock marked as In"),
                              ));
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
