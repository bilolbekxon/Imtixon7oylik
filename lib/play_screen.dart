import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  String _selectedTab = 'Games';
  List<GameCard> _games = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  void _loadGames() {
    setState(() {
      _games = [
        GameCard(
          title: ' World Lucky King',
          subtitle: 'RPG · Idle',
          rating: 6.9,
          imageUrl: 'https://picsum.photos/seed/fantasy/600/400',
        ),
        GameCard(
          title: 'Backpacker',
          subtitle: 'Roguelike · Merge',
          rating: 8.7,
          imageUrl: 'https://picsum.photos/seed/backpacker/600/400',
        ),
        GameCard(
          title: 'BagMerge',
          subtitle: 'Merge · Roguelike',
          rating: 8.3,
          imageUrl: 'https://picsum.photos/seed/bagmerge/600/400',
        ),
        GameCard(
          title: 'Relax Even in the Apocalypse',
          subtitle: 'Casual',
          rating: 5.8,
          imageUrl: 'https://picsum.photos/seed/relax/600/400',
        ),
        GameCard(
          title: 'MonsterMonster',
          subtitle: 'RPG · Idle',
          rating: 6.8,
          imageUrl: 'https://picsum.photos/seed/monster/600/400',
        ),
        GameCard(
          title: 'Hammer.io',
          subtitle: 'Action · Multiplayer',
          rating: 8.5,
          imageUrl: 'https://picsum.photos/seed/hammer/600/400',
        ),
        GameCard(
          title: 'LuckyTD',
          subtitle: 'Tower Defense · Roguelike',
          rating: 6.9,
          imageUrl: 'https://picsum.photos/seed/luckytd/600/400',
        ),
        GameCard(
          title: 'Doomsday: Brave the Mons...',
          subtitle: 'Card · Anime',
          rating: 7.2,
          imageUrl: 'https://picsum.photos/seed/doomsday/600/400',
        ),
        GameCard(
          title: 'Fitness Sort',
          subtitle: 'Puzzle · Casual',
          rating: 7.5,
          imageUrl: 'https://picsum.photos/seed/fitness/600/400',
        ),
        GameCard(
          title: 'Quicksand Block',
          subtitle: 'Puzzle · Arcade',
          rating: 6.8,
          imageUrl: 'https://picsum.photos/seed/quicksand/600/400',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.15,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
              ),
              itemCount: _games.length,
              itemBuilder: (context, index) {
                return _buildGameCard(_games[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTopTab('Games', true),
          const SizedBox(width: 40),
          _buildTopTab('Recently', false),
        ],
      ),
    );
  }

  Widget _buildTopTab(String text, bool isSelected) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.roboto(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontSize: 17,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
        if (isSelected)
          Container(
            height: 3,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF00d9a3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }

  Widget _buildGameCard(GameCard game) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Game image
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey.shade800,
                    child: Image.network(
                      game.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF00d9a3),
                            strokeWidth: 2,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.videogame_asset, color: Colors.grey);
                      },
                    ),
                  ),
                  // Rating badge - o'ng pastda
                  Positioned(
                    bottom: 1,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00d9a3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 12),
                          const SizedBox(width: 3),
                          Text(
                            game.rating.toStringAsFixed(1),
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Game info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  game.title,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  game.subtitle,
                  style: GoogleFonts.roboto(
                    color: Colors.grey.shade500,
                    fontSize: 10.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(height: 0),
        ],
      ),
    );
  }
}

class GameCard {
  final String title;
  final String subtitle;
  final double rating;
  final String imageUrl;

  GameCard({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.imageUrl,
  });
}
