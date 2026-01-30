import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imixon_7oylik/home_screen.dart';
import 'package:imixon_7oylik/play_screen.dart';
import 'package:imixon_7oylik/Inbox_screen.dart';
import 'package:imixon_7oylik/tavern_screen.dart';
import 'package:imixon_7oylik/profile_screen.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;
  
  const MainLayout({super.key, this.initialIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const PlayScreen(),
    const Center(child: Text('Explore', style: TextStyle(color: Colors.white))), // Explore screen
    const TavernScreen(), // Tavern screen
    const ProfileScreen(), // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d0d0d),
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0a0a0a),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.sports_esports_outlined, 'Games', 0),
              _buildNavItem(Icons.play_circle_outline, 'Play', 1),
              _buildCenterNavItem(),
              _buildNavItem(Icons.store_outlined, 'Tavern', 3),
              _buildNavItem(null, 'Me', 4, isProfile: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData? icon,
    String label,
    int index, {
    bool isProfile = false,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isProfile)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'S',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey.shade600,
                size: 26,
              ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.roboto(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterNavItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = 2;
        });
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF00d9a3),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00d9a3).withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.explore_outlined,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
