import 'package:flutter/material.dart';
import 'package:plywood/widgets/build_elevated_button_widget.dart';
import 'package:plywood/widgets/build_text_field_widget.dart';
import 'package:provider/provider.dart';

import '../provider/category_provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CategoryProvider>(context, listen: false);
      if (mounted && provider.categories.isEmpty) {
        provider.getCategories();
      }
    });
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  void _addCategory() async {
    final newCategory = _categoryController.text.trim();
    if (newCategory.isNotEmpty) {
      final provider = Provider.of<CategoryProvider>(context, listen: false);
      final success = await provider.addCategory(newCategory);

      if (success) {
        _categoryController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category added successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add category')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<CategoryProvider>(context);
    final isLoading = provider.isLoading;
    final categories = provider.categories;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
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
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.orange))
                  : categories.isEmpty
                      ? const Text(
                          'No categories added yet',
                          style: TextStyle(color: Colors.white54),
                        )
                      : ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final item = categories[index];
                            final id = item['_id'];
                            final type = item['type'];

                            return Card(
                              color: Colors.grey[800],
                              child: ListTile(
                                title: SizedBox(
                                  height: 40,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.grey[800],
                                    child: Center(
                                      child: Text(
                                        type,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Card(
                                      color: Colors.grey[800],
                                      elevation: 5,
                                      shadowColor: Colors.black,
                                      child: IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.greenAccent),
                                        onPressed: () async {
                                          _categoryController.text = type;

                                          final updated =
                                              await showDialog<String>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.grey[900],
                                              title: const Text(
                                                "Edit Category",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              content: TextField(
                                                controller: _categoryController,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'New category name',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white54),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    final newType =
                                                        _categoryController.text
                                                            .trim();
                                                    Navigator.pop(
                                                        context, newType);
                                                  },
                                                  child: const Text(
                                                    'Update',
                                                    style: TextStyle(
                                                        color: Colors.orange),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (!mounted ||
                                              updated == null ||
                                              updated.isEmpty ||
                                              updated == type) return;

                                          final success = await provider
                                              .updateCategory(id, updated);
                                          if (!mounted) return;

                                          if (mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(success
                                                    ? 'Category updated'
                                                    : 'Failed to update category'),
                                              ),
                                            );
                                          }

                                          _categoryController.clear();
                                        },
                                      ),
                                    ),
                                    Card(
                                      color: Colors.grey[800],
                                      elevation: 5,
                                      shadowColor: Colors.black,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () async {
                                          final confirm =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.grey[900],
                                              title: const Text(
                                                "Confirm Delete",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              content: Text(
                                                'Are you sure you want to delete "$type"?',
                                                style: const TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (!mounted || confirm != true)
                                            return;

                                          final success =
                                              await provider.deleteCategory(id);
                                          if (!mounted) return;

                                          if (mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(success
                                                    ? 'Category deleted'
                                                    : 'Failed to delete category'),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
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
