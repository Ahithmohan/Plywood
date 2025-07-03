import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plywood/screens/stock_view_page.dart';
import 'package:provider/provider.dart';

import '../provider/stock_provider.dart';

class StockPage extends StatefulWidget {
  final ScrollController? scrollController;

  const StockPage({super.key, this.scrollController});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<StockProvider>(context, listen: false).fetchStocks();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final stockProvider = Provider.of<StockProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Available Stocks',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        width: width,
        child: stockProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : stockProvider.stocks.isEmpty
                ? const Center(
                    child: Text(
                      "No stock available",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : GridView.count(
                    controller: widget.scrollController,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    padding: const EdgeInsets.all(5.0),
                    children:
                        List.generate(stockProvider.stocks.length, (index) {
                      final stock = stockProvider.stocks[index];

                      return SizedBox(
                        width: width / 2.5,
                        child: GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StockViewPage(productId: stock.id),
                              ),
                            );

                            if (result == true) {
                              // ✅ re-fetch stocks
                              Provider.of<StockProvider>(context, listen: false)
                                  .fetchStocks();
                            }
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
                                      Text(
                                        stock.name,
                                        style: GoogleFonts.spicyRice(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      Text(
                                        "\$${stock.price}",
                                        style: GoogleFonts.spicyRice(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
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
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      Text(
                                        stock.grade,
                                        style: GoogleFonts.manrope(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
      ),
    );
  }
}
