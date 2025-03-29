import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photos/models/photos.dart';
import 'package:http/http.dart' as http;

class PhotoProvider with ChangeNotifier {
  List<Photos> _photos = [];
  List<int> _favoritePhotos = [];
  List<Photos> get photos => _photos;
  List<int> get favoritePhotos => _favoritePhotos;

  Future<void> fetchPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      _photos = data.map((item) => Photos.fromJson(item)).take(50).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  void togglefav(int id) {
    if (_favoritePhotos.contains(id)) {
      _favoritePhotos.remove(id);
    } else {
      _favoritePhotos.add(id);
    }
    notifyListeners();
  }

  bool isFavorite(int id) {
    return _favoritePhotos.contains(id);
  }
}
