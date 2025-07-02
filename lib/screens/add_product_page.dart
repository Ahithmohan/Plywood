import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';
import 'package:provider/provider.dart';

import '../provider/category_provider.dart';
import '../provider/product_provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getCategories();
    });
  }

  String? _selectedCategory;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _thicknessController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _gradeController.dispose();
    _sizeController.dispose();
    _thicknessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<CategoryProvider>(context);
    final categories = provider.categories;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BuildTextFieldWidget(
                hintText: "Product Name",
                controller: _nameController,
                icon: const Icon(Icons.production_quantity_limits,
                    color: Colors.white70),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff131D4F).withOpacity(0.4),
                  prefixIcon: const Icon(Icons.category, color: Colors.white70),
                  hintText: 'Select Category',
                  hintStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.white70, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.white70, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
                value: _selectedCategory,
                items: categories.map((cat) {
                  return DropdownMenuItem<String>(
                    value: cat['type'],
                    child: Text(cat['type']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Price",
                controller: _priceController,
                keyboardType: TextInputType.number,
                icon: const Icon(Icons.attach_money, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Quantity",
                controller: _quantityController,
                keyboardType: TextInputType.number,
                icon: const Icon(Icons.format_list_numbered,
                    color: Colors.white70),
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Grade",
                controller: _gradeController,
                icon: const Icon(Icons.grade, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Size",
                controller: _sizeController,
                icon: const Icon(Icons.format_size, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Thickness",
                controller: _thicknessController,
                icon: const Icon(Icons.straight, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width / 1.5,
                child: BuildElevatedButtonWidget(
                  backgroundColor: Colors.orange,
                  text: "Add Product",
                  onPressed: () async {
                    final productProvider =
                        Provider.of<ProductProvider>(context, listen: false);

                    final productData = {
                      "name": _nameController.text.trim(),
                      "category": _selectedCategory ?? "",
                      "size": _sizeController.text.trim(),
                      "thickness": _thicknessController.text.trim(),
                      "grade": _gradeController.text.trim(),
                      "quantity":
                          int.tryParse(_quantityController.text.trim()) ?? 0,
                      "price": int.tryParse(_priceController.text.trim()) ?? 0,
                    };

                    final success =
                        await productProvider.addProduct(productData);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Product added successfully")),
                      );
                      _nameController.clear();
                      _priceController.clear();
                      _quantityController.clear();
                      _gradeController.clear();
                      _sizeController.clear();
                      _thicknessController.clear();
                      setState(() {
                        _selectedCategory = null;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to add product")),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
