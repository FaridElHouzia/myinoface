// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_entities.dart';

// ignore_for_file: type=lint
mixin _$ClassEntitiesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClassEntitiesTable get classEntities => attachedDatabase.classEntities;
  ClassEntitiesDaoManager get managers => ClassEntitiesDaoManager(this);
}

class ClassEntitiesDaoManager {
  final _$ClassEntitiesDaoMixin _db;
  ClassEntitiesDaoManager(this._db);
  $$ClassEntitiesTableTableManager get classEntities =>
      $$ClassEntitiesTableTableManager(_db.attachedDatabase, _db.classEntities);
}
