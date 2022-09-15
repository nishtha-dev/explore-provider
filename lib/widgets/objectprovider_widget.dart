import 'package:explore_provider/provider/objectProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

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
