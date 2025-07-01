import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';
import 'package:provider/provider.dart';

import '../provider/category_provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getCategories();
    });
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
                    value: cat['_id'],
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
                icon: const Icon(Icons.attach_money, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Quantity",
                icon: const Icon(Icons.format_list_numbered,
                    color: Colors.white70),
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Grade",
                icon: const Icon(Icons.grade, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Size",
                icon: const Icon(Icons.format_size, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              BuildTextFieldWidget(
                hintText: "Product Thickness",
                icon: const Icon(Icons.straight, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width / 1.5,
                child: BuildElevatedButtonWidget(
                  backgroundColor: Colors.orange,
                  text: "Add Product",
                  onPressed: () {
                    // handle add product
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
