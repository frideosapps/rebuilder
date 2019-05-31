import 'package:flutter/material.dart';

import 'data_model.dart';

///
/// Simple data model provider that extends a StatefulWidget and use
/// an InheritedWidget to provide the model to the widgets on the
/// tree.
///
class DataModelProvider<T extends DataModel> extends StatefulWidget {
  const DataModelProvider({@required this.dataModel, @required this.child})
      : assert(dataModel != null, 'The dataModel argument is null.'),
        assert(child != null, 'The child argument is null.');

  final T dataModel;
  final Widget child;

  @override
  _DataModelProviderState createState() {
    return _DataModelProviderState();
  }

  static T of<T extends DataModel>(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedState)
            as _InheritedState)
        .dataModel;
  }
}

class _DataModelProviderState extends State<DataModelProvider<DataModel>> {
  @override
  void dispose() {
    widget.dataModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedState(dataModel: widget.dataModel, child: widget.child);
}

class _InheritedState extends InheritedWidget {
  const _InheritedState({
    @required this.dataModel,
    @required Widget child,
    Key key,
  }) : super(key: key, child: child);

  final DataModel dataModel;

  @override
  bool updateShouldNotify(_InheritedState old) => dataModel != old.dataModel;
}
