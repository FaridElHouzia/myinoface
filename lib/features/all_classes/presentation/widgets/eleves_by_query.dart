import 'package:cached_network_image/cached_network_image.dart';
import 'package:myinoface/features/all_classes/data/models/eleves_by_query_model.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myinoface/core/util/img.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class ElevesByQuery extends StatelessWidget {
  final String query;
  const ElevesByQuery({required this.query, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text('eleves'.tr,
          style: GoogleFonts.acme(),
        ),
      ),
      body: FutureBuilder<ElevesByQueryModel>(
        future: appUtils.getElevesByQuery(query),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting: return const Center(
              child: CircularProgressIndicator(),
            );
            default:
              if (snapshot.hasData && snapshot.data != null && !snapshot.data!.error) {
                return ListView.builder(
                  itemCount: snapshot.data!.eleves.length,
                  itemBuilder: (context, index) {
                    final eleve = snapshot.data!.eleves[index];
                    return Card(
                      child: ListTile(
                        onTap: () => appUtils.confirmDemandeRecuperation(context, eleve),
                        title: Text('${eleve.prenom} ${eleve.nom}',
                          style: GoogleFonts.acme(),
                        ),
                        leading: (eleve.elevePhoto != null) ?
                        CachedNetworkImage(
                          imageUrl: UrlService.rewriteInoserUri(eleve.elevePhoto??''),
                          width: 50, height: 50,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Image.asset(IMG.defaultProfile,
                            width: 50, height: 50,
                          ),
                        ) : Image.asset(IMG.defaultProfile,
                          width: 50, height: 50,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              child: const Text('CIN'),
                              onPressed: () async {
                                final parent = await utilsLogic.getParentsByid(
                                  context, eleve.idPersonne ?? 0
                                );
                                if (parent != null && context.mounted) {
                                  await utilsLogic.getParentCinByid(
                                    context, parent,
                                  );
                                }
                              },
                            ),
                            Icon(MdiIcons.carHatchback,
                              size: 35,
                            ),
                          ],
                        )
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Image.asset(IMG.empty),
                );
              }
          }
        },
      ),
    );
  }
}
