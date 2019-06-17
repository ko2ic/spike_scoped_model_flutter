import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spike_scoped_model_flutter/models/loading_model.dart';

import 'models/favorites_model.dart';
import 'models/github_model.dart';
import 'repositories/github_repository_impl.dart';
import 'ui/github_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GithubRepository repository = GithubRepository();
  final LoadingModel _loadingModel = LoadingModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: ScopedModel<LoadingModel>(
        model: _loadingModel,
        child: ScopedModel<GithubModel>(
          model: GithubModel(repository, _loadingModel),
          child: ScopedModel<FavoritesModel>(
            model: FavoritesModel(),
            child: GithubListPage(),
          ),
        ),
      ),
    );
  }
}
