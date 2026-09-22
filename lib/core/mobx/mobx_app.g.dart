// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxApp on MobxHomeBase, Store {
  late final _$selectedAtom =
      Atom(name: 'MobxHomeBase.selected', context: context);

  @override
  double get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(double value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  late final _$alertAtom = Atom(name: 'MobxHomeBase.alert', context: context);

  @override
  bool get alert {
    _$alertAtom.reportRead();
    return super.alert;
  }

  @override
  set alert(bool value) {
    _$alertAtom.reportWrite(value, super.alert, () {
      super.alert = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: 'MobxHomeBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$indexAtom = Atom(name: 'MobxHomeBase.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'MobxHomeBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$indexClassAtom =
      Atom(name: 'MobxHomeBase.indexClass', context: context);

  @override
  int get indexClass {
    _$indexClassAtom.reportRead();
    return super.indexClass;
  }

  @override
  set indexClass(int value) {
    _$indexClassAtom.reportWrite(value, super.indexClass, () {
      super.indexClass = value;
    });
  }

  late final _$MobxHomeBaseActionController =
      ActionController(name: 'MobxHomeBase', context: context);

  @override
  void select(double val) {
    final _$actionInfo =
        _$MobxHomeBaseActionController.startAction(name: 'MobxHomeBase.select');
    try {
      return super.select(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAlert(bool val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setAlert');
    try {
      return super.setAlert(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPageChanged(int index) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.onPageChanged');
    try {
      return super.onPageChanged(index);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndex(int val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setIndex');
    try {
      return super.setIndex(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoadingState(bool val) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setLoadingState');
    try {
      return super.setLoadingState(val);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndexClass(int index) {
    final _$actionInfo = _$MobxHomeBaseActionController.startAction(
        name: 'MobxHomeBase.setIndexClass');
    try {
      return super.setIndexClass(index);
    } finally {
      _$MobxHomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selected: ${selected},
alert: ${alert},
currentIndex: ${currentIndex},
index: ${index},
isLoading: ${isLoading},
indexClass: ${indexClass}
    ''';
  }
}
