import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final List<String> _categories = ['Plywood', 'MDF', 'Blockboard', 'Veneer'];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
              // Category Dropdown
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
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
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
                    onPressed: () {},
                  )),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
