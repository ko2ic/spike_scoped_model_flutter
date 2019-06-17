import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spike_scoped_model_flutter/models/favorites_model.dart';
import 'package:spike_scoped_model_flutter/models/github_model.dart';
import 'package:spike_scoped_model_flutter/models/repo_entity.dart';

import 'widgets/loading_widget.dart';

class GithubListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GithubListState();
  }
}

class GithubListState extends State<StatefulWidget> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('GitHub検索'),
      actions: <Widget>[
        searchBar.getSearchAction(context),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    var model = ScopedModel.of<GithubModel>(context, rebuildOnChange: false);
    searchBar = SearchBar(
        inBar: false,
        setState: (fn) => fn(), // searchbar表示のため
        onSubmitted: (freeWord) => model.fetch(freeWord),
        buildDefaultAppBar: buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: searchBar.build(context),
          body: ScopedModelDescendant<GithubModel>(
            builder: (context, child, model) {
              if (model.value.items.length > 0) {
                var dto = model.value;
                return ScopedModelDescendant<FavoritesModel>(builder: (context, child, FavoritesModel model) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: dto.items.length,
                      itemBuilder: (context, i) {
                        return _buildRow(context, dto.items[i], model.value);
                      });
                });
              }
              return Container();
            },
          ),
        ),
        const LoadingWidget(),
      ],
    );
  }

  Widget _buildRow(BuildContext context, RepoEntity entity, List<RepoEntity> items) {
    final favoritesModel = ScopedModel.of<FavoritesModel>(context);

    bool isFavorite = items.contains(entity);
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
                entity.fullName,
                style: _biggerFont,
              ),
              subtitle: Text(entity.stars.toString()),
              trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    favoritesModel.onFavoriteChanged(entity, items);
                  }),
              onTap: () {
                // TODO 何か処理
              }),
          Divider(),
        ],
      ),
    );
  }
}
