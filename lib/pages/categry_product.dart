import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_detail.dart'; // Ensure this import matches your file structure

class CategoryProduct extends StatefulWidget {
  final String category;

  const CategoryProduct({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text(
          'Category: ${widget.category}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[500],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products3')
                  .where('category', isEqualTo: widget.category)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading products'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No products found in this category'),
                  );
                }

                final products = snapshot.data!.docs;

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index].data()
                    as Map<String, dynamic>; // Explicit cast

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(
                              detail: product["detail"] ?? 'No details available',
                              image: product["image"] ?? '',
                              name: product["name"] ?? 'Unnamed Product',
                              price: product["price"]?.toString() ?? '0.00',
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(product["image"] ?? ''),
                                  fit: BoxFit.contain, // Ensures proper fitting
                                ),
                              ),
                              child: product["image"] == null
                                  ? const Icon(Icons.error,
                                  color: Colors.red, size: 50)
                                  : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product["name"] ?? 'Unnamed Product',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "   \$${product["price"]?.toString() ?? '0.00'}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                   SizedBox(width: 70), // Space between price and icon
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.brown[200],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
