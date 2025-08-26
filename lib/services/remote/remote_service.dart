// services/portfolio_service.dart
import 'package:dio/dio.dart';
import 'package:portfolio_site/models/about_model.dart';
import 'package:portfolio_site/models/article_model.dart';
import 'package:portfolio_site/models/project_model.dart';
import 'dart:convert';

const GITHUB_TOKEN =
    "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";
const GITHUB_OWNER = "goziedotcom";
const GITHUB_REPO = "portfolio_data";

class RemoteService {
  final Dio _dio = Dio();

  RemoteService() {
    // GitHub API headers
    _dio.options.headers['Authorization'] = 'Bearer $GITHUB_TOKEN';
    _dio.options.headers['Accept'] = 'application/vnd.github+json';
    _dio.options.headers['X-GitHub-Api-Version'] = '2022-11-28';
  }

  Future<List<Project>> getProjects() async {
    final projects = await fetchData<Project>(
      'projects.json',
      (json) => Project.fromJson(json),
    );
    return projects.latestProjects;
  }

  Future<List<Article>> getArticles() async {
    final articles = await fetchData<Article>(
      'articles.json',
      (json) => Article.fromJson(json),
    );
    return articles.latestArticles;
  }

  Future<List<Achievement>> getAchievements() async {
    final achievements = await fetchData<Achievement>(
      'achievements.json',
      (json) => Achievement.fromJson(json),
    );
    return achievements.sortByYear();
  }

  Future<List<T>> fetchData<T>(String path, T Function(Map<String, dynamic>) fromJson) async {
    final response = await _dio
        .get('https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/contents/data/$path');

    // Decode base64 content from GitHub API
    final content = base64.decode(response.data['content'].replaceAll('\n', ''));
    final jsonData = json.decode(utf8.decode(content));

    return (jsonData as List).map((json) => fromJson(json)).toList();
  }
}
