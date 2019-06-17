import 'dart:async';

import 'package:spike_scoped_model_flutter/models/search_result_dto.dart';

import 'http/github_http_client.dart';

class GithubRepository {
  Future<SearchResultDto> fetch(String freeword) {
    GithubHttpClient client = GithubHttpClient();
    return client.fetch(freeword);
  }
}
