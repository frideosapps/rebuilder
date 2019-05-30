

import 'package:flutter/foundation.dart';

import 'state_wrapper.dart';

///
/// This class is used to create an object bound to a `StateWrapper`
/// in order to rebuild the widget associated to this state whenever
/// a new value is set.
///
/// When used the default constructor is mandatory to set a `StateWrapper`
/// by using the setter `state`.
///
/// Parameters:
/// - `rebuilderState` (`init` constructor)
/// - `initialData`
/// - `onChange`: callback called whenever a new value is set
///
/// (From the example app)
///
/// E.g. declare a StateWrapper for the `MaterialApp` widget to rebuild
/// it when a new app theme is set. This is then given to the
/// `rebuilderState` parameter of the [Rebuilder] widget.
///
/// In the `DataModel` derived object:
/// ```dart
/// final materialState = StateWrapper();
///
/// RebuilderObject<String> chosenTheme;
/// ```
///
/// In its constructor:
/// ```dart
/// chosenTheme = RebuilderObject<String>.init(
///   rebuilderState: materialState,
///   initialData: 'Default',
///   onChange: () => print('changedTheme ${chosenTheme.value}'));
/// ```
///
/// Method to switch theme:
/// ```dart
/// void changeTheme(String theme) {
///   // This will automatically rebuild the Material App
///   chosenTheme.value = theme;
/// }
/// ```
///
/// In the view:
/// ```dart
/// Rebuilder(
///   rebuilderState: appModel.materialState,
///   builder: (state, _) {
///     return MaterialApp(
///         title: 'Rebuilder example',
///         theme: themes[appModel.chosenTheme.value],
///         home: MainPage());
///  });
/// ```
///
class RebuilderObject<T> {
  RebuilderObject({this.initialData, Function onChange}) {
    if (initialData != null) {
      _value = initialData;
    }

    if (onChange != null) {
      _onChange = onChange;
    }
  }

  RebuilderObject.init(
      {@required StateWrapper rebuilderState,
      this.initialData,
      Function onChange})
      : assert(rebuilderState != null) {
    _state = rebuilderState;
    if (initialData != null) {
      _value = initialData;
    }

    if (onChange != null) {
      _onChange = onChange;
    }
  }

  final T initialData;
  T _value;
  StateWrapper _state;
  Function _onChange = () {};

  set state(StateWrapper state) {
    assert(state != null);
    _state = state;
  }

  StateWrapper get state => _state;

  T get value => _value;

  set value(T newValue) {
    if (newValue != _value) {
      _value = newValue;
      _state.rebuild();
      if (_onChange != null) {
        _onChange();
      }
    }
  }

  /// To force the refresh of the `Rebuilder` widget associated
  void refresh() {
    _state?.rebuild();
    if (_onChange != null) {
      _onChange();
    }
  }

  /// To set a callback which will be called every time a
  /// new value is set.
  set onChange(Function fn) {
    assert(fn != null);
    onChange = fn;
  }
}
