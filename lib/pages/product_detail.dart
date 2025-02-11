import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String image, name, detail, price;

  const ProductDetail({
    Key? key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4EC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.brown[500],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Image.network(
                      image,
                      height: 400,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Text(
                        "Image not found",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFE9E0), Color(0xFFFFF8F4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$$price",
                        style: TextStyle(
                          color: Colors.brown[500],
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    detail,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  const SizedBox(height: 40.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            product: {
                              'image': image,
                              'name': name,
                              'price': price,
                              'quantity': 1,
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.brown[500]!, Colors.brown[300]!],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const CartPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _addProductToCart(widget.product);
  }

  void _addProductToCart(Map<String, dynamic> product) {
    // Check if the product already exists in the cart
    bool productExists = false;
    for (var item in cartItems) {
      if (item['name'] == product['name']) {
        setState(() {
          item['quantity'] += 1; // Increment quantity if product exists
        });
        productExists = true;
        break;
      }
    }

    // If the product doesn't exist, add it to the cart
    if (!productExists) {
      setState(() {
        cartItems.add(product);
      });
    }
  }

  void _showPaymentMethods() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Payment Method"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showCheckoutCompleteMessage("Cash");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[500],
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: const Text(
                "Cash",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showCheckoutCompleteMessage("Online");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[500],
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: const Text(
                "Online",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutCompleteMessage(String paymentMethod) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Checkout Complete!!",
          style: TextStyle(
            fontSize: 16,
            color: Colors.green,
          ),
        ),
        content: Text("Payment method: $paymentMethod"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the current dialog
              _showDoneMessage(); // Show the "Done" message
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showDoneMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Done",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2), // Display for 2 seconds
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deliveryCharge = 2.00;
    double total = cartItems.fold(0.0, (sum, item) => sum + double.parse(item['price']) * item['quantity']) + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.brown[500],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDF4EC),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              item['image'],
                              width: 80,
                              height: 80,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.image_not_supported,
                                size: 80,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${item['price']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (item['quantity'] > 1) {
                                    item['quantity']--;
                                  } else {
                                    cartItems.removeAt(index);
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(item['quantity'].toString()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  item['quantity']++;
                                });
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Delivery Charge:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "\$$deliveryCharge",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$$total",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showPaymentMethods,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[500],
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: const Text(
                "Checkout",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}