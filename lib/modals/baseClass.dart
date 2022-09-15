// ignore: file_names
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
