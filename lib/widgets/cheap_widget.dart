import 'package:explore_provider/modals/baseClass.dart';
import 'package:explore_provider/provider/objectProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

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
