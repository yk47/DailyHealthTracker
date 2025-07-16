import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity_log.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<ActivityLog>> getActivityLogs({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts?_page=$page&_limit=$limit'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ActivityLog.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load activity logs');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<ActivityLog> getActivityLog(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ActivityLog.fromJson(data);
      } else {
        throw Exception('Failed to load activity log');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
