import 'dart:async';
import 'package:flutter/material.dart';

import '../../data/data_sources/category_data_source.dart';

import '../../model/product_model.dart';
import '../../repository/product_repository.dart';
import '../../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _filteredProducts = ProductRepository.allProducts();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredProducts = query.isEmpty
          ? ProductRepository.allProducts()
          : ProductRepository.search(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de busca com controle
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search anything...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),

            if (_searchController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _filteredProducts.isEmpty
                    ? const Text("No result found")
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 270,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return ProductCard(product: product);
                        },
                      ),
              )
            else ...[
              const SectionTitle(title: 'Categories'),
              const SizedBox(height: 8),
              CategorySection(),
              const SizedBox(height: 16),
              const PromoBanner(),
              const SizedBox(height: 16),
              const SectionTitle(title: 'Deal of the Day'),
              const DealCountdownTimer(),
              const SizedBox(height: 16),
              // Produtos da seção específica
              ProductGridSection(),
              HorizontalProductSection(
                title: 'Hot Selling Footwear',
                products: ProductRepository.hotSelling(),
              ),
              HorizontalProductSection(
                title: 'Recommended for you',
                products: ProductRepository.recommended(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // abrir drawer
            },
          ),
          const Text(
            'Home',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        IconWithDot(icon: Icons.notifications_none),
        const SizedBox(width: 8),
        IconWithDot(icon: Icons.shopping_bag_outlined),
        const SizedBox(width: 16),
      ],
    );
  }
}

class IconWithDot extends StatelessWidget {
  final IconData icon;

  const IconWithDot({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.black87),
          onPressed: () {
            // ação do ícone
          },
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;

  const SectionTitle({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: category.backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  category.icon,
                  size: 28,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category.label,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBanner> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<ProductModel> promoBanners =
      ProductRepository.promoBannerProducts();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: promoBanners.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final product = promoBanners[index];
              return PromoBannerCard(imagePath: product.image!);
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            promoBanners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 16 : 8,
              decoration: BoxDecoration(
                color:
                    _currentPage == index ? Colors.blue : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PromoBannerCard extends StatelessWidget {
  final String imagePath;

  const PromoBannerCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Imagem do lado direito
          Expanded(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DealCountdownTimer extends StatefulWidget {
  const DealCountdownTimer({super.key});

  @override
  State<DealCountdownTimer> createState() => _DealCountdownTimerState();
}

class _DealCountdownTimerState extends State<DealCountdownTimer> {
  Duration _timeLeft = const Duration(hours: 11, minutes: 15, seconds: 4);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timeLeft.inSeconds > 0) {
        setState(() => _timeLeft -= const Duration(seconds: 1));
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _pad(int number) => number.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final hours = _pad(_timeLeft.inHours);
    final minutes = _pad(_timeLeft.inMinutes.remainder(60));
    final seconds = _pad(_timeLeft.inSeconds.remainder(60));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimeBlock(hours, 'HRS'),
            const SizedBox(width: 8),
            _buildTimeBlock(minutes, 'MIN'),
            const SizedBox(width: 8),
            _buildTimeBlock(seconds, 'SEC'),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBlock(String value, String label) {
    return Row(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ProductGridSection extends StatelessWidget {
  const ProductGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = ProductRepository.dealOfTheDay();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 250,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 📷 Imagem com proporção 1:1
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 🧾 Título centralizado
              Text(
                product.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 6),

              // 🏷️ Desconto (se houver)
              if (product.discountLabel != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    product.discountLabel!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class HorizontalProductSection extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  const HorizontalProductSection({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título + botão "View All"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text('View All'),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 12),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Lista horizontal de produtos
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCardHorizontal(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCardHorizontal extends StatelessWidget {
  final ProductModel product;

  const ProductCardHorizontal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔲 Imagem + Top Seller + Favorito
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.image!,
                  height: 120,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              if (product.isTopSeller)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Top Seller',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: product.isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 📝 Título
          Text(
            product.title!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            maxLines: 2,
          ),

          const SizedBox(height: 4),

          // 💰 Preço ou Desconto
          if (product.price != null) ...[
            Row(
              children: [
                Text(
                  '\$${product.price!.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                if (product.originalPrice != null)
                  Text(
                    '\$${product.originalPrice!.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ] else if (product.discountLabel != null) ...[
            Text(
              product.discountLabel!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],

          const SizedBox(height: 4),

          // ⭐ Avaliação
          if (product.rating != null && product.reviews != null)
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  product.rating!.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${product.reviews})',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
