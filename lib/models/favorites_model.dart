import 'package:scoped_model/scoped_model.dart';

import 'repo_entity.dart';

class FavoritesModel extends Model {
  final _items = List<RepoEntity>();

  List<RepoEntity> get value => _items;

  void onFavoriteChanged(RepoEntity target, List<RepoEntity> items) {
    if (items.contains(target)) {
      items.remove(target);
    } else {
      items.add(target);
    }

    notifyListeners();
  }
}
