import 'package:myinoface/core/database/app_database.dart';
import 'package:drift/drift.dart';

part 'demandes_recuperations.g.dart';

@DataClassName('DemandesRecuperation')
class DemandesRecuperations extends Table {

  IntColumn get id_eleve_recuperations => integer()();
  IntColumn get id_classe => integer()();
  TextColumn get parent_nom => text()();
  TextColumn get eleve_nom => text()();
  TextColumn get eleve_photo => text()();
  DateTimeColumn get date_de_la_demande => dateTime().nullable().withDefault(Constant(DateTime.now()))();
  // DateTimeColumn get dateCheck => dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id_eleve_recuperations};
}

@DriftAccessor(tables: [DemandesRecuperations])
class DemandesRecuperationsDao extends DatabaseAccessor<AppDatabase>
    with _$DemandesRecuperationsDaoMixin {

  final AppDatabase db;
  DemandesRecuperationsDao(this.db) : super(db);

  Stream<List<DemandesRecuperation>> watchAllDemandesRecuperations() => select(demandesRecuperations).watch();
  Future<List<DemandesRecuperation>> getAllDemandesRecuperations() => select(demandesRecuperations).get();

  Future<void> insertAllDemandesRecuperations(List<Insertable<DemandesRecuperation>> rows) =>
      batch((batch) => batch.insertAll(demandesRecuperations, rows, mode: InsertMode.replace));
  Future insertDemandesRecuperations(Insertable<DemandesRecuperation> row) => into(demandesRecuperations).insert(row, mode: InsertMode.replace);
  Future updateDemandesRecuperations(Insertable<DemandesRecuperation> row) => update(demandesRecuperations).replace(row);
  Future deleteDemandesRecuperations(Insertable<DemandesRecuperation> row) => delete(demandesRecuperations).delete(row);

  Future<DemandesRecuperation> getDemandesRecuperationById(int idElev) {
    return (select(demandesRecuperations)
      ..where((table) => table.id_eleve_recuperations.equals(idElev))
    ).getSingle();
  }

  Stream<DemandesRecuperation> watchDemandesRecuperationById(int idElev) {
    return (select(demandesRecuperations)
      ..where((table) => table.id_eleve_recuperations.equals(idElev))
    ).watchSingle();
  }

  Stream<List<DemandesRecuperation>> watchDemandesRecuperationByIdClass(int idClass) {
    return (select(demandesRecuperations)
      ..where((table) => table.id_classe.equals(idClass))
    ).watch();
  }
}