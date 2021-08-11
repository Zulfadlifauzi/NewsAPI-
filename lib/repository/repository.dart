import 'package:dio/dio.dart';
import 'package:firstapp/model/article_response.dart';
import 'package:firstapp/model/source_response.dart';
import 'dart:async';

class NewsRepository {
  static String mainUrl = 'https://newsapi.org/v2/';
  final String apiKey = 'b9402defd3c44083bcb3927f205aa64e';
  final Dio _dio = Dio();

  var getSourcesUrl = '$mainUrl/sources';
  var getTopHeadlinesUrl = '$mainUrl/top-headlines';
  var everythingUrl = '$mainUrl/everything';

  Future<SourceResponse> getSources() async {
    var params = {'apiKey': apiKey, 'language': 'en', 'country': 'en'};
    try {
      Response response =
          await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace:$stacktrace');
      return SourceResponse.withError('$error');
    }
  }

  Future<ArticleResponse> getTopHeadlines() async {
    var params = {
      'apiKey': apiKey,
      'country': 'en',
    };
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error,stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError('$error');
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var params = {'apiKey': apiKey, 'q': 'apple', 'sortBy': 'popularity'};
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    // ignore: unused_catch_stack
    } catch (error,stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError('$error');
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {'apiKey': apiKey, 'sources': sourceId};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error,stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError('$error');
    }
  }

  Future<ArticleResponse> search(String searchValue) async {
    var params = {'apiKey': apiKey, 'q': searchValue};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error,stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError('$error');
    }
  }
}
