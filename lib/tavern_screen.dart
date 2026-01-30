import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TavernScreen extends StatefulWidget {
  const TavernScreen({super.key});

  @override
  State<TavernScreen> createState() => _TavernScreenState();
}

class _TavernScreenState extends State<TavernScreen> {
  String _selectedTab = 'Following';
  List<FollowingGame> _followingGames = [];
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _followingGames = [
        FollowingGame(
          name: 'Wutherin...',
          imageUrl: 'https://picsum.photos/seed/wuthering/200/200',
          hasNotification: true,
        ),
        FollowingGame(
          name: 'Zenless Z...',
          imageUrl: 'https://picsum.photos/seed/zenless/200/200',
          hasNotification: true,
        ),
        FollowingGame(
          name: 'PUBG M...',
          imageUrl: 'https://picsum.photos/seed/pubg1/200/200',
          hasNotification: true,
        ),
        FollowingGame(
          name: 'PUBG M...',
          imageUrl: 'https://picsum.photos/seed/pubg2/200/200',
          hasNotification: true,
        ),
        FollowingGame(
          name: 'BGMI: On...',
          imageUrl: 'https://picsum.photos/seed/bgmi/200/200',
          hasNotification: true,
        ),
      ];

      _posts = [
        Post(
          gameIcon: 'https://picsum.photos/seed/pubg-post/200/200',
          gameName: 'PUBG MOBILE: 绝地求生M',
          category: 'Chotki',
          author: 'skukur respekt',
          date: '11/11/24',
          likes: 0,
          backgroundImage: 'https://picsum.photos/seed/pubg-bg/1200/600',
          hasGameIconOverlay: true,
        ),
        Post(
          gameIcon: 'https://picsum.photos/seed/cod/200/200',
          gameName: 'Call of Duty®: Warzone™ Mobile',
          category: 'Claws of Power – how I\'m building progression in my cat RTS',
          author: 'Sprout',
          date: '2d',
          likes: 24,
          backgroundImage: 'https://picsum.photos/seed/cod-bg/1200/600',
          isVerified: true,
          hasGameIconOverlay: false,
          description: 'Because you\'re following Wuthering Waves — To La...',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFollowingGames(),
                  const SizedBox(height: 16),
                  _buildPosts(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTopTab('Following', true),
          const SizedBox(width: 32),
          _buildTopTab('For You', false),
          const Spacer(),
          Icon(Icons.tune, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildTopTab(String text, bool isSelected) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontSize: 18,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        if (isSelected)
          Container(
            height: 3,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF00d9a3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }

  Widget _buildFollowingGames() {
    return Container(
      height: 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _followingGames.length,
        itemBuilder: (context, index) {
          return _buildFollowingGameItem(_followingGames[index]);
        },
      ),
    );
  }

  Widget _buildFollowingGameItem(FollowingGame game) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade800,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    game.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.videogame_asset, color: Colors.grey);
                    },
                  ),
                ),
              ),
              if (game.hasNotification)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00d9a3),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF0d0d0d), width: 2.5),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            game.name,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPosts() {
    return Column(
      children: _posts.map((post) => _buildPostItem(post)).toList(),
    );
  }

  Widget _buildPostItem(Post post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post image with overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey.shade800,
                  child: Image.network(
                    post.backgroundImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(Icons.image, color: Colors.grey, size: 60),
                      );
                    },
                  ),
                ),
              ),
              // Game icon overlay on image (for first post) - 30px
              if (post.hasGameIconOverlay)
                Positioned(
                  left: 14,
                  bottom: 14,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade800,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            post.gameIcon,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.videogame_asset,
                                  color: Colors.grey, size: 20);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        post.gameName,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // Post content - padding faqat top
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category/Title
                Text(
                  post.category,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 10),

                // Author info and actions
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00d9a3),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          post.author[0].toUpperCase(),
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post.author,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (post.isVerified) ...[
                      const SizedBox(width: 4),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child:
                            Icon(Icons.check, color: Colors.white, size: 10),
                      ),
                    ],
                    const SizedBox(width: 6),
                    Text(
                      '· ${post.date}',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.thumb_up_outlined,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      post.likes.toString(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.more_horiz, color: Colors.white, size: 18),
                  ],
                ),
              ],
            ),
          ),

          // Description (for second post)
          if (post.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Text(
                post.description!,
                style: GoogleFonts.inter(
                  color: Colors.grey.shade400,
                  fontSize: 13.5,
                  height: 1.4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FollowingGame {
  final String name;
  final String imageUrl;
  final bool hasNotification;

  FollowingGame({
    required this.name,
    required this.imageUrl,
    this.hasNotification = false,
  });
}

class Post {
  final String gameIcon;
  final String gameName;
  final String category;
  final String author;
  final String date;
  final int likes;
  final String backgroundImage;
  final bool isVerified;
  final bool hasGameIconOverlay;
  final String? description;

  Post({
    required this.gameIcon,
    required this.gameName,
    required this.category,
    required this.author,
    required this.date,
    required this.likes,
    required this.backgroundImage,
    this.isVerified = false,
    this.hasGameIconOverlay = false,
    this.description,
  });
}
