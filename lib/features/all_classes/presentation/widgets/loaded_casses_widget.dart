import 'package:myinoface/features/all_classes/data/models/eleve_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'demandes_recuperation.dart';
import 'eleve_recuperation.dart';
import 'package:get/get.dart';



class LoadedClassesWidget extends StatelessWidget {
  final EleveModel model;
  const LoadedClassesWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(model.classe_description??'',
            style: GoogleFonts.acme(),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'eleves_recuperation'.tr),
              Tab(text: 'demandes_recuperation'.tr),
            ],
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          children: [
            EleveRecuperation(idClass: model.id_classe),
            DemandesRecuperation(idClass: model.id_classe),
          ],
        ),
      ),
    );
  }
}
