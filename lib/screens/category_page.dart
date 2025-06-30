import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _categoryController = TextEditingController();
  final List<String> _categories = [];

  void _addCategory() {
    final newCategory = _categoryController.text.trim();
    if (newCategory.isNotEmpty) {
      setState(() {
        _categories.add(newCategory);
        _categoryController.clear(); // Clear input after adding
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BuildTextFieldWidget(
              controller: _categoryController,
              hintText: "Category Name",
              icon: const Icon(Icons.category, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: width / 1.5,
              child: BuildElevatedButtonWidget(
                backgroundColor: Colors.orange,
                text: "Add",
                onPressed: _addCategory,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _categories.isEmpty
                  ? const Text(
                      'No categories added yet',
                      style: TextStyle(color: Colors.white54),
                    )
                  : ListView.builder(
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey[800],
                          child: ListTile(
                            trailing: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            title: Text(
                              _categories[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
