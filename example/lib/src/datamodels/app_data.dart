import 'package:rebuilder/rebuilder.dart';

import '../repository.dart';
import 'counters_data.dart';
import 'tree_data.dart';

class AppModel extends DataModel {
  AppModel({this.repository}) {
    print('-------AppModel INIT--------');

    chosenTheme = RebuilderObject<String>.init(
        rebuilderState: materialState,
        initialData: 'Default',
        onChange: () => print('changedTheme ${chosenTheme.value}'));

    countersModel = CountersModel(repository: repository);
    treeModel = TreeModel(repository: repository);
  }

  final Repository repository;

  final materialState = StateWrapper();
  final homePage = StateWrapper();

  CountersModel countersModel;
  TreeModel treeModel;

  // Used to change the theme whenever a new theme is set.
  RebuilderObject<String> chosenTheme;

  void changeTheme(String theme) {
    // This will automatically rebuild the Material App
    chosenTheme.value = theme;

    // In this case we don't need to rebuild the settings
    // page because being the MaterialApp widget rebuilded
    // this will be rebuilt.
    //
    // states.settingsPage.rebuild();
  }

  @override
  void dispose() {}
}
