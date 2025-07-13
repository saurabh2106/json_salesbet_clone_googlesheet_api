import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CombinedHomeScreen(),
    );
  }
}

class CombinedHomeScreen extends StatefulWidget {
  const CombinedHomeScreen({super.key});

  @override
  State<CombinedHomeScreen> createState() => _CombinedHomeScreenState();
}

class _CombinedHomeScreenState extends State<CombinedHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _selectedTabIndex = 0;
  bool isLoggedIn = false; // mock login state

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.sports_cricket, 'text': 'Business War...'},
    {'icon': Icons.sports_basketball, 'text': 'Lead Hunters...'},
    {'icon': Icons.sports_baseball, 'text': 'The Contact...'},
    {'icon': Icons.sports_golf, 'text': 'The In-Person...'},
    {'icon': Icons.sports_golf, 'text': 'The In-Person...'},
    {'icon': Icons.sports_golf, 'text': 'The In-Person...'},
  ];

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              children: [
                // Category TabBar
                SizedBox(
                  height: 90,
                  child: Container(
                    color: AppColors.appBarBackground,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              itemCount: _categories.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                return ImageActionButton(
                                  icon: Icon(
                                    _categories[index]['icon'],
                                    color: _selectedTabIndex == index
                                        ? AppColors.appBarSelectedIcon
                                        : AppColors.border,
                                  ),
                                  iconText: _categories[index]['text'],
                                  isSelected: _selectedTabIndex == index,
                                  onTap: () =>
                                      setState(() => _selectedTabIndex = index),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.primary, Colors.transparent],
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: AppColors.background,
                              ),
                              onPressed: _scrollLeft,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.centerRight,
                            height: 200,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, AppColors.primary],
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: AppColors.background,
                              ),
                              onPressed: _scrollRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Container(
                      color: Colors.grey.shade200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 5),
                            alignment: Alignment.centerLeft,
                            color: const Color.fromARGB(255, 4, 16, 83),
                            width: double.infinity,
                            height: 80,
                            child: ImageActionButton(
                              icon: const Icon(
                                Icons.public,
                                color: AppColors.border,
                              ),
                              iconText: 'recruiting league',
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                'images/banner.png',
                                height: 80,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.list_alt_rounded,
                                  size: 120,
                                  color: AppColors.subText,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "No game available in this category",
                                  style: TextStyle(color: AppColors.subText),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.background,
                              child: const CustomAboutUs(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.background,
                              ),
                              padding: const EdgeInsets.all(16),
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Copyright © 2025  ',
                                  style: TextStyle(color: Colors.black87),
                                  children: [
                                    TextSpan(
                                      text: 'SalesBets',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    TextSpan(text: ' All right reserved'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              isLoggedIn: isLoggedIn,
              selectedIndex: 1,
              onTap: (index) {
                if (index == 3 && !isLoggedIn) {
                  showDialog(
                    context: context,
                    builder: (context) => const LoginScreen(),
                  );
                } else {
                  setState(() {
                    isLoggedIn = false;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.showLive = true,
    this.showUpcoming = true,
  });
  final bool? showLive;
  final bool? showUpcoming;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBackground,
      flexibleSpace: SafeArea(
        child: Row(
          children: [
            Image.asset('images/lab_logo.png', height: 100, width: 120),
            const Spacer(),
            if (showLive!)
              IntrinsicWidth(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size(0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.card,
                  ),
                  child: const Text("Live", style: TextStyle(fontSize: 16)),
                ),
              ),
            const SizedBox(width: 8),
            if (showUpcoming!)
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.card,
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                  ),
                  side: BorderSide(color: AppColors.background),
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  "Upcoming",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ImageActionButton extends StatelessWidget {
  final Icon icon;
  final String iconText;
  final bool isSelected;
  final VoidCallback? onTap;

  const ImageActionButton({
    super.key,
    required this.icon,
    required this.iconText,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 4),
          Text(
            iconText,
            style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? AppColors.appBarSelectedIcon
                  : AppColors.border,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final bool isLoggedIn;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Bottom Nav Bar
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.appBarBackground,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.sports_esports, 'Bet Now', 0),
                _buildNavItem(Icons.history, 'My Bets', 1),
                const SizedBox(width: 25),
                _buildNavItem(
                  Icons.shopping_bag,
                  'Bet Slip',
                  2,
                  showBadge: true,
                  numberOnBadge: '0',
                ),
                isLoggedIn
                    ? _buildNavItem(Icons.logout_outlined, 'Log out', 3)
                    : _buildNavItem(Icons.person, 'Login', 3),
              ],
            ),
          ),
          Positioned(
            top: 2,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index, {
    bool showBadge = false,
    String numberOnBadge = '0',
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.grey[400]),
              if (showBadge)
                Positioned(
                  right: -8,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF7A73FF),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      numberOnBadge,
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
