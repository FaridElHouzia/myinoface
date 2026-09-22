// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demandes_recuperations.dart';

// ignore_for_file: type=lint
mixin _$DemandesRecuperationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DemandesRecuperationsTable get demandesRecuperations =>
      attachedDatabase.demandesRecuperations;
  DemandesRecuperationsDaoManager get managers =>
      DemandesRecuperationsDaoManager(this);
}

class DemandesRecuperationsDaoManager {
  final _$DemandesRecuperationsDaoMixin _db;
  DemandesRecuperationsDaoManager(this._db);
  $$DemandesRecuperationsTableTableManager get demandesRecuperations =>
      $$DemandesRecuperationsTableTableManager(
          _db.attachedDatabase, _db.demandesRecuperations);
}
