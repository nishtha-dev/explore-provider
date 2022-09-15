import 'package:explore_provider/modals/baseClass.dart';
import 'package:explore_provider/provider/objectProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

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
