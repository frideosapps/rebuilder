import 'rebuilder.dart';

///
/// Used to associate a state to a `Rebuilder` widget.
///
class StateWrapper {
  Rebuilder state;

  ///
  /// Rebuilds the `Rebuilder` widget associated to this state.
  void rebuild() => state.rebuild();

  ///
  /// If a `StateWrapper` is provided  to the `parentState` parameter
  /// of the `Rebuilder` widget, it rebuilds the `Rebuilder` widget
  /// associated to this state.
  void rebuildParent() => state.rebuildParent();
}
