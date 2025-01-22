import 'package:flutter/material.dart';
import 'package:pet_care_app/model/product.dart';

class ShopFood extends StatefulWidget {
  const ShopFood({super.key});

  @override
  State<ShopFood> createState() => _ShopFoodState();
}

class _ShopFoodState extends State<ShopFood>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<Product>> categoryProducts = {
    'Food': [
      Product(
        name: 'Josera Mini Deluxe',
        price: 2000.00,
        image: 'assets/images/josiDogFood.png',
        category: 'Furry',
        weight: '900g',
      ),
      Product(
        name: 'Pedigree Chicken & Vege',
        price: 1500.00,
        image: 'assets/images/josiDogFood.png',
        category: 'Basic',
        weight: '900g',
      ),
    ],
    'Vet Items': [
      Product(
        name: 'Vet Supplement A',
        price: 1200.00,
        image: 'assets/images/vetSupplement.png',
        category: 'Health',
        weight: '500g',
      ),
    ],
    'Accessories': [],
    'DIY Services': [],
  };

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: categoryProducts.keys.length, vsync: this);
    _tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    setState(() {}); // Trigger rebuild on tab change
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Shop', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search keywords...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Colors.blue,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.normal),
                  tabs: categoryProducts.keys.map((category) {
                    IconData icon;
                    switch (category) {
                      case 'Food':
                        icon = Icons.food_bank;
                        break;
                      case 'Vet Items':
                        icon = Icons.medical_services;
                        break;
                      case 'Accessories':
                        icon = Icons.toys;
                        break;
                      case 'DIY Services':
                        icon = Icons.build;
                        break;
                      default:
                        icon = Icons.help;
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _tabController.index ==
                                    categoryProducts.keys
                                        .toList()
                                        .indexOf(category)
                                ? Colors.blue
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(icon, size: 30, color: Colors.black),
                        ),
                        Text(
                          category,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categoryProducts.entries.map((entry) {
          final products = entry.value;
          if (products.isEmpty) {
            return const Center(
              child: Text('No products available for this category.'),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        }).toList(),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;

  void _addToCart() {
    setState(() {
      if (_quantity == 0) {
        _quantity = 1;
      }
    });
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } else {
        _quantity = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 40,
            child: Image.asset(
              widget.product.image,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.product.category,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RS.${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    widget.product.weight,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  if (_quantity == 0)
                    InkWell(
                      onTap: _addToCart,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.shopping_bag_outlined,
                                color: Colors.black),
                            SizedBox(width: 8),
                            Text(
                              'Add to cart',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _decrement,
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _increment,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
