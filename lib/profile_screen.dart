import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedTab = 'Installed';
  bool _playTimeEnabled = false;

  final List<GameProfile> _games = [
    GameProfile(
      name: 'PUBG Mobile',
      imageUrl: 'https://picsum.photos/seed/pubg1/200/200',
      lastPlayed: 'Viewed 01/20/26',
      badge: 'KR',
      hasUpdate: false,
    ),
    GameProfile(
      name: 'Mobile Legends: Bang Bang',
      imageUrl: 'https://picsum.photos/seed/mlbb/200/200',
      lastPlayed: 'No records',
      badge: 'Global',
      hasUpdate: true,
    ),
    GameProfile(
      name: 'PUBG MOBILE',
      imageUrl: 'https://picsum.photos/seed/pubg2/200/200',
      lastPlayed: 'No records',
      badge: 'Global',
      hasUpdate: false,
    ),
    GameProfile(
      name: 'Memory game',
      imageUrl: 'https://picsum.photos/seed/memory/200/200',
      lastPlayed: 'No records',
      badge: null,
      hasUpdate: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildTabBar(),
            _buildPlayTimeSection(),
            Expanded(child: _buildGamesList()),
          ],
        ),
      ),
      floatingActionButton: _buildDownloadButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF00a884),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'S',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'skukur respekt',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'ID.646979924',
                  style: GoogleFonts.roboto(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Chevron icon
          const Icon(Icons.chevron_right, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ['Installed', 'Updates', 'Pre-registered', 'Wishlist'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = tabs[index] == _selectedTab;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = tabs[index];
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  tabs[index],
                  style: GoogleFonts.roboto(
                    color: isSelected ? Colors.black : const Color(0xFF999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayTimeSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          // Play Time label
          Text(
            'Play Time',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 12),
          // Toggle button
          GestureDetector(
            onTap: () {
              setState(() {
                _playTimeEnabled = !_playTimeEnabled;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF2d2d2d),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _playTimeEnabled
                          ? const Color(0xFF00d9a3)
                          : const Color(0xFF666666),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Off',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Default label
          Text(
            'Default',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.check_circle, color: Color(0xFF00d9a3), size: 20),
        ],
      ),
    );
  }

  Widget _buildGamesList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      itemCount: _games.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildGameItem(_games[index]);
      },
    );
  }

  Widget _buildGameItem(GameProfile game) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Game icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF2d2d2d),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                game.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.videogame_asset,
                      color: Color(0xFF666666),
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Game info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        game.name,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (game.badge != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3d3d3d),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          game.badge!,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  game.lastPlayed,
                  style: GoogleFonts.roboto(
                    color: const Color(0xFF999999),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (game.hasUpdate) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.refresh,
                        color: Color(0xFF00d9a3),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Update',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF00d9a3),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          // More menu and Play button in column
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // More menu button
              IconButton(
                onPressed: () {
                  // Show options menu
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 24,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 4),
              // Play button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF00d9a3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  'Play',
                  style: GoogleFonts.roboto(
                    color: const Color(0xFF00d9a3),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton() {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: Color(0xFF2d2d2d),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.file_download_outlined,
        color: Color(0xFF00d9a3),
        size: 28,
      ),
    );
  }
}

class GameProfile {
  final String name;
  final String imageUrl;
  final String lastPlayed;
  final String? badge;
  final bool hasUpdate;

  GameProfile({
    required this.name,
    required this.imageUrl,
    required this.lastPlayed,
    this.badge,
    required this.hasUpdate,
  });
}
