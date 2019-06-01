import 'package:flutter/material.dart';

import 'state_wrapper.dart';

class _ContextWrapper {
  BuildContext context;
}

class _StateRebuilderWrapper {
  _StateRebuilder state;
}

typedef RebuilderBuilder<T> = Widget Function(Rebuilder<T> state, T data);

///
/// The `Rebuilder` widget builds itself whenever the `rebuild`
/// method of the `StateWrapper` associated to it is called.
///
/// In the context of a widget, the `Rebuilder` is used to make
/// it possible rebuilding only a portion of it, by wrapping
/// in its builder the widgets that need to be rebuilded, in order
/// to avoid to rebuild the entire widgets tree.
///
/// Parameters:
/// - `rebuilderState`: an instance of a `StateWrapper`
/// - `builder`
/// - `dataModel`: if provided, this instance of [DataModel] is passed
///  through the builder.
/// - `parentState`: if provided, inside the builder it is possible call
/// the method `rebuildParent`, to rebuild the `Rebuilder` associated to
/// this `StateWrapper` instance.
///
/// E.g.
/// ```dart
/// Rebuilder<CountersModel>(
///     dataModel: countersModel,
///     rebuilderState: countersModel.counterUpState,
///     builder: (state, data) {
///       // Accessing to `counterUp` to the `DataModel`
///       // derived class provided to the `dataModel` parameter
///       return Text('${data.counterUp}');
///    }),
/// RaisedButton(
///   child: const Text('+'),
///   onPressed: countersModel.incrementCounterUp,
/// )
/// ```
///
/// In the `countersModel`:
///
/// ```dart
/// void incrementCounterUp() {
///    counterUp++;
///    counterUpState.rebuild();
/// }
/// ```
///
class Rebuilder<T> extends StatefulWidget {
  Rebuilder(
      {Key key,
      @required this.rebuilderState,
      @required this.builder,
      this.dataModel,
      this.parentState})
      : assert(rebuilderState != null),
        assert(builder != null),
        super(key: key) {
    if (rebuilderState != null) {
      rebuilderState.state = this;
    }
  }

  final StateWrapper rebuilderState;

  final Rebuilder parentState;

  final RebuilderBuilder<T> builder;

  final T dataModel;

  final _StateRebuilderWrapper _state = _StateRebuilderWrapper();

  final _ContextWrapper _context = _ContextWrapper();

  // UTILS
  //
  BuildContext get context => _context.context;
  //
  Size get size => MediaQuery.of(context).size;
  //
  ThemeData get theme => Theme.of(context);

  /// By calling this method the `Rebuilder` widget rebuilds.
  void rebuild() {
    _state.state.rebuild();
  }

  /// If a state is passed to the `parentState` parameter of the
  /// `Rebuilder` widget, the one associated with this state rebuilds.
  void rebuildParent() {
    assert(parentState != null);
    parentState?.rebuild();
  }

  void _getState(State state, BuildContext context) {
    _state.state = state;
    _context.context = context;
  }

  @override
  _StateRebuilder<T> createState() => _StateRebuilder<T>();
}

///
///
///
///
class _StateRebuilder<T> extends State<Rebuilder<T>> {
  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    widget._getState(this, context);
    return widget.builder(widget, widget.dataModel);
  }
}
