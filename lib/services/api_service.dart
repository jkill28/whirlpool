import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/thread.dart';
import '../models/whim.dart';
import '../models/thread.dart' as thread_model;

class ApiService {
  static const String _baseUrl = 'https://whirlpool.net.au/api';
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  // Threads
  Future<List<Thread>> getRecentThreads() async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/recent-threads'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Thread.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recent threads: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load recent threads: $e');
    }
  }

  Future<List<Thread>> getForumThreads(String forumId) async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/forums/$forumId/threads'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Thread.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load forum threads: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load forum threads: $e');
    }
  }

  Future<Thread> getThread(String threadId) async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/threads/$threadId'));
      if (response.statusCode == 200) {
        return Thread.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load thread: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load thread: $e');
    }
  }

  Future<List<Post>> getThreadPosts(String threadId) async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/threads/$threadId/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load thread posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load thread posts: $e');
    }
  }

  // Forums
  Future<List<Forum>> getForums() async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/forums'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Forum.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load forums: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load forums: $e');
    }
  }

  // Whims
  Future<List<Whim>> getRecentWhims() async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/whims/recent'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Whim.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recent whims: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load recent whims: $e');
    }
  }

  // Watch functionality
  Future<void> watchThread(String threadId) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/threads/$threadId/watch'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to watch thread: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to watch thread: $e');
    }
  }

  Future<void> unwatchThread(String threadId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$_baseUrl/threads/$threadId/watch'),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to unwatch thread: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to unwatch thread: $e');
    }
  }

  // Mark as read
  Future<void> markThreadRead(String threadId) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/threads/$threadId/mark-read'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to mark thread as read: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to mark thread as read: $e');
    }
  }

  Future<void> markWhimRead(String whimId) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/whims/$whimId/mark-read'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to mark whim as read: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to mark whim as read: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
