import 'package:flutter/material.dart';

import 'package:rebuilder/rebuilder.dart';

import 'datamodels/app_data.dart';
import 'datamodels/counters_data.dart';
import 'datamodels/tree_data.dart';
import 'screens/counters.dart';
import 'screens/settings.dart';
import 'screens/tree.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  RebuilderObject<int> bottomTab;

  Future isUsersListLoaded;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appModel = DataModelProvider.of<AppModel>(context);
    bottomTab = RebuilderObject<int>.init(
        rebuilderState: appModel.homePage, initialData: 0);
    isUsersListLoaded = appModel.repository.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final appModel = DataModelProvider.of<AppModel>(context);

    return FutureBuilder(
        future: isUsersListLoaded,
        builder: (context, snapshot) {
          return Rebuilder<int>(
              rebuilderState: appModel.homePage,
              builder: (state, _) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Rebuilder example'),
                  ),
                  body: !snapshot.hasData
                      ? Center(child: const CircularProgressIndicator())
                      : SwitchTabWidget(
                          appModel: appModel,
                          bottomTab: bottomTab,
                        ),
                  bottomNavigationBar: BottomNavigationBarWidget(
                    bottomTab: bottomTab,
                  ),
                );
              });
        });
  }
}

class SwitchTabWidget extends StatelessWidget {
  const SwitchTabWidget(
      {Key key, @required this.appModel, @required this.bottomTab})
      : super(key: key);

  final AppModel appModel;
  final RebuilderObject<int> bottomTab;

  @override
  Widget build(BuildContext context) {
    switch (bottomTab.value) {
      case 0:
        return DataModelProvider<CountersModel>(
          dataModel: appModel.countersModel,
          child: const CountersPage(),
        );
      case 1:
        return DataModelProvider<TreeModel>(
          dataModel: appModel.treeModel,
          child: const TreePage(),
        );
      case 2:
        return const SettingsPage();
      default:
        return Container();
    }
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key key, @required this.bottomTab})
      : super(key: key);

  final RebuilderObject<int> bottomTab;

  void _changeBottomTab(int index) => bottomTab.value = index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _changeBottomTab,
      currentIndex: bottomTab.value,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.computer),
          title: Text('Counters'),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.filter_list),
          title: Text('Tree'),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
    );
  }
}
