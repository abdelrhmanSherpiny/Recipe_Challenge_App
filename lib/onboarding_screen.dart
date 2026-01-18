import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  String _name = '';
  String _level = 'Beginner';
  final TextEditingController _nameController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    if (_name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    await prefs.setString('user_name', _name);
    await prefs.setString('user_level', _level);

    if (mounted) {
      context.router.replace(const HomeRoute());
    }
  }

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1118),
      body: Stack(
        children: [
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth > 600;
                return Image.asset(
                  isTablet
                      ? 'assets/images/tablet_back.png'
                      : 'assets/images/phone_back.png',
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.1),
                );
              },
            ),
          ),

          PageView(
            controller: _controller,
            onPageChanged: (index) =>
                setState(() => _currentPage = index),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildPage1(),
              _buildPage2(),
              _buildPage3(),
            ],
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  height: 6,
                  width: _currentPage == index ? 24 : 6,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFFDB7A2B)
                        : const Color(0xFF2C3039),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white54,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage1() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMagnet = constraints.maxWidth > 600;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/ChefClipArt1.png',
              height: isMagnet ? 400 : 300,
            ),
            const SizedBox(height: 40),
            Text(
              'Master Your',
              textAlign: TextAlign.center,
              style: GoogleFonts.hedvigLettersSerif(
                color: Colors.white,
                fontSize: isMagnet ? 48 : 32,
              ),
            ),
            Text(
              'Cooking Time',
              textAlign: TextAlign.center,
              style: GoogleFonts.hedvigLettersSerif(
                color: const Color(0xFFDB7A2B),
                fontSize: isMagnet ? 48 : 32,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMagnet ? 100.0 : 32.0,
              ),
              child: Text(
                'Turn cooking into an exciting challenge. Race against time, improve your skills, and become a kitchen champion!',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: const Color(0xFF888481),
                  fontSize: isMagnet ? 20 : 16,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(
                isMagnet ? 48.0 : 24.0,
              ),
              child: SizedBox(
                width: isMagnet ? 400 : double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFDB7A2B,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  onPressed: _nextPage,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tell Me More',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        );
      },
    );
  }

  Widget _buildPage2() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              'Cook, Compete,',
              textAlign: TextAlign.center,
              style: GoogleFonts.hedvigLettersSerif(
                color: Colors.white,
                fontSize: isTablet ? 48 : 32,
              ),
            ),
            Text(
              'Conquer',
              textAlign: TextAlign.center,
              style: GoogleFonts.hedvigLettersSerif(
                color: const Color(0xFFDB7A2B),
                fontSize: isTablet ? 48 : 32,
              ),
            ),
            const SizedBox(height: 40),

            if (isTablet)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildFeatureItem(
                        Icons.timer_outlined,
                        'Time Each Step',
                        'Follow recipe steps with built-in timers',
                        isTablet: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildFeatureItem(
                        Icons.emoji_events_outlined,
                        'Beat The Clock',
                        'Match or beat expected cooking times',
                        isTablet: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildFeatureItem(
                        Icons.bar_chart,
                        'Track Progress',
                        'See your improvement over time',
                        isTablet: true,
                      ),
                    ),
                  ],
                ),
              )
            else ...[
              _buildFeatureItem(
                Icons.timer_outlined,
                'Time Each Step',
                'Follow recipe steps with built-in timers',
              ),
              const SizedBox(height: 20),
              _buildFeatureItem(
                Icons.emoji_events_outlined,
                'Beat The Clock',
                'Match or beat expected cooking times',
              ),
              const SizedBox(height: 20),
              _buildFeatureItem(
                Icons.bar_chart,
                'Track Progress',
                'See your improvement over time',
              ),
            ],

            const Spacer(),

            Padding(
              padding: EdgeInsets.all(
                isTablet ? 48.0 : 24.0,
              ),
              child: SizedBox(
                width: isTablet ? 400 : double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFDB7A2B,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  onPressed: _nextPage,
                  child: Text(
                    'I Am Ready',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        );
      },
    );
  }

  Widget _buildFeatureItem(
    IconData icon,
    String title,
    String subtitle, {
    bool isTablet = false,
  }) {
    return Container(
      margin: isTablet
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      constraints: isTablet
          ? const BoxConstraints(minHeight: 180)
          : null,
      decoration: BoxDecoration(
        color: const Color(0xFF161A22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isTablet
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0x1ADB7A2B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFFDB7A2B),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: const Color(0xFF888481),
                    fontSize: 14,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0x1ADB7A2B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFFDB7A2B),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.nunito(
                          color: const Color(0xFF888481),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPage3() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "What's Your",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.hedvigLettersSerif(
                      color: Colors.white,
                      fontSize: isTablet ? 48 : 32,
                    ),
                  ),
                  Text(
                    'Cooking Level?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.hedvigLettersSerif(
                      color: const Color(0xFFDB7A2B),
                      fontSize: isTablet ? 48 : 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 100.0 : 32.0,
                    ),
                    child: Text(
                      'Help us customize your experience and set appropriate challenges',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        color: const Color(0xFF888481),
                        fontSize: isTablet ? 20 : 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  if (isTablet)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildLevelOption(
                              'Beginner',
                              'Just starting',
                              '🍳',
                              isTablet: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildLevelOption(
                              'Intermediate',
                              'Cooks often, knows recipes',
                              '👨‍🍳',
                              isTablet: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildLevelOption(
                              'Chef',
                              'Let me cook!',
                              '🔥',
                              isTablet: true,
                            ),
                          ),
                        ],
                      ),
                    )
                  else ...[
                    _buildLevelOption(
                      'Beginner',
                      'Just starting',
                      '🍳',
                    ),
                    _buildLevelOption(
                      'Intermediate',
                      'Cooks often, knows recipes',
                      '👨‍🍳',
                    ),
                    _buildLevelOption(
                      'Chef',
                      'Let me cook!',
                      '🔥',
                    ),
                  ],

                  const SizedBox(height: 24),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 120.0 : 24.0,
                    ),
                    child: TextField(
                      controller: _nameController,
                      onChanged: (val) =>
                          setState(() => _name = val),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF161A22),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.all(20),
                      ),
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: EdgeInsets.all(
                      isTablet ? 48.0 : 24.0,
                    ),
                    child: SizedBox(
                      width: isTablet
                          ? 400
                          : double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFDB7A2B,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _finishOnboarding,
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              'Let\'s Go!',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.rocket_launch,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLevelOption(
    String title,
    String subtitle,
    String emoji, {
    bool isTablet = false,
  }) {
    final isSelected = _level == title;
    return GestureDetector(
      onTap: () => setState(() => _level = title),
      child: Container(
        margin: isTablet
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
        padding: const EdgeInsets.all(16),
        constraints: isTablet
            ? const BoxConstraints(minHeight: 150)
            : null,
        decoration: BoxDecoration(
          color: const Color(0xFF161A22),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFFDB7A2B),
                  width: 1,
                )
              : null,
        ),
        child: isTablet
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    emoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: const Color(0xFF888481),
                      fontSize: 14,
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(height: 8),
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFFDB7A2B),
                    ),
                  ],
                ],
              )
            : Row(
                children: [
                  Text(
                    emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: GoogleFonts.nunito(
                            color: const Color(0xFF888481),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFFDB7A2B),
                    )
                  else
                    const Icon(
                      Icons.circle_outlined,
                      color: Colors.grey,
                    ),
                ],
              ),
      ),
    );
  }
}
