// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DemandesRecuperationsTable extends DemandesRecuperations
    with TableInfo<$DemandesRecuperationsTable, DemandesRecuperation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DemandesRecuperationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _id_eleve_recuperationsMeta =
      const VerificationMeta('id_eleve_recuperations');
  @override
  late final GeneratedColumn<int> id_eleve_recuperations = GeneratedColumn<int>(
      'id_eleve_recuperations', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _id_classeMeta =
      const VerificationMeta('id_classe');
  @override
  late final GeneratedColumn<int> id_classe = GeneratedColumn<int>(
      'id_classe', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parent_nomMeta =
      const VerificationMeta('parent_nom');
  @override
  late final GeneratedColumn<String> parent_nom = GeneratedColumn<String>(
      'parent_nom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eleve_nomMeta =
      const VerificationMeta('eleve_nom');
  @override
  late final GeneratedColumn<String> eleve_nom = GeneratedColumn<String>(
      'eleve_nom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eleve_photoMeta =
      const VerificationMeta('eleve_photo');
  @override
  late final GeneratedColumn<String> eleve_photo = GeneratedColumn<String>(
      'eleve_photo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _date_de_la_demandeMeta =
      const VerificationMeta('date_de_la_demande');
  @override
  late final GeneratedColumn<DateTime> date_de_la_demande =
      GeneratedColumn<DateTime>('date_de_la_demande', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [
        id_eleve_recuperations,
        id_classe,
        parent_nom,
        eleve_nom,
        eleve_photo,
        date_de_la_demande
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'demandes_recuperations';
  @override
  VerificationContext validateIntegrity(
      Insertable<DemandesRecuperation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_eleve_recuperations')) {
      context.handle(
          _id_eleve_recuperationsMeta,
          id_eleve_recuperations.isAcceptableOrUnknown(
              data['id_eleve_recuperations']!, _id_eleve_recuperationsMeta));
    }
    if (data.containsKey('id_classe')) {
      context.handle(_id_classeMeta,
          id_classe.isAcceptableOrUnknown(data['id_classe']!, _id_classeMeta));
    } else if (isInserting) {
      context.missing(_id_classeMeta);
    }
    if (data.containsKey('parent_nom')) {
      context.handle(
          _parent_nomMeta,
          parent_nom.isAcceptableOrUnknown(
              data['parent_nom']!, _parent_nomMeta));
    } else if (isInserting) {
      context.missing(_parent_nomMeta);
    }
    if (data.containsKey('eleve_nom')) {
      context.handle(_eleve_nomMeta,
          eleve_nom.isAcceptableOrUnknown(data['eleve_nom']!, _eleve_nomMeta));
    } else if (isInserting) {
      context.missing(_eleve_nomMeta);
    }
    if (data.containsKey('eleve_photo')) {
      context.handle(
          _eleve_photoMeta,
          eleve_photo.isAcceptableOrUnknown(
              data['eleve_photo']!, _eleve_photoMeta));
    } else if (isInserting) {
      context.missing(_eleve_photoMeta);
    }
    if (data.containsKey('date_de_la_demande')) {
      context.handle(
          _date_de_la_demandeMeta,
          date_de_la_demande.isAcceptableOrUnknown(
              data['date_de_la_demande']!, _date_de_la_demandeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id_eleve_recuperations};
  @override
  DemandesRecuperation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DemandesRecuperation(
      id_eleve_recuperations: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}id_eleve_recuperations'])!,
      id_classe: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_classe'])!,
      parent_nom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_nom'])!,
      eleve_nom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}eleve_nom'])!,
      eleve_photo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}eleve_photo'])!,
      date_de_la_demande: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_de_la_demande']),
    );
  }

  @override
  $DemandesRecuperationsTable createAlias(String alias) {
    return $DemandesRecuperationsTable(attachedDatabase, alias);
  }
}

class DemandesRecuperation extends DataClass
    implements Insertable<DemandesRecuperation> {
  final int id_eleve_recuperations;
  final int id_classe;
  final String parent_nom;
  final String eleve_nom;
  final String eleve_photo;
  final DateTime? date_de_la_demande;
  const DemandesRecuperation(
      {required this.id_eleve_recuperations,
      required this.id_classe,
      required this.parent_nom,
      required this.eleve_nom,
      required this.eleve_photo,
      this.date_de_la_demande});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_eleve_recuperations'] = Variable<int>(id_eleve_recuperations);
    map['id_classe'] = Variable<int>(id_classe);
    map['parent_nom'] = Variable<String>(parent_nom);
    map['eleve_nom'] = Variable<String>(eleve_nom);
    map['eleve_photo'] = Variable<String>(eleve_photo);
    if (!nullToAbsent || date_de_la_demande != null) {
      map['date_de_la_demande'] = Variable<DateTime>(date_de_la_demande);
    }
    return map;
  }

  DemandesRecuperationsCompanion toCompanion(bool nullToAbsent) {
    return DemandesRecuperationsCompanion(
      id_eleve_recuperations: Value(id_eleve_recuperations),
      id_classe: Value(id_classe),
      parent_nom: Value(parent_nom),
      eleve_nom: Value(eleve_nom),
      eleve_photo: Value(eleve_photo),
      date_de_la_demande: date_de_la_demande == null && nullToAbsent
          ? const Value.absent()
          : Value(date_de_la_demande),
    );
  }

  factory DemandesRecuperation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DemandesRecuperation(
      id_eleve_recuperations:
          serializer.fromJson<int>(json['id_eleve_recuperations']),
      id_classe: serializer.fromJson<int>(json['id_classe']),
      parent_nom: serializer.fromJson<String>(json['parent_nom']),
      eleve_nom: serializer.fromJson<String>(json['eleve_nom']),
      eleve_photo: serializer.fromJson<String>(json['eleve_photo']),
      date_de_la_demande:
          serializer.fromJson<DateTime?>(json['date_de_la_demande']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id_eleve_recuperations': serializer.toJson<int>(id_eleve_recuperations),
      'id_classe': serializer.toJson<int>(id_classe),
      'parent_nom': serializer.toJson<String>(parent_nom),
      'eleve_nom': serializer.toJson<String>(eleve_nom),
      'eleve_photo': serializer.toJson<String>(eleve_photo),
      'date_de_la_demande': serializer.toJson<DateTime?>(date_de_la_demande),
    };
  }

  DemandesRecuperation copyWith(
          {int? id_eleve_recuperations,
          int? id_classe,
          String? parent_nom,
          String? eleve_nom,
          String? eleve_photo,
          Value<DateTime?> date_de_la_demande = const Value.absent()}) =>
      DemandesRecuperation(
        id_eleve_recuperations:
            id_eleve_recuperations ?? this.id_eleve_recuperations,
        id_classe: id_classe ?? this.id_classe,
        parent_nom: parent_nom ?? this.parent_nom,
        eleve_nom: eleve_nom ?? this.eleve_nom,
        eleve_photo: eleve_photo ?? this.eleve_photo,
        date_de_la_demande: date_de_la_demande.present
            ? date_de_la_demande.value
            : this.date_de_la_demande,
      );
  DemandesRecuperation copyWithCompanion(DemandesRecuperationsCompanion data) {
    return DemandesRecuperation(
      id_eleve_recuperations: data.id_eleve_recuperations.present
          ? data.id_eleve_recuperations.value
          : this.id_eleve_recuperations,
      id_classe: data.id_classe.present ? data.id_classe.value : this.id_classe,
      parent_nom:
          data.parent_nom.present ? data.parent_nom.value : this.parent_nom,
      eleve_nom: data.eleve_nom.present ? data.eleve_nom.value : this.eleve_nom,
      eleve_photo:
          data.eleve_photo.present ? data.eleve_photo.value : this.eleve_photo,
      date_de_la_demande: data.date_de_la_demande.present
          ? data.date_de_la_demande.value
          : this.date_de_la_demande,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DemandesRecuperation(')
          ..write('id_eleve_recuperations: $id_eleve_recuperations, ')
          ..write('id_classe: $id_classe, ')
          ..write('parent_nom: $parent_nom, ')
          ..write('eleve_nom: $eleve_nom, ')
          ..write('eleve_photo: $eleve_photo, ')
          ..write('date_de_la_demande: $date_de_la_demande')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id_eleve_recuperations, id_classe, parent_nom,
      eleve_nom, eleve_photo, date_de_la_demande);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DemandesRecuperation &&
          other.id_eleve_recuperations == this.id_eleve_recuperations &&
          other.id_classe == this.id_classe &&
          other.parent_nom == this.parent_nom &&
          other.eleve_nom == this.eleve_nom &&
          other.eleve_photo == this.eleve_photo &&
          other.date_de_la_demande == this.date_de_la_demande);
}

class DemandesRecuperationsCompanion
    extends UpdateCompanion<DemandesRecuperation> {
  final Value<int> id_eleve_recuperations;
  final Value<int> id_classe;
  final Value<String> parent_nom;
  final Value<String> eleve_nom;
  final Value<String> eleve_photo;
  final Value<DateTime?> date_de_la_demande;
  const DemandesRecuperationsCompanion({
    this.id_eleve_recuperations = const Value.absent(),
    this.id_classe = const Value.absent(),
    this.parent_nom = const Value.absent(),
    this.eleve_nom = const Value.absent(),
    this.eleve_photo = const Value.absent(),
    this.date_de_la_demande = const Value.absent(),
  });
  DemandesRecuperationsCompanion.insert({
    this.id_eleve_recuperations = const Value.absent(),
    required int id_classe,
    required String parent_nom,
    required String eleve_nom,
    required String eleve_photo,
    this.date_de_la_demande = const Value.absent(),
  })  : id_classe = Value(id_classe),
        parent_nom = Value(parent_nom),
        eleve_nom = Value(eleve_nom),
        eleve_photo = Value(eleve_photo);
  static Insertable<DemandesRecuperation> custom({
    Expression<int>? id_eleve_recuperations,
    Expression<int>? id_classe,
    Expression<String>? parent_nom,
    Expression<String>? eleve_nom,
    Expression<String>? eleve_photo,
    Expression<DateTime>? date_de_la_demande,
  }) {
    return RawValuesInsertable({
      if (id_eleve_recuperations != null)
        'id_eleve_recuperations': id_eleve_recuperations,
      if (id_classe != null) 'id_classe': id_classe,
      if (parent_nom != null) 'parent_nom': parent_nom,
      if (eleve_nom != null) 'eleve_nom': eleve_nom,
      if (eleve_photo != null) 'eleve_photo': eleve_photo,
      if (date_de_la_demande != null) 'date_de_la_demande': date_de_la_demande,
    });
  }

  DemandesRecuperationsCompanion copyWith(
      {Value<int>? id_eleve_recuperations,
      Value<int>? id_classe,
      Value<String>? parent_nom,
      Value<String>? eleve_nom,
      Value<String>? eleve_photo,
      Value<DateTime?>? date_de_la_demande}) {
    return DemandesRecuperationsCompanion(
      id_eleve_recuperations:
          id_eleve_recuperations ?? this.id_eleve_recuperations,
      id_classe: id_classe ?? this.id_classe,
      parent_nom: parent_nom ?? this.parent_nom,
      eleve_nom: eleve_nom ?? this.eleve_nom,
      eleve_photo: eleve_photo ?? this.eleve_photo,
      date_de_la_demande: date_de_la_demande ?? this.date_de_la_demande,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id_eleve_recuperations.present) {
      map['id_eleve_recuperations'] =
          Variable<int>(id_eleve_recuperations.value);
    }
    if (id_classe.present) {
      map['id_classe'] = Variable<int>(id_classe.value);
    }
    if (parent_nom.present) {
      map['parent_nom'] = Variable<String>(parent_nom.value);
    }
    if (eleve_nom.present) {
      map['eleve_nom'] = Variable<String>(eleve_nom.value);
    }
    if (eleve_photo.present) {
      map['eleve_photo'] = Variable<String>(eleve_photo.value);
    }
    if (date_de_la_demande.present) {
      map['date_de_la_demande'] = Variable<DateTime>(date_de_la_demande.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DemandesRecuperationsCompanion(')
          ..write('id_eleve_recuperations: $id_eleve_recuperations, ')
          ..write('id_classe: $id_classe, ')
          ..write('parent_nom: $parent_nom, ')
          ..write('eleve_nom: $eleve_nom, ')
          ..write('eleve_photo: $eleve_photo, ')
          ..write('date_de_la_demande: $date_de_la_demande')
          ..write(')'))
        .toString();
  }
}

class $ClassEntitiesTable extends ClassEntities
    with TableInfo<$ClassEntitiesTable, ClassEntitie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _id_classeMeta =
      const VerificationMeta('id_classe');
  @override
  late final GeneratedColumn<int> id_classe = GeneratedColumn<int>(
      'id_classe', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _classe_descriptionMeta =
      const VerificationMeta('classe_description');
  @override
  late final GeneratedColumn<String> classe_description =
      GeneratedColumn<String>('classe_description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _id_niveauMeta =
      const VerificationMeta('id_niveau');
  @override
  late final GeneratedColumn<int> id_niveau = GeneratedColumn<int>(
      'id_niveau', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _niveauMeta = const VerificationMeta('niveau');
  @override
  late final GeneratedColumn<String> niveau = GeneratedColumn<String>(
      'niveau', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nbrnotificationMeta =
      const VerificationMeta('nbrnotification');
  @override
  late final GeneratedColumn<int> nbrnotification = GeneratedColumn<int>(
      'nbrnotification', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _ResponsableMeta =
      const VerificationMeta('Responsable');
  @override
  late final GeneratedColumn<String> Responsable = GeneratedColumn<String>(
      'responsable', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id_classe,
        classe_description,
        id_niveau,
        niveau,
        nbrnotification,
        Responsable
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_entities';
  @override
  VerificationContext validateIntegrity(Insertable<ClassEntitie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_classe')) {
      context.handle(_id_classeMeta,
          id_classe.isAcceptableOrUnknown(data['id_classe']!, _id_classeMeta));
    }
    if (data.containsKey('classe_description')) {
      context.handle(
          _classe_descriptionMeta,
          classe_description.isAcceptableOrUnknown(
              data['classe_description']!, _classe_descriptionMeta));
    } else if (isInserting) {
      context.missing(_classe_descriptionMeta);
    }
    if (data.containsKey('id_niveau')) {
      context.handle(_id_niveauMeta,
          id_niveau.isAcceptableOrUnknown(data['id_niveau']!, _id_niveauMeta));
    } else if (isInserting) {
      context.missing(_id_niveauMeta);
    }
    if (data.containsKey('niveau')) {
      context.handle(_niveauMeta,
          niveau.isAcceptableOrUnknown(data['niveau']!, _niveauMeta));
    } else if (isInserting) {
      context.missing(_niveauMeta);
    }
    if (data.containsKey('nbrnotification')) {
      context.handle(
          _nbrnotificationMeta,
          nbrnotification.isAcceptableOrUnknown(
              data['nbrnotification']!, _nbrnotificationMeta));
    }
    if (data.containsKey('responsable')) {
      context.handle(
          _ResponsableMeta,
          Responsable.isAcceptableOrUnknown(
              data['responsable']!, _ResponsableMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id_classe};
  @override
  ClassEntitie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassEntitie(
      id_classe: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_classe'])!,
      classe_description: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}classe_description'])!,
      id_niveau: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_niveau'])!,
      niveau: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}niveau'])!,
      nbrnotification: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nbrnotification'])!,
      Responsable: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}responsable']),
    );
  }

  @override
  $ClassEntitiesTable createAlias(String alias) {
    return $ClassEntitiesTable(attachedDatabase, alias);
  }
}

class ClassEntitie extends DataClass implements Insertable<ClassEntitie> {
  final int id_classe;
  final String classe_description;
  final int id_niveau;
  final String niveau;
  final int nbrnotification;
  final String? Responsable;
  const ClassEntitie(
      {required this.id_classe,
      required this.classe_description,
      required this.id_niveau,
      required this.niveau,
      required this.nbrnotification,
      this.Responsable});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_classe'] = Variable<int>(id_classe);
    map['classe_description'] = Variable<String>(classe_description);
    map['id_niveau'] = Variable<int>(id_niveau);
    map['niveau'] = Variable<String>(niveau);
    map['nbrnotification'] = Variable<int>(nbrnotification);
    if (!nullToAbsent || Responsable != null) {
      map['responsable'] = Variable<String>(Responsable);
    }
    return map;
  }

  ClassEntitiesCompanion toCompanion(bool nullToAbsent) {
    return ClassEntitiesCompanion(
      id_classe: Value(id_classe),
      classe_description: Value(classe_description),
      id_niveau: Value(id_niveau),
      niveau: Value(niveau),
      nbrnotification: Value(nbrnotification),
      Responsable: Responsable == null && nullToAbsent
          ? const Value.absent()
          : Value(Responsable),
    );
  }

  factory ClassEntitie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassEntitie(
      id_classe: serializer.fromJson<int>(json['id_classe']),
      classe_description:
          serializer.fromJson<String>(json['classe_description']),
      id_niveau: serializer.fromJson<int>(json['id_niveau']),
      niveau: serializer.fromJson<String>(json['niveau']),
      nbrnotification: serializer.fromJson<int>(json['nbrnotification']),
      Responsable: serializer.fromJson<String?>(json['Responsable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id_classe': serializer.toJson<int>(id_classe),
      'classe_description': serializer.toJson<String>(classe_description),
      'id_niveau': serializer.toJson<int>(id_niveau),
      'niveau': serializer.toJson<String>(niveau),
      'nbrnotification': serializer.toJson<int>(nbrnotification),
      'Responsable': serializer.toJson<String?>(Responsable),
    };
  }

  ClassEntitie copyWith(
          {int? id_classe,
          String? classe_description,
          int? id_niveau,
          String? niveau,
          int? nbrnotification,
          Value<String?> Responsable = const Value.absent()}) =>
      ClassEntitie(
        id_classe: id_classe ?? this.id_classe,
        classe_description: classe_description ?? this.classe_description,
        id_niveau: id_niveau ?? this.id_niveau,
        niveau: niveau ?? this.niveau,
        nbrnotification: nbrnotification ?? this.nbrnotification,
        Responsable: Responsable.present ? Responsable.value : this.Responsable,
      );
  ClassEntitie copyWithCompanion(ClassEntitiesCompanion data) {
    return ClassEntitie(
      id_classe: data.id_classe.present ? data.id_classe.value : this.id_classe,
      classe_description: data.classe_description.present
          ? data.classe_description.value
          : this.classe_description,
      id_niveau: data.id_niveau.present ? data.id_niveau.value : this.id_niveau,
      niveau: data.niveau.present ? data.niveau.value : this.niveau,
      nbrnotification: data.nbrnotification.present
          ? data.nbrnotification.value
          : this.nbrnotification,
      Responsable:
          data.Responsable.present ? data.Responsable.value : this.Responsable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassEntitie(')
          ..write('id_classe: $id_classe, ')
          ..write('classe_description: $classe_description, ')
          ..write('id_niveau: $id_niveau, ')
          ..write('niveau: $niveau, ')
          ..write('nbrnotification: $nbrnotification, ')
          ..write('Responsable: $Responsable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id_classe, classe_description, id_niveau,
      niveau, nbrnotification, Responsable);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassEntitie &&
          other.id_classe == this.id_classe &&
          other.classe_description == this.classe_description &&
          other.id_niveau == this.id_niveau &&
          other.niveau == this.niveau &&
          other.nbrnotification == this.nbrnotification &&
          other.Responsable == this.Responsable);
}

class ClassEntitiesCompanion extends UpdateCompanion<ClassEntitie> {
  final Value<int> id_classe;
  final Value<String> classe_description;
  final Value<int> id_niveau;
  final Value<String> niveau;
  final Value<int> nbrnotification;
  final Value<String?> Responsable;
  const ClassEntitiesCompanion({
    this.id_classe = const Value.absent(),
    this.classe_description = const Value.absent(),
    this.id_niveau = const Value.absent(),
    this.niveau = const Value.absent(),
    this.nbrnotification = const Value.absent(),
    this.Responsable = const Value.absent(),
  });
  ClassEntitiesCompanion.insert({
    this.id_classe = const Value.absent(),
    required String classe_description,
    required int id_niveau,
    required String niveau,
    this.nbrnotification = const Value.absent(),
    this.Responsable = const Value.absent(),
  })  : classe_description = Value(classe_description),
        id_niveau = Value(id_niveau),
        niveau = Value(niveau);
  static Insertable<ClassEntitie> custom({
    Expression<int>? id_classe,
    Expression<String>? classe_description,
    Expression<int>? id_niveau,
    Expression<String>? niveau,
    Expression<int>? nbrnotification,
    Expression<String>? Responsable,
  }) {
    return RawValuesInsertable({
      if (id_classe != null) 'id_classe': id_classe,
      if (classe_description != null) 'classe_description': classe_description,
      if (id_niveau != null) 'id_niveau': id_niveau,
      if (niveau != null) 'niveau': niveau,
      if (nbrnotification != null) 'nbrnotification': nbrnotification,
      if (Responsable != null) 'responsable': Responsable,
    });
  }

  ClassEntitiesCompanion copyWith(
      {Value<int>? id_classe,
      Value<String>? classe_description,
      Value<int>? id_niveau,
      Value<String>? niveau,
      Value<int>? nbrnotification,
      Value<String?>? Responsable}) {
    return ClassEntitiesCompanion(
      id_classe: id_classe ?? this.id_classe,
      classe_description: classe_description ?? this.classe_description,
      id_niveau: id_niveau ?? this.id_niveau,
      niveau: niveau ?? this.niveau,
      nbrnotification: nbrnotification ?? this.nbrnotification,
      Responsable: Responsable ?? this.Responsable,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id_classe.present) {
      map['id_classe'] = Variable<int>(id_classe.value);
    }
    if (classe_description.present) {
      map['classe_description'] = Variable<String>(classe_description.value);
    }
    if (id_niveau.present) {
      map['id_niveau'] = Variable<int>(id_niveau.value);
    }
    if (niveau.present) {
      map['niveau'] = Variable<String>(niveau.value);
    }
    if (nbrnotification.present) {
      map['nbrnotification'] = Variable<int>(nbrnotification.value);
    }
    if (Responsable.present) {
      map['responsable'] = Variable<String>(Responsable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassEntitiesCompanion(')
          ..write('id_classe: $id_classe, ')
          ..write('classe_description: $classe_description, ')
          ..write('id_niveau: $id_niveau, ')
          ..write('niveau: $niveau, ')
          ..write('nbrnotification: $nbrnotification, ')
          ..write('Responsable: $Responsable')
          ..write(')'))
        .toString();
  }
}

class $EleveEntitiesTable extends EleveEntities
    with TableInfo<$EleveEntitiesTable, EleveEntitie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EleveEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _id_personneMeta =
      const VerificationMeta('id_personne');
  @override
  late final GeneratedColumn<int> id_personne = GeneratedColumn<int>(
      'id_personne', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
      'nom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prenomMeta = const VerificationMeta('prenom');
  @override
  late final GeneratedColumn<String> prenom = GeneratedColumn<String>(
      'prenom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eleve_nomMeta =
      const VerificationMeta('eleve_nom');
  @override
  late final GeneratedColumn<String> eleve_nom = GeneratedColumn<String>(
      'eleve_nom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _id_classeMeta =
      const VerificationMeta('id_classe');
  @override
  late final GeneratedColumn<int> id_classe = GeneratedColumn<int>(
      'id_classe', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _eleve_photoMeta =
      const VerificationMeta('eleve_photo');
  @override
  late final GeneratedColumn<String> eleve_photo = GeneratedColumn<String>(
      'eleve_photo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _id_eleve_recuperationsMeta =
      const VerificationMeta('id_eleve_recuperations');
  @override
  late final GeneratedColumn<int> id_eleve_recuperations = GeneratedColumn<int>(
      'id_eleve_recuperations', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id_personne,
        nom,
        prenom,
        eleve_nom,
        id_classe,
        eleve_photo,
        id_eleve_recuperations
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'eleve_entities';
  @override
  VerificationContext validateIntegrity(Insertable<EleveEntitie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_personne')) {
      context.handle(
          _id_personneMeta,
          id_personne.isAcceptableOrUnknown(
              data['id_personne']!, _id_personneMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
          _nomMeta, nom.isAcceptableOrUnknown(data['nom']!, _nomMeta));
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('prenom')) {
      context.handle(_prenomMeta,
          prenom.isAcceptableOrUnknown(data['prenom']!, _prenomMeta));
    } else if (isInserting) {
      context.missing(_prenomMeta);
    }
    if (data.containsKey('eleve_nom')) {
      context.handle(_eleve_nomMeta,
          eleve_nom.isAcceptableOrUnknown(data['eleve_nom']!, _eleve_nomMeta));
    } else if (isInserting) {
      context.missing(_eleve_nomMeta);
    }
    if (data.containsKey('id_classe')) {
      context.handle(_id_classeMeta,
          id_classe.isAcceptableOrUnknown(data['id_classe']!, _id_classeMeta));
    } else if (isInserting) {
      context.missing(_id_classeMeta);
    }
    if (data.containsKey('eleve_photo')) {
      context.handle(
          _eleve_photoMeta,
          eleve_photo.isAcceptableOrUnknown(
              data['eleve_photo']!, _eleve_photoMeta));
    }
    if (data.containsKey('id_eleve_recuperations')) {
      context.handle(
          _id_eleve_recuperationsMeta,
          id_eleve_recuperations.isAcceptableOrUnknown(
              data['id_eleve_recuperations']!, _id_eleve_recuperationsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id_personne};
  @override
  EleveEntitie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EleveEntitie(
      id_personne: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_personne'])!,
      nom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nom'])!,
      prenom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prenom'])!,
      eleve_nom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}eleve_nom'])!,
      id_classe: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_classe'])!,
      eleve_photo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}eleve_photo']),
      id_eleve_recuperations: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}id_eleve_recuperations']),
    );
  }

  @override
  $EleveEntitiesTable createAlias(String alias) {
    return $EleveEntitiesTable(attachedDatabase, alias);
  }
}

class EleveEntitie extends DataClass implements Insertable<EleveEntitie> {
  final int id_personne;
  final String nom;
  final String prenom;
  final String eleve_nom;
  final int id_classe;
  final String? eleve_photo;
  final int? id_eleve_recuperations;
  const EleveEntitie(
      {required this.id_personne,
      required this.nom,
      required this.prenom,
      required this.eleve_nom,
      required this.id_classe,
      this.eleve_photo,
      this.id_eleve_recuperations});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_personne'] = Variable<int>(id_personne);
    map['nom'] = Variable<String>(nom);
    map['prenom'] = Variable<String>(prenom);
    map['eleve_nom'] = Variable<String>(eleve_nom);
    map['id_classe'] = Variable<int>(id_classe);
    if (!nullToAbsent || eleve_photo != null) {
      map['eleve_photo'] = Variable<String>(eleve_photo);
    }
    if (!nullToAbsent || id_eleve_recuperations != null) {
      map['id_eleve_recuperations'] = Variable<int>(id_eleve_recuperations);
    }
    return map;
  }

  EleveEntitiesCompanion toCompanion(bool nullToAbsent) {
    return EleveEntitiesCompanion(
      id_personne: Value(id_personne),
      nom: Value(nom),
      prenom: Value(prenom),
      eleve_nom: Value(eleve_nom),
      id_classe: Value(id_classe),
      eleve_photo: eleve_photo == null && nullToAbsent
          ? const Value.absent()
          : Value(eleve_photo),
      id_eleve_recuperations: id_eleve_recuperations == null && nullToAbsent
          ? const Value.absent()
          : Value(id_eleve_recuperations),
    );
  }

  factory EleveEntitie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EleveEntitie(
      id_personne: serializer.fromJson<int>(json['id_personne']),
      nom: serializer.fromJson<String>(json['nom']),
      prenom: serializer.fromJson<String>(json['prenom']),
      eleve_nom: serializer.fromJson<String>(json['eleve_nom']),
      id_classe: serializer.fromJson<int>(json['id_classe']),
      eleve_photo: serializer.fromJson<String?>(json['eleve_photo']),
      id_eleve_recuperations:
          serializer.fromJson<int?>(json['id_eleve_recuperations']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id_personne': serializer.toJson<int>(id_personne),
      'nom': serializer.toJson<String>(nom),
      'prenom': serializer.toJson<String>(prenom),
      'eleve_nom': serializer.toJson<String>(eleve_nom),
      'id_classe': serializer.toJson<int>(id_classe),
      'eleve_photo': serializer.toJson<String?>(eleve_photo),
      'id_eleve_recuperations': serializer.toJson<int?>(id_eleve_recuperations),
    };
  }

  EleveEntitie copyWith(
          {int? id_personne,
          String? nom,
          String? prenom,
          String? eleve_nom,
          int? id_classe,
          Value<String?> eleve_photo = const Value.absent(),
          Value<int?> id_eleve_recuperations = const Value.absent()}) =>
      EleveEntitie(
        id_personne: id_personne ?? this.id_personne,
        nom: nom ?? this.nom,
        prenom: prenom ?? this.prenom,
        eleve_nom: eleve_nom ?? this.eleve_nom,
        id_classe: id_classe ?? this.id_classe,
        eleve_photo: eleve_photo.present ? eleve_photo.value : this.eleve_photo,
        id_eleve_recuperations: id_eleve_recuperations.present
            ? id_eleve_recuperations.value
            : this.id_eleve_recuperations,
      );
  EleveEntitie copyWithCompanion(EleveEntitiesCompanion data) {
    return EleveEntitie(
      id_personne:
          data.id_personne.present ? data.id_personne.value : this.id_personne,
      nom: data.nom.present ? data.nom.value : this.nom,
      prenom: data.prenom.present ? data.prenom.value : this.prenom,
      eleve_nom: data.eleve_nom.present ? data.eleve_nom.value : this.eleve_nom,
      id_classe: data.id_classe.present ? data.id_classe.value : this.id_classe,
      eleve_photo:
          data.eleve_photo.present ? data.eleve_photo.value : this.eleve_photo,
      id_eleve_recuperations: data.id_eleve_recuperations.present
          ? data.id_eleve_recuperations.value
          : this.id_eleve_recuperations,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EleveEntitie(')
          ..write('id_personne: $id_personne, ')
          ..write('nom: $nom, ')
          ..write('prenom: $prenom, ')
          ..write('eleve_nom: $eleve_nom, ')
          ..write('id_classe: $id_classe, ')
          ..write('eleve_photo: $eleve_photo, ')
          ..write('id_eleve_recuperations: $id_eleve_recuperations')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id_personne, nom, prenom, eleve_nom,
      id_classe, eleve_photo, id_eleve_recuperations);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EleveEntitie &&
          other.id_personne == this.id_personne &&
          other.nom == this.nom &&
          other.prenom == this.prenom &&
          other.eleve_nom == this.eleve_nom &&
          other.id_classe == this.id_classe &&
          other.eleve_photo == this.eleve_photo &&
          other.id_eleve_recuperations == this.id_eleve_recuperations);
}

class EleveEntitiesCompanion extends UpdateCompanion<EleveEntitie> {
  final Value<int> id_personne;
  final Value<String> nom;
  final Value<String> prenom;
  final Value<String> eleve_nom;
  final Value<int> id_classe;
  final Value<String?> eleve_photo;
  final Value<int?> id_eleve_recuperations;
  const EleveEntitiesCompanion({
    this.id_personne = const Value.absent(),
    this.nom = const Value.absent(),
    this.prenom = const Value.absent(),
    this.eleve_nom = const Value.absent(),
    this.id_classe = const Value.absent(),
    this.eleve_photo = const Value.absent(),
    this.id_eleve_recuperations = const Value.absent(),
  });
  EleveEntitiesCompanion.insert({
    this.id_personne = const Value.absent(),
    required String nom,
    required String prenom,
    required String eleve_nom,
    required int id_classe,
    this.eleve_photo = const Value.absent(),
    this.id_eleve_recuperations = const Value.absent(),
  })  : nom = Value(nom),
        prenom = Value(prenom),
        eleve_nom = Value(eleve_nom),
        id_classe = Value(id_classe);
  static Insertable<EleveEntitie> custom({
    Expression<int>? id_personne,
    Expression<String>? nom,
    Expression<String>? prenom,
    Expression<String>? eleve_nom,
    Expression<int>? id_classe,
    Expression<String>? eleve_photo,
    Expression<int>? id_eleve_recuperations,
  }) {
    return RawValuesInsertable({
      if (id_personne != null) 'id_personne': id_personne,
      if (nom != null) 'nom': nom,
      if (prenom != null) 'prenom': prenom,
      if (eleve_nom != null) 'eleve_nom': eleve_nom,
      if (id_classe != null) 'id_classe': id_classe,
      if (eleve_photo != null) 'eleve_photo': eleve_photo,
      if (id_eleve_recuperations != null)
        'id_eleve_recuperations': id_eleve_recuperations,
    });
  }

  EleveEntitiesCompanion copyWith(
      {Value<int>? id_personne,
      Value<String>? nom,
      Value<String>? prenom,
      Value<String>? eleve_nom,
      Value<int>? id_classe,
      Value<String?>? eleve_photo,
      Value<int?>? id_eleve_recuperations}) {
    return EleveEntitiesCompanion(
      id_personne: id_personne ?? this.id_personne,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      eleve_nom: eleve_nom ?? this.eleve_nom,
      id_classe: id_classe ?? this.id_classe,
      eleve_photo: eleve_photo ?? this.eleve_photo,
      id_eleve_recuperations:
          id_eleve_recuperations ?? this.id_eleve_recuperations,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id_personne.present) {
      map['id_personne'] = Variable<int>(id_personne.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (prenom.present) {
      map['prenom'] = Variable<String>(prenom.value);
    }
    if (eleve_nom.present) {
      map['eleve_nom'] = Variable<String>(eleve_nom.value);
    }
    if (id_classe.present) {
      map['id_classe'] = Variable<int>(id_classe.value);
    }
    if (eleve_photo.present) {
      map['eleve_photo'] = Variable<String>(eleve_photo.value);
    }
    if (id_eleve_recuperations.present) {
      map['id_eleve_recuperations'] =
          Variable<int>(id_eleve_recuperations.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EleveEntitiesCompanion(')
          ..write('id_personne: $id_personne, ')
          ..write('nom: $nom, ')
          ..write('prenom: $prenom, ')
          ..write('eleve_nom: $eleve_nom, ')
          ..write('id_classe: $id_classe, ')
          ..write('eleve_photo: $eleve_photo, ')
          ..write('id_eleve_recuperations: $id_eleve_recuperations')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DemandesRecuperationsTable demandesRecuperations =
      $DemandesRecuperationsTable(this);
  late final $ClassEntitiesTable classEntities = $ClassEntitiesTable(this);
  late final $EleveEntitiesTable eleveEntities = $EleveEntitiesTable(this);
  late final DemandesRecuperationsDao demandesRecuperationsDao =
      DemandesRecuperationsDao(this as AppDatabase);
  late final ClassEntitiesDao classEntitiesDao =
      ClassEntitiesDao(this as AppDatabase);
  late final EleveEntitiesDao eleveEntitiesDao =
      EleveEntitiesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [demandesRecuperations, classEntities, eleveEntities];
}

typedef $$DemandesRecuperationsTableCreateCompanionBuilder
    = DemandesRecuperationsCompanion Function({
  Value<int> id_eleve_recuperations,
  required int id_classe,
  required String parent_nom,
  required String eleve_nom,
  required String eleve_photo,
  Value<DateTime?> date_de_la_demande,
});
typedef $$DemandesRecuperationsTableUpdateCompanionBuilder
    = DemandesRecuperationsCompanion Function({
  Value<int> id_eleve_recuperations,
  Value<int> id_classe,
  Value<String> parent_nom,
  Value<String> eleve_nom,
  Value<String> eleve_photo,
  Value<DateTime?> date_de_la_demande,
});

class $$DemandesRecuperationsTableFilterComposer
    extends Composer<_$AppDatabase, $DemandesRecuperationsTable> {
  $$DemandesRecuperationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id_eleve_recuperations => $composableBuilder(
      column: $table.id_eleve_recuperations,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get id_classe => $composableBuilder(
      column: $table.id_classe, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parent_nom => $composableBuilder(
      column: $table.parent_nom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eleve_nom => $composableBuilder(
      column: $table.eleve_nom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eleve_photo => $composableBuilder(
      column: $table.eleve_photo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date_de_la_demande => $composableBuilder(
      column: $table.date_de_la_demande,
      builder: (column) => ColumnFilters(column));
}

class $$DemandesRecuperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $DemandesRecuperationsTable> {
  $$DemandesRecuperationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id_eleve_recuperations => $composableBuilder(
      column: $table.id_eleve_recuperations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get id_classe => $composableBuilder(
      column: $table.id_classe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parent_nom => $composableBuilder(
      column: $table.parent_nom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eleve_nom => $composableBuilder(
      column: $table.eleve_nom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eleve_photo => $composableBuilder(
      column: $table.eleve_photo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date_de_la_demande => $composableBuilder(
      column: $table.date_de_la_demande,
      builder: (column) => ColumnOrderings(column));
}

class $$DemandesRecuperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DemandesRecuperationsTable> {
  $$DemandesRecuperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id_eleve_recuperations => $composableBuilder(
      column: $table.id_eleve_recuperations, builder: (column) => column);

  GeneratedColumn<int> get id_classe =>
      $composableBuilder(column: $table.id_classe, builder: (column) => column);

  GeneratedColumn<String> get parent_nom => $composableBuilder(
      column: $table.parent_nom, builder: (column) => column);

  GeneratedColumn<String> get eleve_nom =>
      $composableBuilder(column: $table.eleve_nom, builder: (column) => column);

  GeneratedColumn<String> get eleve_photo => $composableBuilder(
      column: $table.eleve_photo, builder: (column) => column);

  GeneratedColumn<DateTime> get date_de_la_demande => $composableBuilder(
      column: $table.date_de_la_demande, builder: (column) => column);
}

class $$DemandesRecuperationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DemandesRecuperationsTable,
    DemandesRecuperation,
    $$DemandesRecuperationsTableFilterComposer,
    $$DemandesRecuperationsTableOrderingComposer,
    $$DemandesRecuperationsTableAnnotationComposer,
    $$DemandesRecuperationsTableCreateCompanionBuilder,
    $$DemandesRecuperationsTableUpdateCompanionBuilder,
    (
      DemandesRecuperation,
      BaseReferences<_$AppDatabase, $DemandesRecuperationsTable,
          DemandesRecuperation>
    ),
    DemandesRecuperation,
    PrefetchHooks Function()> {
  $$DemandesRecuperationsTableTableManager(
      _$AppDatabase db, $DemandesRecuperationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DemandesRecuperationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DemandesRecuperationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DemandesRecuperationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id_eleve_recuperations = const Value.absent(),
            Value<int> id_classe = const Value.absent(),
            Value<String> parent_nom = const Value.absent(),
            Value<String> eleve_nom = const Value.absent(),
            Value<String> eleve_photo = const Value.absent(),
            Value<DateTime?> date_de_la_demande = const Value.absent(),
          }) =>
              DemandesRecuperationsCompanion(
            id_eleve_recuperations: id_eleve_recuperations,
            id_classe: id_classe,
            parent_nom: parent_nom,
            eleve_nom: eleve_nom,
            eleve_photo: eleve_photo,
            date_de_la_demande: date_de_la_demande,
          ),
          createCompanionCallback: ({
            Value<int> id_eleve_recuperations = const Value.absent(),
            required int id_classe,
            required String parent_nom,
            required String eleve_nom,
            required String eleve_photo,
            Value<DateTime?> date_de_la_demande = const Value.absent(),
          }) =>
              DemandesRecuperationsCompanion.insert(
            id_eleve_recuperations: id_eleve_recuperations,
            id_classe: id_classe,
            parent_nom: parent_nom,
            eleve_nom: eleve_nom,
            eleve_photo: eleve_photo,
            date_de_la_demande: date_de_la_demande,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DemandesRecuperationsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DemandesRecuperationsTable,
        DemandesRecuperation,
        $$DemandesRecuperationsTableFilterComposer,
        $$DemandesRecuperationsTableOrderingComposer,
        $$DemandesRecuperationsTableAnnotationComposer,
        $$DemandesRecuperationsTableCreateCompanionBuilder,
        $$DemandesRecuperationsTableUpdateCompanionBuilder,
        (
          DemandesRecuperation,
          BaseReferences<_$AppDatabase, $DemandesRecuperationsTable,
              DemandesRecuperation>
        ),
        DemandesRecuperation,
        PrefetchHooks Function()>;
typedef $$ClassEntitiesTableCreateCompanionBuilder = ClassEntitiesCompanion
    Function({
  Value<int> id_classe,
  required String classe_description,
  required int id_niveau,
  required String niveau,
  Value<int> nbrnotification,
  Value<String?> Responsable,
});
typedef $$ClassEntitiesTableUpdateCompanionBuilder = ClassEntitiesCompanion
    Function({
  Value<int> id_classe,
  Value<String> classe_description,
  Value<int> id_niveau,
  Value<String> niveau,
  Value<int> nbrnotification,
  Value<String?> Responsable,
});

class $$ClassEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ClassEntitiesTable> {
  $$ClassEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id_classe => $composableBuilder(
      column: $table.id_classe, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get classe_description => $composableBuilder(
      column: $table.classe_description,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get id_niveau => $composableBuilder(
      column: $table.id_niveau, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get niveau => $composableBuilder(
      column: $table.niveau, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nbrnotification => $composableBuilder(
      column: $table.nbrnotification,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get Responsable => $composableBuilder(
      column: $table.Responsable, builder: (column) => ColumnFilters(column));
}

class $$ClassEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassEntitiesTable> {
  $$ClassEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id_classe => $composableBuilder(
      column: $table.id_classe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get classe_description => $composableBuilder(
      column: $table.classe_description,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get id_niveau => $composableBuilder(
      column: $table.id_niveau, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get niveau => $composableBuilder(
      column: $table.niveau, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nbrnotification => $composableBuilder(
      column: $table.nbrnotification,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get Responsable => $composableBuilder(
      column: $table.Responsable, builder: (column) => ColumnOrderings(column));
}

class $$ClassEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassEntitiesTable> {
  $$ClassEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id_classe =>
      $composableBuilder(column: $table.id_classe, builder: (column) => column);

  GeneratedColumn<String> get classe_description => $composableBuilder(
      column: $table.classe_description, builder: (column) => column);

  GeneratedColumn<int> get id_niveau =>
      $composableBuilder(column: $table.id_niveau, builder: (column) => column);

  GeneratedColumn<String> get niveau =>
      $composableBuilder(column: $table.niveau, builder: (column) => column);

  GeneratedColumn<int> get nbrnotification => $composableBuilder(
      column: $table.nbrnotification, builder: (column) => column);

  GeneratedColumn<String> get Responsable => $composableBuilder(
      column: $table.Responsable, builder: (column) => column);
}

class $$ClassEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClassEntitiesTable,
    ClassEntitie,
    $$ClassEntitiesTableFilterComposer,
    $$ClassEntitiesTableOrderingComposer,
    $$ClassEntitiesTableAnnotationComposer,
    $$ClassEntitiesTableCreateCompanionBuilder,
    $$ClassEntitiesTableUpdateCompanionBuilder,
    (
      ClassEntitie,
      BaseReferences<_$AppDatabase, $ClassEntitiesTable, ClassEntitie>
    ),
    ClassEntitie,
    PrefetchHooks Function()> {
  $$ClassEntitiesTableTableManager(_$AppDatabase db, $ClassEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id_classe = const Value.absent(),
            Value<String> classe_description = const Value.absent(),
            Value<int> id_niveau = const Value.absent(),
            Value<String> niveau = const Value.absent(),
            Value<int> nbrnotification = const Value.absent(),
            Value<String?> Responsable = const Value.absent(),
          }) =>
              ClassEntitiesCompanion(
            id_classe: id_classe,
            classe_description: classe_description,
            id_niveau: id_niveau,
            niveau: niveau,
            nbrnotification: nbrnotification,
            Responsable: Responsable,
          ),
          createCompanionCallback: ({
            Value<int> id_classe = const Value.absent(),
            required String classe_description,
            required int id_niveau,
            required String niveau,
            Value<int> nbrnotification = const Value.absent(),
            Value<String?> Responsable = const Value.absent(),
          }) =>
              ClassEntitiesCompanion.insert(
            id_classe: id_classe,
            classe_description: classe_description,
            id_niveau: id_niveau,
            niveau: niveau,
            nbrnotification: nbrnotification,
            Responsable: Responsable,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClassEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClassEntitiesTable,
    ClassEntitie,
    $$ClassEntitiesTableFilterComposer,
    $$ClassEntitiesTableOrderingComposer,
    $$ClassEntitiesTableAnnotationComposer,
    $$ClassEntitiesTableCreateCompanionBuilder,
    $$ClassEntitiesTableUpdateCompanionBuilder,
    (
      ClassEntitie,
      BaseReferences<_$AppDatabase, $ClassEntitiesTable, ClassEntitie>
    ),
    ClassEntitie,
    PrefetchHooks Function()>;
typedef $$EleveEntitiesTableCreateCompanionBuilder = EleveEntitiesCompanion
    Function({
  Value<int> id_personne,
  required String nom,
  required String prenom,
  required String eleve_nom,
  required int id_classe,
  Value<String?> eleve_photo,
  Value<int?> id_eleve_recuperations,
});
typedef $$EleveEntitiesTableUpdateCompanionBuilder = EleveEntitiesCompanion
    Function({
  Value<int> id_personne,
  Value<String> nom,
  Value<String> prenom,
  Value<String> eleve_nom,
  Value<int> id_classe,
  Value<String?> eleve_photo,
  Value<int?> id_eleve_recuperations,
});

class $$EleveEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $EleveEntitiesTable> {
  $$EleveEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id_personne => $composableBuilder(
      column: $table.id_personne, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nom => $composableBuilder(
      column: $table.nom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prenom => $composableBuilder(
      column: $table.prenom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eleve_nom => $composableBuilder(
      column: $table.eleve_nom, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get id_classe => $composableBuilder(
      column: $table.id_classe, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eleve_photo => $composableBuilder(
      column: $table.eleve_photo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get id_eleve_recuperations => $composableBuilder(
      column: $table.id_eleve_recuperations,
      builder: (column) => ColumnFilters(column));
}

class $$EleveEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $EleveEntitiesTable> {
  $$EleveEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id_personne => $composableBuilder(
      column: $table.id_personne, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nom => $composableBuilder(
      column: $table.nom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prenom => $composableBuilder(
      column: $table.prenom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eleve_nom => $composableBuilder(
      column: $table.eleve_nom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get id_classe => $composableBuilder(
      column: $table.id_classe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eleve_photo => $composableBuilder(
      column: $table.eleve_photo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get id_eleve_recuperations => $composableBuilder(
      column: $table.id_eleve_recuperations,
      builder: (column) => ColumnOrderings(column));
}

class $$EleveEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EleveEntitiesTable> {
  $$EleveEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id_personne => $composableBuilder(
      column: $table.id_personne, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get prenom =>
      $composableBuilder(column: $table.prenom, builder: (column) => column);

  GeneratedColumn<String> get eleve_nom =>
      $composableBuilder(column: $table.eleve_nom, builder: (column) => column);

  GeneratedColumn<int> get id_classe =>
      $composableBuilder(column: $table.id_classe, builder: (column) => column);

  GeneratedColumn<String> get eleve_photo => $composableBuilder(
      column: $table.eleve_photo, builder: (column) => column);

  GeneratedColumn<int> get id_eleve_recuperations => $composableBuilder(
      column: $table.id_eleve_recuperations, builder: (column) => column);
}

class $$EleveEntitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EleveEntitiesTable,
    EleveEntitie,
    $$EleveEntitiesTableFilterComposer,
    $$EleveEntitiesTableOrderingComposer,
    $$EleveEntitiesTableAnnotationComposer,
    $$EleveEntitiesTableCreateCompanionBuilder,
    $$EleveEntitiesTableUpdateCompanionBuilder,
    (
      EleveEntitie,
      BaseReferences<_$AppDatabase, $EleveEntitiesTable, EleveEntitie>
    ),
    EleveEntitie,
    PrefetchHooks Function()> {
  $$EleveEntitiesTableTableManager(_$AppDatabase db, $EleveEntitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EleveEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EleveEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EleveEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id_personne = const Value.absent(),
            Value<String> nom = const Value.absent(),
            Value<String> prenom = const Value.absent(),
            Value<String> eleve_nom = const Value.absent(),
            Value<int> id_classe = const Value.absent(),
            Value<String?> eleve_photo = const Value.absent(),
            Value<int?> id_eleve_recuperations = const Value.absent(),
          }) =>
              EleveEntitiesCompanion(
            id_personne: id_personne,
            nom: nom,
            prenom: prenom,
            eleve_nom: eleve_nom,
            id_classe: id_classe,
            eleve_photo: eleve_photo,
            id_eleve_recuperations: id_eleve_recuperations,
          ),
          createCompanionCallback: ({
            Value<int> id_personne = const Value.absent(),
            required String nom,
            required String prenom,
            required String eleve_nom,
            required int id_classe,
            Value<String?> eleve_photo = const Value.absent(),
            Value<int?> id_eleve_recuperations = const Value.absent(),
          }) =>
              EleveEntitiesCompanion.insert(
            id_personne: id_personne,
            nom: nom,
            prenom: prenom,
            eleve_nom: eleve_nom,
            id_classe: id_classe,
            eleve_photo: eleve_photo,
            id_eleve_recuperations: id_eleve_recuperations,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EleveEntitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EleveEntitiesTable,
    EleveEntitie,
    $$EleveEntitiesTableFilterComposer,
    $$EleveEntitiesTableOrderingComposer,
    $$EleveEntitiesTableAnnotationComposer,
    $$EleveEntitiesTableCreateCompanionBuilder,
    $$EleveEntitiesTableUpdateCompanionBuilder,
    (
      EleveEntitie,
      BaseReferences<_$AppDatabase, $EleveEntitiesTable, EleveEntitie>
    ),
    EleveEntitie,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DemandesRecuperationsTableTableManager get demandesRecuperations =>
      $$DemandesRecuperationsTableTableManager(_db, _db.demandesRecuperations);
  $$ClassEntitiesTableTableManager get classEntities =>
      $$ClassEntitiesTableTableManager(_db, _db.classEntities);
  $$EleveEntitiesTableTableManager get eleveEntities =>
      $$EleveEntitiesTableTableManager(_db, _db.eleveEntities);
}
