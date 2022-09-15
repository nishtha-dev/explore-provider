import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ObjectProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider App'),
      ),
      body: Column(
        children: [
          Row(
            children: const [
              Expanded(child: CheapWidget()),
              Expanded(child: ExpensiveWidget())
            ],
          ),
          Row(
            children: const [Expanded(child: ObjectProviderWidget())],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    context.read<ObjectProvider>().reset();
                  },
                  child: const Text("Stop")),
              TextButton(
                  onPressed: () {
                    context.read<ObjectProvider>().start();
                  },
                  child: const Text("Start")),
            ],
          )
        ],
      ),
    );
  }
}

@immutable
class BaseClass {
  final String id;
  final String lastUpdated;

  BaseClass()
      : lastUpdated = DateTime.now().toIso8601String(),
        id = Uuid().v4();

  @override
  bool operator ==(covariant BaseClass other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@immutable
class CheapObject extends BaseClass {}

@immutable
class ExpensiveObject extends BaseClass {}

class ObjectProvider extends ChangeNotifier {
  late String id;
  late CheapObject _cheapObject;
  late StreamSubscription _cheapObjectStreamSubs;
  late StreamSubscription _expensiveObjectStreamSubs;
  late ExpensiveObject _expensiveObject;

  CheapObject get cheapObject => _cheapObject;

  ExpensiveObject get expensiveObject => _expensiveObject;

  ObjectProvider()
      : id = const Uuid().v4(),
        _cheapObject = CheapObject(),
        _expensiveObject = ExpensiveObject();

  @override
  void notifyListeners() {
    id = const Uuid().v4();
    super.notifyListeners();
  }

  void start() {
    _cheapObjectStreamSubs =
        Stream.periodic(Duration(seconds: 1)).listen((event) {
      _cheapObject = CheapObject();
      notifyListeners();
    });

    _expensiveObjectStreamSubs =
        Stream.periodic(Duration(seconds: 10)).listen((event) {
      _expensiveObject = ExpensiveObject();
      notifyListeners();
    });
  }

  void reset() {
    _cheapObjectStreamSubs.cancel();
    _expensiveObjectStreamSubs.cancel();
  }
}

class ExpensiveWidget extends StatelessWidget {
  const ExpensiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expensiveObject = context.select<ObjectProvider, ExpensiveObject>(
        (provider) => provider.expensiveObject);
    return Container(
      height: 100,
      color: Colors.blue,
      child: Column(
        children: [
          const Text('Expensive Object'),
          const Text('Last updtaed'),
          Text(expensiveObject.lastUpdated)
        ],
      ),
    );
  }
}

class CheapWidget extends StatelessWidget {
  const CheapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cheapObject = context.select<ObjectProvider, CheapObject>(
        (provider) => provider.cheapObject);
    return Container(
      height: 100,
      color: Colors.yellow,
      child: Column(
        children: [
          const Text('Cheap Object'),
          const Text('Last updated'),
          Text(cheapObject.lastUpdated)
        ],
      ),
    );
  }
}

class ObjectProviderWidget extends StatelessWidget {
  const ObjectProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ObjectProvider>();
    return Container(
      height: 100,
      color: Colors.yellow,
      child: Column(
        children: [
          const Text('Watch Object'),
          const Text('Id'),
          Text(provider.id)
        ],
      ),
    );
  }
}
