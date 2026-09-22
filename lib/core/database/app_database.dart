import 'package:myinoface/features/demande_recuperation/domain/entities/demandes_recuperations.dart';
import 'package:myinoface/features/all_classes/domain/entities/eleve_entities.dart';
import 'package:myinoface/core/entities/class_entities.dart';
import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';

part 'app_database.g.dart';

@DriftDatabase(
    /// All Tables
    tables: [
      DemandesRecuperations,
      ClassEntities,
      EleveEntities,
    ],
    /// All Daos
    daos: [
      DemandesRecuperationsDao,
      ClassEntitiesDao,
      EleveEntitiesDao,
    ],
    /// All Queries
    queries: {},
)
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super((SqfliteQueryExecutor.inDatabaseFolder(
    path: 'db.myinoface',
    logStatements: true,
  )));

  Future<void> deleteAllData() {
    return transaction(() async {
      for (var table in allTables) {
        await delete(table).go();
      }
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(

    onUpgrade: (migrator, from, to) async {
      if (from == 1) {
        // await migrator.drop(emploitemps);
        await migrator.createTable(eleveEntities);
        // await migrator.createTable(planCantines);
        // await migrator.addColumn(agendaPhotoDetails, agendaPhotoDetails.id_personne);
        // await migrator.createTable(emploitemps);
        // await migrator.addColumn(seances, seances.id_personne_eleve);
      } else if (from == 2) {
        await migrator.addColumn(classEntities, classEntities.Responsable);
      }
    },
  );

  @override
  int get schemaVersion => 3;

  //! SINGLETON
  static final AppDatabase _singleton = AppDatabase._internal();
  AppDatabase._internal() : super((SqfliteQueryExecutor.inDatabaseFolder(
    path: 'db.myinoface',
    logStatements: true,
  )));


  static AppDatabase get instance => _singleton;
}
