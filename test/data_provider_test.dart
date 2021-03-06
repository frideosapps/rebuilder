// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rebuilder/rebuilder.dart';

class AppModel extends DataModel {
  String text = 'test';

  @override
  void dispose() {}
}

class App extends StatelessWidget {
  final appModel = AppModel();

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

    return MaterialApp(title: 'Rebuilder example', home: Text(appModel.text));
  }
}

void main() {
  testWidgets('DataProvider test', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    expect(find.text('test'), findsOneWidget);
  });
}
