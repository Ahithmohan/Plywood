import 'package:flutter/material.dart';
import 'package:plywood/screens/purchase_list_page.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';
import 'package:provider/provider.dart';

import '../provider/customer_provider.dart';
import '../provider/purchase_provider.dart';
import '../widgets/build_text_widget.dart';

class PurchasePage extends StatefulWidget {
  final String? id; // For updating
  final String? customerName;
  final String? customerNumber;
  final List<Map<String, dynamic>>? products;
  final int? quantity;
  final int? price;
  final String? date;
  const PurchasePage(
      {super.key,
      this.id,
      this.customerName,
      this.customerNumber,
      this.quantity,
      this.price,
      this.date,
      this.products});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  List<Map<String, dynamic>> _filteredCustomers = [];
  List<Map<String, TextEditingController>> _productFields = [];

  final FocusNode _nameFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    customerProvider.fetchCustomers();

    _nameController.text = widget.customerName ?? '';
    _phoneController.text = widget.customerNumber ?? '';
    _dateController.text = widget.date ?? '';

    if (widget.id != null && widget.products != null) {
      // Correctly cast and assign each product field
      final List products = widget.products!;
      for (var product in products) {
        if (product is Map<String, dynamic>) {
          _productFields.add({
            'product': TextEditingController(text: product['product'] ?? ''),
            'quantity': TextEditingController(
                text: product['quantity']?.toString() ?? ''),
            'price':
                TextEditingController(text: product['price']?.toString() ?? ''),
          });
        }
      }
    } else {
      _addProductFields(); // Default if adding new
    }

    _nameController.addListener(() {
      final input = _nameController.text.toLowerCase();
      final customers = customerProvider.customers;
      setState(() {
        _filteredCustomers = customers
            .where((c) => c['name'].toLowerCase().contains(input))
            .toList();
      });
    });
  }

  void _addProductFields() {
    setState(() {
      _productFields.add({
        'product': TextEditingController(),
        'quantity': TextEditingController(),
        'price': TextEditingController(),
      });
    });
  }

  void _removeProductField(int index) {
    setState(() {
      _productFields[index].forEach((key, controller) {
        controller.dispose(); // dispose controllers
      });
      _productFields.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _productController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    _nameFocusNode.dispose();
    for (var map in _productFields) {
      map.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  void _submitForm(BuildContext context) async {
    final provider = Provider.of<PurchaseProvider>(context, listen: false);

    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _dateController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    // Build the products list
    List<Map<String, dynamic>> products = [];
    for (var field in _productFields) {
      final product = field['product']!.text.trim();
      final quantity = int.tryParse(field['quantity']!.text.trim()) ?? 0;
      final price = int.tryParse(field['price']!.text.trim()) ?? 0;

      if (product.isEmpty || quantity <= 0 || price <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete all product fields')),
        );
        return;
      }

      products.add({
        'product': product,
        'quantity': quantity,
        'price': price,
        'balance': quantity * price,
      });
    }

    final isUpdate = widget.id != null;

    final success = isUpdate
        ? await provider.updatePurchase(
            id: widget.id!,
            customerName: _nameController.text.trim(),
            customerNumber: _phoneController.text.trim(),
            date: _dateController.text.trim(),
            products: products,
          )
        : await provider.addPurchase(
            customerName: _nameController.text.trim(),
            customerNumber: _phoneController.text.trim(),
            date: _dateController.text.trim(),
            products: products,
          );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isUpdate ? 'Updated successfully' : 'Purchase added'),
        ),
      );

      if (isUpdate) {
        await provider.fetchPurchases();
        Navigator.pop(context);
      } else {
        _nameController.clear();
        _phoneController.clear();
        _dateController.clear();
        setState(() {
          for (var field in _productFields) {
            field['product']!.clear();
            field['quantity']!.clear();
            field['price']!.clear();
          }
        });
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
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BuildTextFieldWidget(
                controller: _nameController,
                focusNode: _nameFocusNode,
                hintText: "Customer Name",
                suffixIcon: GestureDetector(
                  onTap: () {
                    final nameController = TextEditingController();
                    final phoneController = TextEditingController();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xff1e1e1e),
                          title: const Text(
                            "Add Customer",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 140,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BuildTextFieldWidget(
                                  controller: nameController,
                                  hintText: "Customer Name",
                                  icon: const Icon(Icons.person,
                                      color: Colors.white70),
                                ),
                                const SizedBox(height: 12),
                                BuildTextFieldWidget(
                                  controller: phoneController,
                                  hintText: "Phone Number",
                                  icon: const Icon(Icons.phone,
                                      color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            BuildElevatedButtonWidget(
                              text: "Add",
                              backgroundColor: Colors.orange,
                              onPressed: () async {
                                final name = nameController.text.trim();
                                final phone = phoneController.text.trim();

                                if (name.isEmpty || phone.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Please fill all fields")),
                                  );
                                  return;
                                }

                                final customerProvider =
                                    Provider.of<CustomerProvider>(context,
                                        listen: false);
                                final success = await customerProvider
                                    .addCustomer(name: name, phone: phone);

                                if (success) {
                                  await customerProvider.fetchCustomers();

                                  // Re-run filter to update _filteredCustomers
                                  final input =
                                      _nameController.text.toLowerCase();
                                  final customers = customerProvider.customers;
                                  setState(() {
                                    _filteredCustomers = customers
                                        .where((c) => c['name']
                                            .toLowerCase()
                                            .contains(input))
                                        .toList();
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Customer added successfully")),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Failed to add customer")),
                                  );
                                }
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                icon: const Icon(Icons.person, color: Colors.white70),
              ),
              if (_filteredCustomers.isNotEmpty && _nameFocusNode.hasFocus)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = _filteredCustomers[index];
                      return ListTile(
                        title: Text(customer['name'],
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(customer['phone'],
                            style: const TextStyle(color: Colors.white70)),
                        onTap: () {
                          setState(() {
                            _nameController.text = customer['name'];
                            _phoneController.text = customer['phone'];
                            _filteredCustomers.clear(); // hide suggestions
                            _nameFocusNode.unfocus();
                          });
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 10),
              BuildTextFieldWidget(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  hintText: "Customer Phone",
                  icon: const Icon(Icons.phone, color: Colors.white70)),
              const SizedBox(height: 10),
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
              SizedBox(
                height: 20,
              ),
              ..._productFields.asMap().entries.map((entry) {
                final index = entry.key;
                final map = entry.value;
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildTextWidget(
                            text: "Product ${index + 1}",
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          if (_productFields.length > 1)
                            IconButton(
                              onPressed: () => _removeProductField(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      BuildTextFieldWidget(
                        controller: map['product']!,
                        hintText: "Product Name",
                        icon: const Icon(Icons.shopping_cart,
                            color: Colors.white70),
                      ),
                      const SizedBox(height: 10),
                      BuildTextFieldWidget(
                        controller: map['quantity']!,
                        keyboardType: TextInputType.number,
                        hintText: "Quantity",
                        icon: const Icon(Icons.format_list_numbered,
                            color: Colors.white70),
                      ),
                      const SizedBox(height: 10),
                      BuildTextFieldWidget(
                        controller: map['price']!,
                        keyboardType: TextInputType.number,
                        hintText: "Price",
                        icon: const Icon(Icons.attach_money,
                            color: Colors.white70),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }).toList(),
              GestureDetector(
                onTap: _addProductFields,
                child: Container(
                  width: width / 2.5,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue),
                  child: Center(
                    child: BuildTextWidget(
                      text: "Add Product",
                      fontSize: 15,
                      align: TextAlign.center,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: height / 5.5,
        width: width,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
