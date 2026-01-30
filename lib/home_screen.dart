import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imixon_7oylik/Inbox_screen.dart';
import 'package:imixon_7oylik/play_screen.dart';
import 'package:imixon_7oylik/game_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<GameItem> _games = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  void _loadGames() {
    setState(() {
      _games = [
        GameItem(
          title: 'SILT',
          subtitle:
              'Dive into a surreal ocean abyss in an atmospheric puzzle-adventure!',
          imageUrl: 'https://picsum.photos/seed/silt/600/400',
          tag: 'Game of the Day',
          iconUrl: 'https://picsum.photos/seed/silt-icon/100/100',
        ),
        GameItem(
          title: 'Lone Necromancer: Idle RPG',
          subtitle: 'Become the strongest necromancer!',
          imageUrl: 'https://picsum.photos/seed/necro/600/300',
          rating: 4.5,
          category: 'Simulation',
          iconUrl: 'https://picsum.photos/seed/necro-icon/100/100',
        ),
        GameItem(
          title: 'Shadow Fight 4',
          subtitle: 'Epic fighting game with stunning graphics',
          imageUrl: 'https://picsum.photos/seed/shadow/600/300',
          rating: 4.8,
          category: 'Action',
          iconUrl: 'https://picsum.photos/seed/shadow-icon/100/100',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d0d0d),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTabBar(),
                    const SizedBox(height: 16),
                    _buildCategoryChips(),
                    const SizedBox(height: 20),
                    _buildGameOfTheDay(),
                    const SizedBox(height: 20),
                    _buildSecondFeaturedGame(),
                    const SizedBox(height: 20),
                    _buildThirdFeaturedGame(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Jujutsu Kaisen Phantom Parade',
              style: GoogleFonts.roboto(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InboxScreen()),
              );
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildTab('Discover', true),
          const SizedBox(width: 32),
          _buildTab('Top charts', false),
          const SizedBox(width: 32),
          _buildTab('Calendar', false),
          const SizedBox(width: 32),
          _buildTab('Gamelist', false),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: GoogleFonts.roboto(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 3,
          width: 60,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00d9a3) : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildChip('For you', true),
          const SizedBox(width: 12),
          _buildChip('Editors\' choice', false),
          const SizedBox(width: 12),
          _buildChip('Arcade', false),
          const SizedBox(width: 12),
          _buildChip('Strategy', false),
          const SizedBox(width: 12),
          _buildChip('Casual', false),
        ],
      ),
    );
  }

  Widget _buildChip(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: isSelected ? Colors.black : Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildGameOfTheDay() {
    if (_games.isEmpty) return const SizedBox();
    final game = _games[0];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailScreen(
              gameTitle: game.title,
              gameImage: game.imageUrl,
              gameDescription: game.subtitle,
              gameIcon: game.iconUrl,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                height: 420,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade900),
                child: Image.network(
                  game.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFF00d9a3)),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade800,
                      child: const Center(
                        child: Icon(Icons.image, size: 100, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 420,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Game of the Day',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      game.subtitle,
                      style: GoogleFonts.roboto(
                        color: Colors.grey.shade300,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondFeaturedGame() {
    if (_games.length <= 1) return const SizedBox();
    final game = _games[1];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailScreen(
              gameTitle: game.title,
              gameImage: game.imageUrl,
              gameDescription: game.subtitle,
              gameIcon: game.iconUrl,
              rating: game.rating,
              category: game.category,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey.shade800,
                  child: Image.network(
                    game.iconUrl ?? game.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.videogame_asset,
                        color: Colors.grey,
                        size: 25,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          game.rating.toStringAsFixed(1),
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          game.category,
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00d9a3), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Download',
                  style: GoogleFonts.roboto(
                    color: const Color(0xFF00d9a3),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThirdFeaturedGame() {
    if (_games.length <= 2) return const SizedBox();
    final game = _games[2];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailScreen(
              gameTitle: game.title,
              gameImage: game.imageUrl,
              gameDescription: game.subtitle,
              gameIcon: game.iconUrl,
              rating: game.rating,
              category: game.category,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade900),
                child: Image.network(
                  game.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFF00d9a3)),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade800,
                      child: const Center(
                        child: Icon(Icons.image, size: 60, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey.shade800,
                      child: Image.network(
                        game.iconUrl ?? game.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.videogame_asset,
                            color: Colors.grey,
                            size: 25,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game.title,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              game.rating.toStringAsFixed(1),
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              game.category,
                              style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF00d9a3),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Download',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF00d9a3),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
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
            children: [],
          ),
        ),
      ),
    );
  }
}

class GameItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double rating;
  final String category;
  final String? tag;
  final String? iconUrl;

  GameItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.rating = 0.0,
    this.category = '',
    this.tag,
    this.iconUrl,
  });
}
