import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/pages/cuisine/screens/cuisine_screen.dart';
import 'package:only_shef/pages/home/screen/filter_bottom_sheet.dart';
import 'package:only_shef/pages/home/widgets/cuisine_custom_card.dart';
import 'package:only_shef/widgets/custom_menu_button.dart';
import 'package:only_shef/widgets/chef_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../common/colors/colors.dart';
import '../../../provider/user_provider.dart';
import '../../../main.dart';

class ChefHomeScreen extends StatefulWidget {
  const ChefHomeScreen({super.key});

  @override
  State<ChefHomeScreen> createState() => _ChefHomeScreenState();
}

class _ChefHomeScreenState extends State<ChefHomeScreen>
    with WidgetsBindingObserver, RouteAware {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _cuisines = [
    {
      'name': 'Pakistani',
      'color': Color(0xFF1B4149),
      'image': 'assets/turkey.png',
      'cuisineImage': 'assets/pakistani1.png',
    },
    {
      'name': 'Chineese',
      'color': Color(0xFF81C0FF),
      'image': 'assets/chinese_logo.png',
      'cuisineImage': 'assets/chinese1.png',
    },
    {
      'name': 'Mexican',
      'color': Color(0xFFCA4943),
      'image': 'assets/mexican_logo.png',
      'cuisineImage': 'assets/mexican1.png',
    },
    {
      'name': 'Fast Food',
      'color': Color(0xFF8186D9),
      'image': 'assets/fastfood_logo.png',
      'cuisineImage': 'assets/fastfood1.png',
    },
    {
      'name': 'Desserts',
      'color': Color(0xFF77B255),
      'image': 'assets/deserts_logo.png',
      'cuisineImage': 'assets/desert1.png',
    },
    {
      'name': 'Others',
      'color': Color(0xFFB769D3),
      'image': 'assets/others_logo.png',
      'cuisineImage': 'assets/desert1.png',
    },
  ];

  List<Map<String, dynamic>> _filteredCuisines = [];

  @override
  void initState() {
    super.initState();
    _filteredCuisines = _cuisines;
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(_onFocusChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.addListener(() {
        if (!FocusManager.instance.primaryFocus!.hasFocus) {
          setState(() {
            _isSearchFocused = false;
          });
          FocusScope.of(context).unfocus();
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCuisines = _cuisines;
      } else {
        _filteredCuisines = _cuisines.where((cuisine) {
          return cuisine['name'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    _searchController.dispose();
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isSearchFocused = false;
    });
  }

  void _handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0: // Home
        // Already on home screen
        break;
      case 1: // Appointments
        Navigator.pushNamed(context, '/chef-appointments');
        break;
      case 2: // Messages
        Navigator.pushNamed(context, '/messages');
        break;
      case 3: // Profile
        Navigator.pushNamed(context, '/profile-settings');
        break;
    }
  }

  void _switchToUserProfile() {
    // Navigate to user home screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return WillPopScope(
      onWillPop: () async {
        if (_searchFocusNode.hasFocus) {
          FocusScope.of(context).unfocus();
          await Future.delayed(Duration(milliseconds: 50));
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xffFDF7F2),
        key: scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                color: Color(0xFF1E451B),
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                ),
              ),
              Container(
                color: Color(0xFF1E451B),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        user.profileImage,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user.name,
                          style: GoogleFonts.poppins(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          color: Color(0xFFFFFFFF),
                        ),
                      ],
                    ),
                    Text(
                      user.email,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outline),
                title: Text(
                  'Add New Cuisine',
                  style: GoogleFonts.poppins(),
                ),
                contentPadding: EdgeInsets.only(top: 40, left: 20),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to add cuisine screen
                },
              ),
              ListTile(
                leading: Icon(Icons.chat_outlined),
                title: Text(
                  'Messages',
                  style: GoogleFonts.poppins(),
                ),
                contentPadding: EdgeInsets.only(top: 10, left: 20),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to chat screen
                },
              ),
              ListTile(
                leading: Icon(Icons.verified_outlined),
                title: Text(
                  'Verification Status',
                  style: GoogleFonts.poppins(),
                ),
                contentPadding: EdgeInsets.only(top: 10, left: 20),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings_outlined),
                title: Text(
                  'Settings',
                  style: GoogleFonts.poppins(),
                ),
                contentPadding: EdgeInsets.only(top: 10, left: 20),
                onTap: () {},
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E451B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _switchToUserProfile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.swap_horiz, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Switch to User Profile',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF1E451B),
          title: Text(
            'Chef Dashboard',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {
                // Handle notifications
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Search cuisines...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // My Cuisines Section
                Text(
                  'My Cuisines',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 16),
                // Add New Cuisine Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to add cuisine screen
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add New Cuisine'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E451B),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Cuisines Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _filteredCuisines.length,
                  itemBuilder: (context, index) {
                    final cuisine = _filteredCuisines[index];
                    return CustomCuisineCard(
                      backColor: cuisine['color'],
                      imageLink: cuisine['image'],
                      cuisineName: cuisine['name'],
                      onTap: () {
                        // Navigate to cuisine details screen
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ChefNavigationBar(
          currentIndex: _currentIndex,
          onTap: _handleNavigation,
        ),
      ),
    );
  }
}
