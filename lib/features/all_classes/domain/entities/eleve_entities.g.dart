// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eleve_entities.dart';

// ignore_for_file: type=lint
mixin _$EleveEntitiesDaoMixin on DatabaseAccessor<AppDatabase> {
  $EleveEntitiesTable get eleveEntities => attachedDatabase.eleveEntities;
  EleveEntitiesDaoManager get managers => EleveEntitiesDaoManager(this);
}

class EleveEntitiesDaoManager {
  final _$EleveEntitiesDaoMixin _db;
  EleveEntitiesDaoManager(this._db);
  $$EleveEntitiesTableTableManager get eleveEntities =>
      $$EleveEntitiesTableTableManager(_db.attachedDatabase, _db.eleveEntities);
}
