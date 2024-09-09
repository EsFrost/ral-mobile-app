import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/color.dart';

class ColorService {
  static const String _apiUrl =
      'https://sigmafi-tech.website/ral-classic/api/colors';
  static const String _cacheKey = 'colors';

  Future<List<Color>> fetchColors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedColors = prefs.getString(_cacheKey);

      if (cachedColors != null) {
        final List<dynamic> decodedColors = json.decode(cachedColors);
        return decodedColors.map((color) => Color.fromJson(color)).toList();
      }

      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> decodedColors = json.decode(response.body);
        final colors =
            decodedColors.map((color) => Color.fromJson(color)).toList();

        await prefs.setString(_cacheKey, response.body);
        return colors;
      } else {
        throw Exception(
            'Failed to load colors. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchColors: $e');
      rethrow; // Re-throw the error so it can be handled by the caller
    }
  }
}
