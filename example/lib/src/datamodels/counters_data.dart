import 'package:rebuilder/rebuilder.dart';

import '../repository.dart';

class CountersModel extends DataModel {
  CountersModel({this.repository}) {
    // Initialize the instance of the `RebuilderObject` with
    // with an instance of a `StateWrapper` that will be bound
    // to a `Rebuilder` widget.
    counterDown = RebuilderObject<int>.init(
        rebuilderState: counterDownState,
        initialData: 100,
        onChange: _onCounterDownChange);
  }

  final Repository repository;

  // STATES
  final counterUpState = StateWrapper();
  final counterDownState = StateWrapper();
  final counterMulState = StateWrapper();
  final listUsersState = StateWrapper();

  // COUNTERS
  int counterUp = 0;
  RebuilderObject<int> counterDown;
  int counterMul = 2;

  // METHODS
  void incrementCounterUp() {
    counterUp++;
    counterUpState.rebuild();
  }

  void decrementCounterDown() {
    counterDown.value--;

    // Using the `RebuilderObject` the `rebuild` method of the
    // counterDownState will automatically be called.
    //
    // states.counterDownState.rebuild();
  }

  void _onCounterDownChange() {
    print('Value changed: ${counterDown.value}');
  }

  void addUser() {
    var newUser = 'User ${repository.users.length + 1}';
    repository.addUser(newUser);
    listUsersState.rebuild();
  }

  @override
  void dispose() {}
}
