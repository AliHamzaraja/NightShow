import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nightshow/utils/appConstants.dart';

import '../Models/movieImagesModel.dart';
import '../utils/appUrls.dart';

class MovieImageProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  MovieImagesModel movieImagesModel = MovieImagesModel();
  Future moviesImages(int movieId) async {
    _currentIndex = 0;
    setLoading(true);
    try {
      http.Response response = await http.get(
        Uri.parse(
            "${AppStringsUtil.baseurl}/$movieId${AppStringsUtil.moviesImages}${AppStringsUtil.params}"),
        headers: {'Authorization': 'Bearer ${AppConstant.accessToken}'},
      );
      print(response.request);
      if (response.statusCode == 200) {
        setLoading(false);
        final Map<String, dynamic> data = json.decode(response.body);
        movieImagesModel = MovieImagesModel.fromJson(data);
        print('Data: $data');
      } else {
        setLoading(false);
        throw Exception('Failed to fetch. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setLoading(false);
      print('Error: $e');
      throw Exception('Failed to fetch: $e');
    }
  }
}
