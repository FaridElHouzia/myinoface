import 'package:myinoface/core/database/app_database.dart';
import 'package:drift/drift.dart';

part 'class_entities.g.dart';

@DataClassName('ClassEntitie')
class ClassEntities extends Table {

  IntColumn get id_classe => integer()();
  TextColumn get classe_description => text()();
  IntColumn get id_niveau => integer()();
  TextColumn get niveau => text()();
  IntColumn get nbrnotification => integer().withDefault(const Constant(0))();
  TextColumn get Responsable => text().nullable()();


  @override
  Set<Column> get primaryKey => {id_classe};
}

@DriftAccessor(tables: [ClassEntities])
class ClassEntitiesDao extends DatabaseAccessor<AppDatabase>
    with _$ClassEntitiesDaoMixin {

  final AppDatabase db;
  ClassEntitiesDao(this.db) : super(db);

  Stream<List<ClassEntitie>> watchAllClassEntities() => select(classEntities).watch();
  Future<List<ClassEntitie>> getAllClassEntities() => select(classEntities).get();

  Future<void> insertAllClassEntities(List<Insertable<ClassEntitie>> rows) =>
      batch((batch) => batch.insertAll(classEntities, rows, mode: InsertMode.replace));
  Future insertClassEntities(Insertable<ClassEntitie> row) => into(classEntities).insert(row, mode: InsertMode.replace);
  Future updateClassEntities(Insertable<ClassEntitie> row) => update(classEntities).replace(row);
  Future deleteClassEntities(Insertable<ClassEntitie> row) => delete(classEntities).delete(row);

  Future<ClassEntitie> getClassEntitieById(int idClass) {
    return (select(classEntities)
      ..where((table) => table.id_classe.equals(idClass))
    ).getSingle();
  }

  Stream<ClassEntitie> watchClassEntitieById(int idClass) {
    return (select(classEntities)
      ..where((table) => table.id_classe.equals(idClass))
    ).watchSingle();
  }

  Future<List<ClassEntitie>> getClassEntitieByResponsable(String responsable) {
    return (select(classEntities)
      ..where((table) => table.Responsable.equals(responsable).not() | table.Responsable.isNull())
    ).get();
  }
}