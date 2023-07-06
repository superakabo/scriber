import 'package:flutter/material.dart';

import '../localizations/strings.dart';

/// Mark: A simple utility class to manage the
/// android bottom navigation bar back stack.

class BackStackManager {
  BackStackManager({
    required NavigatorState navigator,
    required int numberOfTabs,
    int initialIndex = 0,
  })  : _navigator = navigator,
        _numberOfTabs = numberOfTabs,
        _initialIndex = initialIndex,
        _indexes = [initialIndex];

  final NavigatorState _navigator;
  final int _numberOfTabs;
  final int _initialIndex;
  final List<int> _indexes;

  ({bool canPop, int previousIndex}) onBackPressed(Strings strings) {
    int previousIndex = _initialIndex;
    bool canPop = false;

    if (_indexes.isNotEmpty) {
      _indexes.removeLast();
      previousIndex = (_indexes.isNotEmpty) ? _indexes.last : _initialIndex;
      if (_indexes.isEmpty) _showSnackBar(strings);
    } else {
      canPop = true;
    }

    return (canPop: canPop, previousIndex: previousIndex);
  }

  int update(int index) {
    /// Mark: prevent repetitive entries.
    if (_indexes.isEmpty) {
      _indexes.addAll([_initialIndex, index]);
    } else if (_indexes.last != index) {
      _indexes.add(index);
    }

    /// Mark: keep only recent entries
    if (_indexes.length > _numberOfTabs) {
      final recentIndexes = _indexes.skip(_numberOfTabs).toList();
      _indexes.clear();
      _indexes.addAll(recentIndexes);
    }

    return index;
  }

  void _showSnackBar(Strings strings) {
    ScaffoldMessenger.of(_navigator.context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          strings.pressTheBackKey,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
