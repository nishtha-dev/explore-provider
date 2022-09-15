import 'package:explore_provider/provider/objectProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modals/baseClass.dart';

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
          const Text('Last updated'),
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
