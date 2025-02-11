import 'package:flutter/material.dart';
import 'package:final_pro/services/shared_pref.dart';
import 'package:final_pro/pages/categry_product.dart'; // Import CategoryProduct widget
import 'package:final_pro/widget/support_widget.dart';



class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/tv.png",
  ];

  List categoryNames = [
    "Headphone",
    "Laptop",
    "Watch",
    "TV",
  ];

  String? name;
  String? gender;

  // Get user details from shared preferences
  Future<void> getSharedPref() async {
    name = await SharedPreferenceHelper().getUserName();
    gender = await SharedPreferenceHelper().getUserGender();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: name == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey $name!",
                          style: AppWidget.boldTextFeildStyle(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Text(
                          "Good Morning",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ClipOval(
                    child: Image.asset(
                      getImageForName(name),
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.brown[300],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories", style: AppWidget.semiboldTextFeildStyle()),
                  Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.brown[200],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Container(
                    height: 135.0,
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.brown[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 90.0,
                    child: const Center(
                      child: Text(
                        "All",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 135.0,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            image: categories[index],
                            name: categoryNames[index],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Products", style: AppWidget.semiboldTextFeildStyle()),
                  Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.brown[200],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 240,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    productCard("images/headphone3.png", "Headphone", "\$100"),
                    productCard("images/watch3.png", "Watch", "\$150"),
                    productCard("images/laptop2.png", "Laptop", "\$1500"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to determine profile image based on the name's first letter
  String getImageForName(String? name) {
    if (name == null || name.isEmpty) {
      return "images/default.png"; // Default image
    }
    String firstLetter = name[0].toUpperCase(); // Get first letter in uppercase
    if (RegExp(r'[A-Z]').hasMatch(firstLetter)) {
      return "images/$firstLetter.png"; // Path to corresponding image
    }
    return "images/default.png"; // Default image for invalid cases
  }

  // Product card widget
  Widget productCard(String image, String title, String price) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Text(
            title,
            style: AppWidget.semiboldTextFeildStyle(),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                price,
                style: TextStyle(
                  color: Colors.brown[200],
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 50.0),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.brown[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image;
  final String name;

  const CategoryTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProduct(category: name),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 90.0,
        width: 90.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}