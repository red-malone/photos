import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photos/models/photos.dart';
import 'package:http/http.dart' as http;

class PhotoProvider with ChangeNotifier {
  List<Photos> _photos = [];
  List<int> _favoritePhotos = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Photos> get photos => _photos;
  List<int> get favoritePhotos => _favoritePhotos;

  Future<void> fetchPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      _photos = data.map((item) => Photos.fromJson(item)).take(50).toList();
      await _loadFavourites();
      notifyListeners();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<void> _loadFavourites() async {
    final snapshot = await _firestore.collection('favourites').get();
    _favoritePhotos = snapshot.docs.map((doc) => int.parse(doc.id)).toList();
    notifyListeners();
  }

  void togglefav(int id) async {
    if (_favoritePhotos.contains(id)) {
      _favoritePhotos.remove(id);
      await _firestore.collection('favourites').doc(id.toString()).delete();
    } else {
      _favoritePhotos.add(id);
      await _firestore.collection('favourites').doc(id.toString()).set({});
    }
    notifyListeners();
  }

  bool isFavorite(int id) {
    return _favoritePhotos.contains(id);
  }
}
