import 'package:flutter/material.dart';
import 'package:rebuilder/rebuilder.dart';

import '../datamodels/counters_data.dart';

class CountersPage extends StatelessWidget {
  const CountersPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const CounterWidget(),
            const ListUsers(),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countersModel = DataModelProvider.of<CountersModel>(context);

    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'CounterUp:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Rebuilder<CountersModel>(
                    dataModel: countersModel,
                    rebuilderState: countersModel.counterUpState,
                    builder: (state, data) {
                      // Accessing to `counterUp` to the `DataModel`
                      // derived class provided to the `dataModel` parameter
                      return Text('${data.counterUp}');
                    }),
                Column(
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('+'),
                      onPressed: countersModel.incrementCounterUp,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'CounterDown:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Rebuilder<CountersModel>(
                    rebuilderState: countersModel.counterDownState,
                    builder: (state, _) {
                      // Accessing to `counterUp` without using the
                      // `dataModel` parameter of the `Rebuilder` widget.
                      return Text('${countersModel.counterDown.value}');
                    }),
                RaisedButton(
                  child: const Text('-'),
                  onPressed: countersModel.decrementCounterDown,
                )
              ],
            ),
            Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'CounterMul:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Rebuilder<CountersModel>(
                    dataModel: countersModel,
                    rebuilderState: countersModel.counterMulState,
                    builder: (state, data) {
                      return Column(children: <Widget>[
                        Text('${data.counterMul}'),
                        RaisedButton(
                            child: const Text('*'),
                            onPressed: () {
                              data.counterMul *= 2;
                              if (data.counterMul > 65536) {
                                data.counterMul = 2;
                              }
                              state.rebuild();
                            }),
                      ]);
                    }),
              ],
            ),
          ],
        ));
  }
}

class ListUsers extends StatelessWidget {
  const ListUsers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countersModel = DataModelProvider.of<CountersModel>(context);
    return Column(
      children: [
        RaisedButton(
          child: const Text('Add user'),
          onPressed: countersModel.addUser,
        ),
        Rebuilder<List<String>>(
            rebuilderState: countersModel.listUsersState,
            dataModel: countersModel.repository.users,
            builder: (state, data) {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Users: ${countersModel.repository.users.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                for (var user in data) ...[Text(user)],
              ]);
            }),
      ],
    );
  }
}
