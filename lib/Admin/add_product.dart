import 'dart:convert'; // For base64 encoding
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  String? selectedCategory; // To store selected category
  bool isLoading = false;

  // Categories list
  final List<String> categoryItems = [
    'Watch',
    'Laptop',
    'TV',
    'Headphone',
  ];

  /// Select image from gallery
  Future<void> getImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  /// Save product to Firestore
  Future<void> saveProductToFirestore() async {
    if (selectedImage == null ||
        nameController.text.isEmpty ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill all fields and select an image.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Convert image to Base64
      String base64Image = base64Encode(selectedImage!.readAsBytesSync());

      // Save to Firestore
      await FirebaseFirestore.instance.collection("products2").add({
        "name": nameController.text,
        "image": base64Image,
        "category": selectedCategory,
        "Price":priceController.text,
        "Detail":detailController.text,
       // "created_at": DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product added successfully!")),
      );

      // Reset form
      setState(() {
        selectedImage = null;
        nameController.clear();
        selectedCategory = null;
      });
    } catch (e) {
      debugPrint("Error saving product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to save product.")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upload the product image",
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: GestureDetector(
                  onTap: getImageFromGallery,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                      image: selectedImage != null
                          ? DecorationImage(
                        image: FileImage(selectedImage!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: selectedImage == null
                        ? const Icon(Icons.camera_alt_outlined, size: 50)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
               Text(
                "Product Name",
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter product name",
                ),
              ),
              Text(
                "Product Price",
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),

                ),
              ),
              Text(
                "Product Details",
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0),
              TextField(
                maxLines: 10,
                controller: detailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),

                ),
              ),

               SizedBox(height: 20.0),
              Text(
                "Product Category",
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: categoryItems
                        .map(
                          (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    dropdownColor: Colors.white,
                    hint: const Text("Select Category"),
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: selectedCategory,
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Center(
                child: ElevatedButton(
                  onPressed: saveProductToFirestore,
                  child: const Text("Add Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
