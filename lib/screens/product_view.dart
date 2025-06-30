import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
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
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: width / 2.5,
                child: BuildElevatedButtonWidget(
                  backgroundColor: Colors.red,
                  text: "Delete",
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Product View',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
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
                padding:
                    const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                child: Text(
                  'Product Details',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                    'Product Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category: Plywood',
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
                    'Grade: A',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Price: \$1200',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Size: 8x4 ft',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Thickness: 18MM',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  BuildElevatedButtonWidget(
                    text: "Stock Out",
                    backgroundColor: Colors.red,
                    onPressed: () {},
                  )
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
