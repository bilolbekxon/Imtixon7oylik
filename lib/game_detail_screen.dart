import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameDetailScreen extends StatefulWidget {
  final String gameTitle;
  final String gameImage;
  final String gameDescription;
  final String? gameIcon;
  final String developer;
  final double rating;
  final String category;
  final String size;

  const GameDetailScreen({
    super.key,
    required this.gameTitle,
    required this.gameImage,
    required this.gameDescription,
    this.gameIcon,
    this.developer = 'Snapbreak',
    this.rating = 4.5,
    this.category = 'Adventure',
    this.size = '1.06',
  });

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  bool _isWishlisted = false;
  bool _isPlayed = false;
  int _myRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d0d0d),
      body: CustomScrollView(
        slivers: [
          // Header with back button
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(0xFF0d0d0d),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz, color: Colors.white),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.gameImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF1a1a1a),
                        child: const Center(
                          child: Icon(Icons.image, size: 80, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGameInfo(),
                _buildDownloadButton(),
                _buildAlsoAvailable(),
                _buildActionButtons(),
                _buildRatingsSection(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Game icon
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 80,
              height: 80,
              color: const Color(0xFF1a1a1a),
              child: widget.gameIcon != null
                  ? Image.network(
                      widget.gameIcon!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.videogame_asset, size: 40, color: Colors.grey);
                      },
                    )
                  : const Icon(Icons.videogame_asset, size: 40, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          // Game details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.gameTitle,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.android, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    const Icon(Icons.apple, color: Colors.grey, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '• ${widget.category} • Puzzle',
                      style: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.grey, size: 8),
                    const SizedBox(width: 6),
                    Text(
                      widget.developer,
                      style: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF00d9a3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Download ${widget.size} GB',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlsoAvailable() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Also available',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.play_arrow, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            const Icon(Icons.apple, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: _isWishlisted ? Icons.bookmark : Icons.bookmark_border,
            label: 'Wishlist',
            onTap: () {
              setState(() {
                _isWishlisted = !_isWishlisted;
              });
            },
          ),
          _buildActionButton(
            icon: _isPlayed ? Icons.star : Icons.star_border,
            label: 'Played',
            onTap: () {
              setState(() {
                _isPlayed = !_isPlayed;
              });
            },
          ),
          _buildActionButton(
            icon: Icons.share_outlined,
            label: 'Share',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ratings & Reviews',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.keyboard_arrow_up, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "This game hasn't received enough ratings or reviews to display a summary.",
              style: GoogleFonts.roboto(
                color: Colors.grey,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                'My Rating',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              ...List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _myRating = index + 1;
                    });
                  },
                  child: Icon(
                    index < _myRating ? Icons.star : Icons.star_border,
                    color: index < _myRating ? Colors.amber : Colors.grey,
                    size: 32,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 24),
          // Players are saying
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('👥', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Players are saying...',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('❤️', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'The gameplay is simple yet captivating, combining survival with puzzles in an engaging way.',
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade300,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
