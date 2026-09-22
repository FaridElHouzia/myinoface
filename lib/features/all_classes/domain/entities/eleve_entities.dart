import 'package:myinoface/core/database/app_database.dart';
import 'package:drift/drift.dart';

part 'eleve_entities.g.dart';

@DataClassName('EleveEntitie')
class EleveEntities extends Table {

  IntColumn get id_personne => integer()();
  TextColumn get nom => text()();
  TextColumn get prenom => text()();
  TextColumn get eleve_nom => text()();
  IntColumn get id_classe => integer()();
  TextColumn get eleve_photo => text().nullable()();
  IntColumn get id_eleve_recuperations => integer().nullable()(); // == null > show

  @override
  Set<Column> get primaryKey => {id_personne};
}

@DriftAccessor(tables: [EleveEntities])
class EleveEntitiesDao extends DatabaseAccessor<AppDatabase>
    with _$EleveEntitiesDaoMixin {

  final AppDatabase db;
  EleveEntitiesDao(this.db) : super(db);

  Stream<List<EleveEntitie>> watchAllEleveEntities() => select(eleveEntities).watch();
  Future<List<EleveEntitie>> getAllEleveEntities() => select(eleveEntities).get();

  Future<void> insertAllEleveEntities(List<Insertable<EleveEntitie>> rows) =>
      batch((batch) => batch.insertAll(eleveEntities, rows, mode: InsertMode.replace));
  Future insertEleveEntities(Insertable<EleveEntitie> row) => into(eleveEntities).insert(row, mode: InsertMode.replace);
  Future updateEleveEntities(Insertable<EleveEntitie> row) => update(eleveEntities).replace(row);
  Future deleteEleveEntities(Insertable<EleveEntitie> row) => delete(eleveEntities).delete(row);

  Future<EleveEntitie> getEleveEntitiesById(int idElev) {
    return (select(eleveEntities)
      ..where((table) => table.id_eleve_recuperations.equals(idElev))
    ).getSingle();
  }

  Stream<EleveEntitie> watchEleveEntitiesById(int idElev) {
    return (select(eleveEntities)
      ..where((table) => table.id_eleve_recuperations.equals(idElev))
    ).watchSingle();
  }

  Stream<List<EleveEntitie>> watchEleveEntitiesByIdClass(int idClass) {
    return (select(eleveEntities)
      ..where((table) => table.id_classe.equals(idClass))
    ).watch();
  }


  Stream<List<EleveEntitie>> watchEleveRecuperationsIsNull(int idClasse) {
    return (select(eleveEntities)
      ..where((table) => table.id_eleve_recuperations.isNull())
      ..where((table) => table.id_classe.equals(idClasse))
    ).watch();
  }

  Stream<List<EleveEntitie>> watchEleveRecuperationsIsNotNull(int idClasse) {
    return (select(eleveEntities)
      ..where((table) => table.id_eleve_recuperations.isNotNull())
        ..where((table) => table.id_classe.equals(idClasse))
    ).watch();
  }

  Future<void> updateRecuperationsById({required EleveEntitie entitie, required int id_eleve_recuperations}) {
    return (update(eleveEntities)
      ..where((t) => t.id_personne.equals(entitie.id_personne))
    ).write(EleveEntitie(
        nom: entitie.nom,
        prenom: entitie.prenom,
        id_classe: entitie.id_classe,
        eleve_nom: entitie.eleve_nom,
        eleve_photo: entitie.eleve_photo,
        id_personne: entitie.id_personne,
        id_eleve_recuperations: id_eleve_recuperations,
      )
    );
  }
}