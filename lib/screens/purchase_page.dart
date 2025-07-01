import 'package:flutter/material.dart';
import 'package:plywood/screens/purchase_list_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';
import 'package:provider/provider.dart';

import '../provider/purchase_provider.dart';

class PurchasePage extends StatefulWidget {
  final String? id; // For updating
  final String? customerName;
  final String? customerNumber;
  final String? product;
  final int? quantity;
  final int? price;
  final String? date;
  const PurchasePage(
      {super.key,
      this.id,
      this.customerName,
      this.customerNumber,
      this.product,
      this.quantity,
      this.price,
      this.date});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.customerName ?? '';
    _phoneController.text = widget.customerNumber ?? '';
    _productController.text = widget.product ?? '';
    _quantityController.text = widget.quantity?.toString() ?? '';
    _priceController.text = widget.price?.toString() ?? '';
    _dateController.text = widget.date ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _productController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // void _submitForm(BuildContext context) async {
  //   final provider = Provider.of<PurchaseProvider>(context, listen: false);
  //
  //   // Basic validation
  //   if (_nameController.text.trim().isEmpty ||
  //       _productController.text.trim().isEmpty ||
  //       _quantityController.text.trim().isEmpty ||
  //       _priceController.text.trim().isEmpty ||
  //       _dateController.text.trim().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill all required fields')),
  //     );
  //     return;
  //   }
  //
  //   final success = await provider.addPurchase(
  //     customerName: _nameController.text.trim(),
  //     customerNumber: _phoneController.text.trim(),
  //     product: _productController.text.trim(),
  //     quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
  //     date: _dateController.text.trim(),
  //     price: int.tryParse(_priceController.text.trim()) ?? 0,
  //   );
  //
  //   if (success) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Purchase added successfully')),
  //     );
  //     _nameController.clear();
  //     _phoneController.clear();
  //     _productController.clear();
  //     _quantityController.clear();
  //     _priceController.clear();
  //     _dateController.clear();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Failed to add purchase')),
  //     );
  //   }
  // }
  void _submitForm(BuildContext context) async {
    final provider = Provider.of<PurchaseProvider>(context, listen: false);

    // Validation
    if (_nameController.text.trim().isEmpty ||
        _productController.text.trim().isEmpty ||
        _quantityController.text.trim().isEmpty ||
        _priceController.text.trim().isEmpty ||
        _dateController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final isUpdate = widget.id != null;

    final success = isUpdate
        ? await provider.updatePurchase(
            id: widget.id!,
            customerName: _nameController.text.trim(),
            customerNumber: _phoneController.text.trim(),
            product: _productController.text.trim(),
            quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
            date: _dateController.text.trim(),
            price: int.tryParse(_priceController.text.trim()) ?? 0,
          )
        : await provider.addPurchase(
            customerName: _nameController.text.trim(),
            customerNumber: _phoneController.text.trim(),
            product: _productController.text.trim(),
            quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
            date: _dateController.text.trim(),
            price: int.tryParse(_priceController.text.trim()) ?? 0,
          );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isUpdate ? 'Updated successfully' : 'Purchase added'),
        ),
      );

      if (isUpdate) {
        // Go back to previous screen after update
        await provider.fetchPurchases();

        Navigator.pop(context);
      } else {
        // Clear the form after adding
        _nameController.clear();
        _phoneController.clear();
        _productController.clear();
        _quantityController.clear();
        _priceController.clear();
        _dateController.clear();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save purchase')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<PurchaseProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Purchase Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BuildTextFieldWidget(
                  controller: _nameController,
                  hintText: "Customer Name",
                  icon: const Icon(Icons.person, color: Colors.white70)),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  hintText: "Customer Phone",
                  icon: const Icon(Icons.phone, color: Colors.white70)),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                  controller: _productController,
                  hintText: "Product Name",
                  icon: const Icon(Icons.shopping_cart, color: Colors.white70)),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  hintText: "Quantity",
                  icon: const Icon(Icons.format_list_numbered,
                      color: Colors.white70)),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  hintText: "Price",
                  icon: const Icon(Icons.attach_money, color: Colors.white70)),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark(), // for dark mode UI
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
                child: AbsorbPointer(
                  child: BuildTextFieldWidget(
                    controller: _dateController,
                    hintText: "Date",
                    icon: const Icon(Icons.date_range, color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
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
                          builder: (context) => const PurchaseListPage()),
                    );
                  },
                ),
              ),
              SizedBox(
                width: width / 2.5,
                child: provider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.orange))
                    : BuildElevatedButtonWidget(
                        backgroundColor: Colors.orange,
                        text: "Submit",
                        onPressed: () => _submitForm(context),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
