import 'package:intl/intl.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:myinoface/features/gardes/data/models/personne_gardes_model.dart';
import 'package:flutter/material.dart';



class LoadedGardeWidget extends StatelessWidget {
  final PersonneGardesModel model;
  const LoadedGardeWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model.gardes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(DateFormat('dd MMM yyyy').format(model.gardes.first.dateGarde),
                style: const TextStyle(
                  fontSize: 22
                ),
              ),
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: model.gardes.map((garde) {
              return ListTile(
                  leading: Icon(MdiIcons.clockOutline),
                  title: Text(garde.gardeDescription),
                  subtitle: Row(
                    children: [
                      Text(garde.minHeure),
                      const SizedBox(width: 16,),
                      Text(garde.maxHeure),
                    ],
                  )
              );
            }).toList(),
          ),
        ],
      )
    );
  }
}
