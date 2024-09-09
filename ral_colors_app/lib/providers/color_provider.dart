import 'package:flutter/foundation.dart';
import '../models/color.dart';
import '../services/color_service.dart';

class ColorProvider with ChangeNotifier {
  List<Color> _colors = [];
  List<Color> _displayColors = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  String? _error; // Added error field

  List<Color> get colors => _colors;
  List<Color> get displayColors => _displayColors;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  String? get error => _error; // Added error getter

  final ColorService _colorService = ColorService();

  Future<void> fetchColors() async {
    try {
      _isLoading = true;
      _error = null; // Reset error before fetching
      notifyListeners();

      _colors = await _colorService.fetchColors();
      _displayColors = _colors;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error in ColorProvider.fetchColors: $e');
      _error = e.toString(); // Set error message
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateDisplayColors(List<Color> colors) {
    _displayColors = colors;
    _currentIndex = 0;
    notifyListeners();
  }

  void navigate(String direction) {
    if (direction == 'next') {
      _currentIndex =
          (_currentIndex + 4 >= _displayColors.length) ? 0 : _currentIndex + 4;
    } else {
      _currentIndex = (_currentIndex - 4 < 0)
          ? _displayColors.length - 4
          : _currentIndex - 4;
    }
    notifyListeners();
  }

  void search(String term) {
    if (term.isEmpty) {
      updateDisplayColors(_colors);
    } else {
      final results = _colors
          .where((color) =>
              color.ral.toLowerCase().contains(term.toLowerCase()) ||
              color.english.toLowerCase().contains(term.toLowerCase()))
          .toList();
      updateDisplayColors(results);
    }
  }
}
