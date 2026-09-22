import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/usecases/constants.dart';
import '../../../../core/notifier/model_notifier.dart';
import 'package:myinoface/core/mobx/mobx_app.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:after_layout/after_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myinoface/core/util/img.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'dart:async';



class LoadedDemandeRecuperationWidget extends StatefulWidget {
  final ClassEntitie classEntitie;
  final DemandeRecuperationModel model;
  const LoadedDemandeRecuperationWidget({Key? key, required this.model, required this.classEntitie}) : super(key: key);

  @override
  _LoadedDemandeRecuperationWidgetState createState() => _LoadedDemandeRecuperationWidgetState();
}

class _LoadedDemandeRecuperationWidgetState extends State<LoadedDemandeRecuperationWidget>
    with AfterLayoutMixin<LoadedDemandeRecuperationWidget> {

  final MobxApp _mobxApp = MobxApp();
  Timer? _timer;
  int i = 0;


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notify = context.read<ModelNotifier>();
    final db = Provider.of<AppDatabase>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: InkWell(
            onTap: () => appUtils.showDemandeTitle(context, notify.demandeRecuperationModel??widget.model),
            child: Text(appUtils.checkTitre(notify.demandeRecuperationModel??widget.model),
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.acme(),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await appUtils.showAllClasse(context, widget.classEntitie);
              },
            ),
            Observer(
              builder: (_) {
                if (_mobxApp.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(
                        valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return IconButton(
                    icon: Icon(MdiIcons.refresh),
                    onPressed: () async {
                      _mobxApp.setLoadingState(true);
                      await appUtils.checkDemandeRecuperation(
                        context: context,
                        idClass: widget.classEntitie.id_classe,
                      );
                      if (mounted) _mobxApp.setLoadingState(false);
                    },
                  );
                }
              },
            ),
          ],
        ),
        body: StreamBuilder<List<DemandesRecuperation>>(
          stream: db.demandesRecuperationsDao.watchDemandesRecuperationByIdClass(widget.classEntitie.id_classe),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.waiting: return const Center(
                child: CircularProgressIndicator(),
              );
              default:
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  final demandes = snapshot.data!;
                  return ListView.builder(
                    itemCount: demandes.length,
                    itemBuilder: (context, index) {
                      final demande = demandes[index];
                      return Card(
                        child: ListTile(
                          onTap: () => appUtils.confirmRequest(context, demande),
                          title: Text(demande.parent_nom,
                            style: GoogleFonts.acme(),
                          ),
                          subtitle: Text(demande.eleve_nom,
                            style: GoogleFonts.acme(),
                          ),
                          leading: (demande.eleve_photo != null) ?
                          CachedNetworkImage(
                            imageUrl: UrlService.rewriteInoserUri(demande.eleve_photo),
                            width: 50, height: 50,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Image.asset(IMG.defaultProfile,
                              width: 50, height: 50,
                            ),
                          ) : Image.asset(
                            IMG.defaultProfile,
                            width: 50, height: 50,
                          ),
                          trailing: Icon(
                            MdiIcons.carHatchback,
                            size: 35,
                          ),
                        ),
                      );
                    },
                  );
                } else {//lf30_editor_22fkb0ee
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Lottie.asset(
                        'assets/jsons/lf30_editor_22fkb0ee.json',
                      ),
                    ),
                    // child: Image.asset(IMG.empty),
                  );
                }
            }
          },
        ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    interval(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      i++;
      if (i > widget.model.timeCounter) {
        i = 0;
        appUtils.checkDemandeRecuperation(
          context: context,
          idClass: widget.classEntitie.id_classe,
        );
      }
    });
  }

  Timer interval(Duration duration, func) {
    Timer function() {
      _timer = Timer(duration, function);
      func(_timer);
      return _timer!;
    }
    return Timer(duration, function);
  }
}
