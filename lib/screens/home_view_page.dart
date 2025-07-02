import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plywood/screens/product_view.dart';
import 'package:plywood/widgets/heading_widget.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class HomeViewPage extends StatefulWidget {
  final ScrollController? scrollController;

  const HomeViewPage({super.key, this.scrollController});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20),
            child: Row(
              children: [
                Text(
                  'Plywood',
                  style:
                      GoogleFonts.spicyRice(color: Colors.white, fontSize: 29),
                ),
                Text(
                  '!',
                  style:
                      GoogleFonts.spicyRice(color: Colors.orange, fontSize: 29),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      // Navigate to settings page
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height / 7,
            width: width,
            decoration: BoxDecoration(
              color: const Color(0xff131D4F).withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeadingWidget(
                  iconData: Icons.wallet,
                  title: "wallet",
                  subtitle: "150000",
                ),
                HeadingWidget(
                  iconData: Icons.list_alt_outlined,
                  title: "Order",
                  subtitle: "15",
                ),
                HeadingWidget(
                  iconData: Icons.inventory_2,
                  title: "Stocks",
                  subtitle: "1540",
                )
              ],
            ),
          ),
          Expanded(
            child: productProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.orange,
                  ))
                : Container(
                    color: Colors.black,
                    width: width,
                    child: GridView.count(
                      controller: widget.scrollController,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      padding: const EdgeInsets.all(5.0),
                      children: products.map((product) {
                        return SizedBox(
                          width: width / 2.5,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductView(
                                          productId: product.id,
                                        )),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: width,
                                      height: height / 8,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://static.vecteezy.com/system/resources/thumbnails/006/793/295/small/wood-texture-pattern-dark-brown-design-background-vector.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              product.name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: GoogleFonts.spicyRice(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "₹${product.price}",
                                            style: GoogleFonts.spicyRice(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Grade",
                                          style: GoogleFonts.manrope(
                                              color: Colors.black,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          product.grade,
                                          style: GoogleFonts.manrope(
                                              color: Colors.black,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
