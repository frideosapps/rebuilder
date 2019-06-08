# rebuilder [![pub package](https://img.shields.io/pub/v/rebuilder.svg)](https://pub.dartlang.org/packages/rebuilder)

**Rebuilder** is an easy and minimalistic state management library for Flutter. 

It consists of:

- A `DataModel` class to extend to create a class where lives the data and the business logic for the UI.
  
- A `DataModelProvider` that provides this model to the widgets tree by using an InheritedWidget.
  
- A `RebuilderState` that holds the state of a `Rebuilder` widget.
  
- The `Rebuilder` widget that represents the entity which rebuilds every time the `rebuild` method of the associated `RebuilderState`'s `state` property is called. 
  
- The `RebuilderObject`: an object bound to a `RebuilderState` in order to rebuild the `Rebuilder` widget associated to this state whenever a new value is set.
  

##### Examples built with this library:
- **[Rebuilder example](https://github.com/frideosapps/rebuilder/tree/master/example)**. Check out the example app to know how to: 
  - Implement a counter
  - Use the DataModel to separate the UI from the business logic
  - Implement a dynamic theme changer with a `RebuilderObject`
  - Bind a function to a `RebuilderObject`
  - Sharing data between widgets
  - Update only a subtree of widgets
  
- **[Quiz game](https://github.com/frideosapps/trivia_rebuilder)**: a simple trivia game built with Flutter and this package.



## Getting started


##### 1. Define a `DataModel`
```dart
class CountersModel extends DataModel {
  CountersModel() {

    // Initialize the instance of the `RebuilderObject` with
    // with an instance of a `RebuilderState` that will be bound
    // to a `Rebuilder` widget.
    counterDown = RebuilderObject<int>.init(
        rebuilderState: counterDownState,
        initialData: 100,
        onChange: _onCounterDownChange);
  }
  
  // STATES
  final counterUpState = RebuilderState();
  final counterDownState = RebuilderState();
  final counterMulState = RebuilderState(); 

  // COUNTERS
  int counterUp = 0;
  int counterMul = 2;
  RebuilderObject<int> counterDown;

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

  @override
  void dispose() {}
}
```

##### 2. Provide the `CountersModel` by using the `DataModelProvider` widget
```dart
final countersModel = CountersModel()

DataModelProvider<CountersModel>(
          dataModel: countersModel,
          child: const CountersPage(),
);
```


##### 3. Get the `CountersModel` instance from the `context` of a widget in the tree
```dart
  Widget build(BuildContext context) {
    final countersModel = DataModelProvider.of<CountersModel>(context);
```


##### 4. Bind the `RebuilderState` instances to the `Rebuilder` widgets in the view
```dart
Rebuilder<CountersModel>(
    dataModel: countersModel,
    rebuilderState: countersModel.counterUpState,
    builder: (state, data) {
      // Accessing to `counterUp` in the `DataModel`
      // derived class provided through the `data` parameter
      return Text('${data.counterUp}');
      // 
      // It is possible to directly access to `counterUp`
      // without using the `dataModel` parameter:
      //
      // builder: (state, _) {
      // return Text('${countersModel.counterUp}');
    }),
RaisedButton(
  child: const Text('+'),
  onPressed: countersModel.incrementCounterUp,
),


 
Rebuilder<RebuilderObject>(
  dataModel: countersModel.counterDown,
  rebuilderState: countersModel.counterDownState,
  builder: (state, data) {
    return Text('${data.value}');
  }),
RaisedButton(
  child: const Text('-'),
  onPressed: countersModel.decrementCounterDown,
)



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
```

