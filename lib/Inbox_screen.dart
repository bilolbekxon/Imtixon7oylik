import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Inbox ', style: TextStyle(color: Colors.grey)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {
              // Settings tugmasi bosilganda bajariladigan amallar
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 8),
          itemCount: 3,
          separatorBuilder: (_, __) =>
              const Divider(color: Color(0x1AFFFFFF), height: 1),
          itemBuilder: (context, index) {
            final items = [
              {
                'title': 'New Followers',
                'color': const Color(0xFF39D353),
                'icon': Icons.person_add,
              },
              {
                'title': 'Activities',
                'color': const Color(0xFFFF3B30),
                'icon': Icons.local_activity,
              },
              {
                'title': 'System Notifications',
                'color': const Color(0xFF2E86FF),
                'icon': Icons.volume_up,
              },
            ];

            final item = items[index];

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          item['color'] as Color,
                          (item['color'] as Color).withOpacity(0.85),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Color(0x66FFFFFF)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'New Followers',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      body: const Center(
        child: Text(
          'No new followers yet',
          style: TextStyle(color: Colors.white54),
        ),
      ),
    );
  }
}

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Activities',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      body: const Center(
        child: Text(
          'No activities right now',
          style: TextStyle(color: Colors.white54),
        ),
      ),
    );
  }
}

class SystemNotificationsScreen extends StatelessWidget {
  const SystemNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'System Notifications',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      body: const Center(
        child: Text(
          'System notifications will appear here',
          style: TextStyle(color: Colors.white54),
        ),
      ),
    );
  }
}
