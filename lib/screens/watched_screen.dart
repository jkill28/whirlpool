import 'package:flutter/material.dart';
import '../models/thread.dart';
import 'thread_detail_screen.dart';

class WatchedScreen extends StatefulWidget {
  const WatchedScreen({super.key});

  @override
  State<WatchedScreen> createState() => _WatchedScreenState();
}

class _WatchedScreenState extends State<WatchedScreen> {
  List<Thread> _watchedThreads = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWatchedThreads();
  }

  Future<void> _loadWatchedThreads() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _watchedThreads = [
        Thread(
          id: '1',
          title: 'Sample Watched Thread 1',
          forum: 'General Discussion',
          author: 'User1',
          lastPostDate: DateTime.now().subtract(const Duration(hours: 2)),
          replyCount: 42,
          isWatched: true,
          hasNewPosts: true,
        ),
        Thread(
          id: '2',
          title: 'Sample Watched Thread 2',
          forum: 'Technology',
          author: 'User2',
          lastPostDate: DateTime.now().subtract(const Duration(days: 1)),
          replyCount: 15,
          isWatched: true,
          hasNewPosts: false,
        ),
        Thread(
          id: '3',
          title: 'Sample Watched Thread 3',
          forum: 'News',
          author: 'User3',
          lastPostDate: DateTime.now().subtract(const Duration(days: 3)),
          replyCount: 8,
          isWatched: true,
          hasNewPosts: false,
        ),
      ];
      _isLoading = false;
    });
  }

  Future<void> _refreshThreads() async {
    await _loadWatchedThreads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
      );
    }

    if (_watchedThreads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            const Text(
              'No watched threads',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Tap the star icon on any thread to watch it',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshThreads,
      color: Colors.orange,
      backgroundColor: const Color(0xFF1E1E1E),
      child: ListView.builder(
        itemCount: _watchedThreads.length,
        itemBuilder: (context, index) {
          final thread = _watchedThreads[index];
          return _buildWatchedThreadCard(thread);
        },
      ),
    );
  }

  Widget _buildWatchedThreadCard(Thread thread) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shadowColor: Colors.orange.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: thread.hasNewPosts ? Colors.orange : Colors.grey.shade700,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThreadDetailScreen(thread: thread),
            ),
          );
        },
        onLongPress: () {
          _showThreadActions(thread);
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (thread.hasNewPosts)
                    const Icon(Icons.fiber_new, color: Colors.orange, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      thread.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: thread.hasNewPosts
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: Colors.orange,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.forum, color: Colors.orange.shade400, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    thread.forum,
                    style: TextStyle(
                      color: Colors.orange.shade400,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.person, color: Colors.grey.shade400, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    thread.author,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey.shade500, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(thread.lastPostDate),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.comment, color: Colors.grey.shade500, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${thread.replyCount} replies',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThreadActions(Thread thread) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2D2D2D),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.star_border, color: Colors.orange),
              title: const Text(
                'Unwatch Thread',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _watchedThreads.remove(thread);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thread unwatched!'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mark_as_unread, color: Colors.orange),
              title: const Text(
                'Mark as Read',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  thread.hasNewPosts = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thread marked as read'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.orange),
              title: const Text(
                'Share Thread',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Share functionality coming soon!'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
