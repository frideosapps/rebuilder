import 'package:flutter/material.dart';

import 'package:rebuilder/rebuilder.dart';

import 'src/datamodels/app_data.dart';
import 'src/mainpage.dart';
import 'src/models/theme.dart';
import 'src/repository.dart';

void main() {
  final repository = Repository();
  runApp(App(
    repository: repository,
  ));
}

class App extends StatefulWidget {
  const App({this.repository});

  final Repository repository;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppModel appModel;

  @override
  void initState() {
    super.initState();
    appModel = AppModel(repository: widget.repository);
  }

  @override
  Widget build(BuildContext context) {
    return DataModelProvider<AppModel>(
      dataModel: appModel,
      child: MaterialPage(),
    );
  }
}

class MaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = DataModelProvider.of<AppModel>(context);

    return Rebuilder(
        rebuilderState: appModel.materialState,
        builder: (state, _) {
          return MaterialApp(
              title: 'Rebuilder example',
              theme: themes[appModel.chosenTheme.value],
              home: MainPage());
        });
  }
}
