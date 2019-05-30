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
  AppModel() {
    counterDown = RebuilderObject<int>.init(
        rebuilderState: counterDownState,
        initialData: 100,
        onChange: _onCounterDownChange);
  }

  String text = 'test';

  RebuilderObject<int> counterDown;

  final counterDownState = StateWrapper();

  bool onChangeCalled = false;

  void decrementCounterDown() {
    counterDown.value--;
  }

  void _onCounterDownChange() {
    onChangeCalled = true;
  }

  @override
  void dispose() {}
}

final appModel = AppModel();

class App extends StatelessWidget {
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

    return MaterialApp(
        title: 'Rebuilder example',
        home: Column(
          children: <Widget>[
            Text(appModel.text),
            Rebuilder<AppModel>(
                rebuilderState: appModel.counterDownState,
                builder: (state, _) {
                  return Text('${appModel.counterDown.value}');
                }),
            RaisedButton(
              child: const Text('-'),
              onPressed: appModel.decrementCounterDown,
            )
          ],
        ));
  }
}

void main() {
  testWidgets('Rebuilder test', (WidgetTester tester) async {
    await tester.pumpWidget(App());
    expect(find.text('test'), findsOneWidget);

    expect(appModel.onChangeCalled, false);

    final button = find.byType(RaisedButton);

    await tester.tap(button);

    await tester.pump();

    expect(find.text('99'), findsOneWidget);
    expect(appModel.onChangeCalled, true);

    await tester.tap(button);

    await tester.pump();

    expect(find.text('98'), findsOneWidget);
  });
}
