import 'package:flutter/material.dart';

import 'package:rebuilder/rebuilder.dart';

import '../datamodels/tree_data.dart';

class TreePage extends StatelessWidget {
  const TreePage();

  @override
  Widget build(BuildContext context) {
    final treeModel = DataModelProvider.of<TreeModel>(context);

    print('rebuilt');
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Rebuilder(
                rebuilderState: treeModel.usersState,
                builder: (context, snapshot) {
                  return Text('Users: ${treeModel.repository.users.length}');
                }),
            RaisedButton(
              child: const Text('Remove last user'),
              onPressed: treeModel.delUser,
            ),
            Divider(),
            Rebuilder<TreeModel>(
                dataModel: treeModel,
                rebuilderState: treeModel.firstSubtreeState,
                builder: (state, data) {
                  return FirstSubtree(
                      str: data.firstString, counter: data.firstCounter);
                }),
            Rebuilder<TreeModel>(
                dataModel: treeModel,
                rebuilderState: treeModel.secondSubtreeState,
                builder: (state, data) {
                  return SecondSubtree(
                      str: data.secondString, counter: data.secondCounter);
                }),
            Rebuilder<TreeModel>(
                dataModel: treeModel,
                rebuilderState: treeModel.thirdSubtreeState,
                builder: (state, data) {
                  return ThirdSubtree(
                      str: data.thirdString, counter: data.thirdCounter);
                }),
          ],
        ),
      ),
    );
  }
}

class FirstSubtree extends StatelessWidget {
  const FirstSubtree({this.str, this.counter});

  final String str;
  final int counter;

  @override
  Widget build(BuildContext context) {
    final treeModel = DataModelProvider.of<TreeModel>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'First subtree',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('(rebuilds: $counter)'),
          Text('Random 1: $str'),
          RaisedButton(
            child: const Text('Rebuild subtree 1'),
            onPressed: treeModel.randomFirst,
          ),
        ],
      ),
    );
  }
}

class SecondSubtree extends StatelessWidget {
  const SecondSubtree({this.str, this.counter});

  final String str;
  final int counter;

  @override
  Widget build(BuildContext context) {
    final treeModel = DataModelProvider.of<TreeModel>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Second subtree',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('(rebuilds: $counter)'),
          Text('Random 2: $str'),
          RaisedButton(
            child: const Text('Rebuild subtree 2'),
            onPressed: treeModel.randomSecond,
          ),
        ],
      ),
    );
  }
}

class ThirdSubtree extends StatelessWidget {
  const ThirdSubtree({this.str, this.counter});

  final String str;
  final int counter;

  @override
  Widget build(BuildContext context) {
    final treeModel = DataModelProvider.of<TreeModel>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Third subtree',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('(rebuilds: $counter)'),
          Text('Random 3: $str'),
          RaisedButton(
            child: const Text('Rebuild subtree 3'),
            onPressed: treeModel.randomThird,
          ),
        ],
      ),
    );
  }
}
