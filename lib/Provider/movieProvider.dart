import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nightshow/utils/appConstants.dart';

import '../Models/playMovieModel.dart';
import '../Models/upcomingmovie_model.dart';
import '../utils/appUrls.dart';

class MovieProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  UpComingMovies upComingMovies = UpComingMovies();
  PlayVideoModel playVideoModel = PlayVideoModel();
  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<UpComingMovies> movies() async {
    try {
      http.Response response = await http.get(
        Uri.parse(AppStringsUtil.baseurl +
            AppStringsUtil.upCommingMovies +
            AppStringsUtil.params),
        headers: {'Authorization': 'Bearer ${AppConstant.accessToken}'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Data: $data');
        upComingMovies = UpComingMovies.fromJson(jsonDecode(response.body));
        return UpComingMovies.fromJson(data);
      } else {
        throw Exception('Failed to fetch. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch: $e');
    }
  }

  Future<PlayVideoModel> playmovies(movieId) async {
    try {
      http.Response response = await http.get(
        Uri.parse("${AppStringsUtil.baseurl}/$movieId${AppStringsUtil.params}"),
        headers: {'Authorization': 'Bearer ${AppConstant.accessToken}'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Data: $data');
        playVideoModel = PlayVideoModel.fromJson(jsonDecode(response.body));
        return PlayVideoModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch: $e');
    }
  }
}
