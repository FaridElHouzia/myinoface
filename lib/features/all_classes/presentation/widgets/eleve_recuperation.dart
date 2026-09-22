import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myinoface/core/util/img.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



class EleveRecuperation extends StatelessWidget {
  final int idClass;
  const EleveRecuperation({required this.idClass, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return Scaffold(
      body: StreamBuilder<List<EleveEntitie>>(
        stream: db.eleveEntitiesDao.watchEleveRecuperationsIsNull(idClass),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting: return const Center(
              child: CircularProgressIndicator(),
            );
            default:
              final eleves = snapshot.data??[];
              if (eleves.isNotEmpty) {
                return ListView.builder(
                  itemCount: eleves.length??0,
                  itemBuilder: (context, index) {
                    final eleve = eleves[index];
                    if (eleve.id_eleve_recuperations == null) {
                      return Card(
                        child: ListTile(
                          onTap: () => appUtils.confirmDemandeRecuperation(context, eleve),
                          title: Text(eleve.prenom+' '+eleve.nom,
                            style: GoogleFonts.acme(),
                          ),
                          leading: (eleve.eleve_photo != null) ?
                          CachedNetworkImage(
                            imageUrl: UrlService.rewriteInoserUri(eleve.eleve_photo??''),
                            width: 50, height: 50,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Image.asset(IMG.defaultProfile,
                              width: 50, height: 50,
                            ),
                          ) : Image.asset(IMG.defaultProfile,
                            width: 50, height: 50,
                          ),
                          trailing: Icon(MdiIcons.carHatchback,
                            size: 35,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
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

