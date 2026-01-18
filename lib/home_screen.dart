import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Recipe {
  final String title;
  final String imagePath;
  final List<String> tags;
  final String time;
  final String steps;
  bool isFavorite;
  final String typeIcon;

  Recipe({
    required this.title,
    required this.imagePath,
    required this.tags,
    required this.time,
    required this.steps,
    this.isFavorite = false,
    required this.typeIcon,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = 'Ahmed';
  String _userLevel = 'Chef';
  int _selectedIndex = 0;

  final List<Recipe> _recipes = [
    Recipe(
      title: 'Chicken Alfredo',
      imagePath: 'assets/images/chicken_alfredo.png',
      tags: ['Chicken', 'Vegetables', 'Pasta'],
      time: '35 Minutes',
      steps: '8 Steps',
      typeIcon: 'assets/icons/meat.svg',
    ),
    Recipe(
      title: 'Fried Rice',
      imagePath: 'assets/images/fried_rice.png',
      tags: ['Rice', 'Vegetables', 'Eggs'],
      time: '20 Minutes',
      steps: '3 Steps',
      typeIcon: 'assets/icons/leaf.svg',
    ),
    Recipe(
      title: 'Steak & Fries',
      imagePath: 'assets/images/steak_fries.png',
      tags: ['Meat', 'Potatoes', 'Sauce'],
      time: '20 Minutes',
      steps: '3 Steps',
      typeIcon: 'assets/icons/meat.svg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'User';
      _userLevel =
          prefs.getString('user_level') ?? 'Beginner';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1118),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1118),
        elevation: 0,
        titleSpacing: 24,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.hedvigLettersSerif(
                  fontSize: 24,
                ),
                children: [
                  const TextSpan(text: 'Good Morning, '),
                  TextSpan(
                    text: '$_userName!',
                    style: const TextStyle(
                      color: Color(0xFFDB7A2B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ready to cook something amazing?',
              style: GoogleFonts.nunito(
                color: const Color(0xFF888481),
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 24),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF161A22),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                const Text(
                  '🔥',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                Text(
                  _userLevel,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: _selectedIndex == 1
                  ? _buildFavoritesList()
                  : Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        _buildChallengeCard(),
                        const SizedBox(height: 24),

                        _buildRandomRecipeCard(),
                        const SizedBox(height: 32),

                        Text(
                          'Recipes',
                          style:
                              GoogleFonts.hedvigLettersSerif(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                        ),
                        const SizedBox(height: 16),

                        _buildSearchAndFilter(),
                        const SizedBox(height: 24),

                        ..._recipes.map(
                          (recipe) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                            ),
                            child: RecipeItem(
                              recipe: recipe,
                              onFavoriteToggle: () {
                                setState(() {
                                  recipe.isFavorite =
                                      !recipe.isFavorite;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    final favorites = _recipes
        .where((r) => r.isFavorite)
        .toList();

    if (favorites.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              const Icon(
                Icons.favorite_border,
                size: 64,
                color: Color(0xFF888481),
              ),
              const SizedBox(height: 16),
              Text(
                'No favorites yet',
                style: GoogleFonts.nunito(
                  color: const Color(0xFF888481),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Favorites',
          style: GoogleFonts.hedvigLettersSerif(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 24),
        ...favorites.map(
          (recipe) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RecipeItem(
              recipe: recipe,
              onFavoriteToggle: () {
                setState(() {
                  recipe.isFavorite = !recipe.isFavorite;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF161A22),
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: ResizeImage(
            AssetImage('assets/images/chicken_noodle.png'),
            width: 800,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF181B21).withOpacity(0.9),
              Color(0xFF181B21).withOpacity(0.0),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/challenge.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFDB7A2B),
                    BlendMode.srcIn,
                  ),
                  height: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  "Today's Challenge",
                  style: GoogleFonts.nunito(
                    color: const Color(0xFFDB7A2B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Chicken Noodle Stir Fry',
              style: GoogleFonts.hedvigLettersSerif(
                color: const Color(0xFFDB7A2B),
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildTag('Chicken'),
                const SizedBox(width: 8),
                _buildTag('Vegetables'),
                const SizedBox(width: 8),
                _buildTag('Pasta'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/time.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF888481),
                    BlendMode.srcIn,
                  ),
                  height: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '40 Minutes',
                  style: GoogleFonts.nunito(
                    color: const Color(0xFF888481),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(
                  'assets/icons/step.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF888481),
                    BlendMode.srcIn,
                  ),
                  height: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '4 Steps',
                  style: GoogleFonts.nunito(
                    color: const Color(0xFF888481),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDB7A2B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {},
              child: Text(
                'Start Challenge',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRandomRecipeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161A22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF2C3E50),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/dice.png',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Random Recipe',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Don't know what to cook?",
                  style: GoogleFonts.nunito(
                    color: const Color(0xFF888481),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/arrow_diagonal.svg',
              height: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search for a recipe...',
              hintStyle: const TextStyle(
                color: Color(0xFF888481),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF888481),
              ),
              filled: true,
              fillColor: const Color(0xFF161A22),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildIconButton(Icons.grid_view),
        const SizedBox(width: 8),
        _buildIconButton(Icons.menu),
        const SizedBox(width: 8),
        _buildIconButton(Icons.filter_list),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161A22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: const Color(0xFF888481),
        size: 24,
      ),
    );
  }

  Widget _buildTag(String text, {double fontSize = 12}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2C3039),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.nunito(
          color: Colors.white70,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 32,
      ),
      color: const Color(0xFF0E1118),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(
            'assets/icons/explore.svg',
            'Explore',
            0,
          ),
          _buildNavItem(
            null,
            'Favorites',
            1,
            iconData: Icons.favorite_border,
          ),
          _buildNavItem(
            null,
            'History',
            2,
            iconData: Icons.bar_chart,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    String? svgPath,
    String label,
    int index, {
    IconData? iconData,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: isSelected
                ? const BoxDecoration(
                    color: Color(0xFFDB7A2B),
                    shape: BoxShape.circle,
                  )
                : null,
            child: svgPath != null
                ? SvgPicture.asset(
                    svgPath,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? Colors.white
                          : const Color(0xFF888481),
                      BlendMode.srcIn,
                    ),
                    height: 24,
                  )
                : Icon(
                    iconData,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF888481),
                    size: 24,
                  ),
          ),
          if (isSelected) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ] else ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.nunito(
                color: const Color(0xFF888481),
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onFavoriteToggle;

  const RecipeItem({
    super.key,
    required this.recipe,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161A22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.asset(
                  recipe.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  cacheWidth: 300,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(
                            0xFF181B21,
                          ).withOpacity(0.8),
                          Color(
                            0xFF181B21,
                          ).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: recipe.tags
                      .map((t) => _buildTag(t))
                      .toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/time.svg',
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF888481),
                        BlendMode.srcIn,
                      ),
                      height: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe.time,
                      style: GoogleFonts.nunito(
                        color: const Color(0xFF888481),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/step.svg',
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF888481),
                        BlendMode.srcIn,
                      ),
                      height: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe.steps,
                      style: GoogleFonts.nunito(
                        color: const Color(0xFF888481),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  recipe.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: recipe.isFavorite
                      ? const Color(0xFFDB7A2B)
                      : Colors.grey,
                  size: 24,
                ),
                onPressed: onFavoriteToggle,
              ),
              const SizedBox(height: 16),
              SvgPicture.asset(recipe.typeIcon, height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2C3039),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.nunito(
          color: Colors.white70,
          fontSize: 10,
        ),
      ),
    );
  }
}
