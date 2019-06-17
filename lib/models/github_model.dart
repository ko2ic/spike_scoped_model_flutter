import 'package:scoped_model/scoped_model.dart';
import 'package:spike_scoped_model_flutter/repositories/github_repository_impl.dart';

import 'loading_model.dart';
import 'search_result_dto.dart';

class GithubModel extends Model {
  final GithubRepository repository;
  final LoadingModel loadingBloc;

  GithubModel(this.repository, this.loadingBloc) {
    fetch("flutter");
  }

  var _result = SearchResultDto();

  SearchResultDto get value => _result;

  void fetch(String freeWord) {
    loadingBloc.loading(true);
    repository.fetch(freeWord).then((result) {
      _result = result;
    }).whenComplete(() {
      loadingBloc.loading(false);
      notifyListeners();
    });
  }
}
