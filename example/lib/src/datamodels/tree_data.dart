import 'dart:math';

import 'package:rebuilder/rebuilder.dart';

import '../repository.dart';

class TreeModel implements DataModel {
  TreeModel({this.repository});

  final Repository repository;

  int firstCounter = 0;
  int secondCounter = 0;
  int thirdCounter = 0;

  String firstString;
  String secondString;
  String thirdString;

  final usersState = StateWrapper();
  final firstSubtreeState = StateWrapper();
  final secondSubtreeState = StateWrapper();
  final thirdSubtreeState = StateWrapper();

  String _randomString() {
    var alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final rnd = Random(DateTime.now().millisecondsSinceEpoch);
    var str = [];

    for (int i = 0; i < 15; i++) {
      final c = rnd.nextInt(alphabet.length - 1);
      str.add(alphabet[c]);
    }

    return str.join();
  }

  void randomFirst() {
    firstString = _randomString();
    firstCounter++;
    firstSubtreeState.rebuild();
  }

  void randomSecond() {
    secondString = _randomString();
    secondCounter++;
    secondSubtreeState.rebuild();
  }

  void randomThird() {
    thirdString = _randomString();
    thirdCounter++;
    thirdSubtreeState.rebuild();
  }

  void delUser() {
    repository.delUser();
    usersState.rebuild();
  }

  @override
  void dispose() {}
}
