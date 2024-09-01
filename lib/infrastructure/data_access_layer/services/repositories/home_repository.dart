import 'package:bloc_task/infrastructure/constants/api_constants.dart';
import 'package:bloc_task/infrastructure/models/response/git_data_response_model.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class HomeRepository {
  Future<List<GitDataResponseModel>> fetchGitRepoData(
      {required String currentDate}) async {

    final apiUrl =
        '${ApiConstants.baseUrl}${ApiConstants.searchRepositories}$currentDate${ApiConstants.sortByStars}';

     // final apiUrl = 'https://api.github.com/search/repositories?q=created:%3E2022-04-29&sort=stars&order=desc';
    return await compute(_fetchAndParseRepositories, {
      'apiUrl': apiUrl,
    });
  }

  Future<List<GitDataResponseModel>> _fetchAndParseRepositories(
      Map<String, dynamic> params) async {
    final String apiUrl = params['apiUrl'];

    try {
      final response = await https.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse =
            json.decode(response.body)['items'] as List<dynamic>;
        return jsonResponse
            .map((data) =>
                GitDataResponseModel.fromJson(data as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Failed to load repositories with status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching repositories: $error');
    }
  }
}


