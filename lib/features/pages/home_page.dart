import 'package:myinoface/features/demande_recuperation/presentation/pages/demande_recuperation_page.dart';
import 'package:myinoface/features/all_classes/presentation/pages/all_classes_page.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:myinoface/features/gardes/presentation/pages/garde_page.dart';
import 'package:myinoface/core/usecases/firebase_notifications.dart';
import 'package:myinoface/core/usecases/preference_utils.dart';
import 'package:myinoface/core/ui/responsive_safe_area.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/mobx/mobx_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:after_layout/after_layout.dart';
import 'package:myinoface/core/util/keys.dart';
import 'package:myinoface/core/util/img.dart';
import 'package:badges/badges.dart' as badge;
// import 'package:wakelock/wakelock.dart';//! TODO: By Mazen
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../../main.dart';
import 'dart:async';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage>,
        TickerProviderStateMixin, WidgetsBindingObserver {

  final PageController _pageController = PageController();
  final MobxApp _mobx = MobxApp();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _askForPermissions();
    });
    super.initState();
  }

  Future<void> _askForPermissions() async {
    await [
      Permission.notification,
      Permission.camera,
    ].request();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    FirebaseNotifications.messagingListeners(context);
    // Wakelock.enable();//! TODO: By Mazen
  }


  Future<bool> _onWillPop(BuildContext context) async {
    if (_mobx.currentIndex != 0) {
      _mobx.onPageChanged(0);
      _pageController.jumpToPage(0);
      return Future.value(false);
    } else {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.pink,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Image.asset(IMG.logo,
                    height: 25, width: 25,
                    // color: Colors.pink,
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text("myinoface".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ),
          content: Text('exit_app'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('non'.tr),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('yes'.tr),
            ),
          ],
        ),
      ) ?? false;
      return result;
    }
  }

  @override
  void dispose() {
    // Wakelock.disable();//! TODO: By Mazen
    // _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return ResponsiveSafeArea(
      builder: (_) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final shouldPop = await _onWillPop(context);
          if (shouldPop && context.mounted) {
            SystemNavigator.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('choose_class'.tr,
              style: GoogleFonts.aBeeZee(),
            ),
            actions: [
              if (PreferenceUtils.getBool(Keys.accesRecuperation))
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => Get.to(() => AllClassesPage()),
                ),

              IconButton(
                tooltip: 'log_out'.tr,
                icon: Icon(MdiIcons.logout),
                onPressed: () => appUtils.logoutDialog(context),
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => Get.to(() => const GardesPage()),
            ),
          ),
          backgroundColor: Colors.grey.shade50,
          body: Stack(
            children: [
              Lottie.asset(
                'assets/jsons/81517-ios-timer-background.json',
                width: Get.width,
                height: Get.height,
                fit: BoxFit.fill,
              ),
              Positioned.fill(
                // alignment: Alignment.topCenter,
                child: FutureBuilder<List<ClassEntitie>>(
                  future: db.classEntitiesDao.getAllClassEntities(),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        final entites = snapshot.data ?? [];
                        if (entites.isNotEmpty) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              await appUtils.getAllClasses();
                              setState(() {});
                            },
                            child: GridView.builder(
                              // shrinkWrap: true,
                              padding: const EdgeInsets.all(16),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (Get.width > 400) ? 3 : 2),
                              itemCount: entites.length,
                              itemBuilder: (context, index) {
                                final model = entites[index];
                                return Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        // color: appUtils.checkResponsableColor(model),
                                        color: Colors.pink,
                                        // border: Border.all(color: Colors.white),
                                        border: Border.all(color: appUtils.checkResponsableColor(model), width: 2),
                                        borderRadius: const BorderRadius.all(
                                           Radius.circular(100.0) //                 <--- border radius here
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          await Get.to(() => DemandeRecuperationPage(classEntitie: model));
                                          setState(() {});
                                        },
                                        child: LayoutBuilder(
                                          builder: (BuildContext ctx, BoxConstraints constraints) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                StreamBuilder<ClassEntitie>(
                                                    stream: db.classEntitiesDao.watchClassEntitieById(model.id_classe),
                                                    builder: (context, snapNotify) {
                                                      switch(snapNotify.connectionState) {
                                                        case ConnectionState.waiting:
                                                          return Image.asset(
                                                            IMG.classes,
                                                            color: Colors.white,
                                                            height: 30,
                                                            width: 30,
                                                          );
                                                        default:
                                                          final entity = snapNotify.data;
                                                          final hasNotify = entity != null && entity.nbrnotification > 0;
                                                          if (hasNotify) {
                                                            return badge.Badge(
                                                              badgeContent: Text("${entity!.nbrnotification}",
                                                                style: const TextStyle(
                                                                  color: Colors.pink,
                                                                ),
                                                              ),
                                                              //! TODO: By Mazen
                                                              // badgeColor: Colors.white,
                                                              child: Image.asset(IMG.classes,
                                                                height: 38, width: 38,
                                                                color: Colors.white,
                                                              ),
                                                            );
                                                          } else {
                                                            return Image.asset(
                                                              IMG.classes,
                                                              height: 38, width: 38,
                                                              color: Colors.white,
                                                            );
                                                          }
                                                      }
                                                    }
                                                ),

                                                Text(model.classe_description,
                                                  style: GoogleFonts.acme(
                                                    color: Colors.white,
                                                    fontSize: constraints.maxWidth/9,
                                                  ),
                                                ),
                                                Text('${model.niveau}${appUtils.checkResponsable(model)}'??'',
                                                  style: GoogleFonts.acme(
                                                    color: Colors.white,
                                                    fontSize: constraints.maxWidth/11,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Lottie.asset(
                                IMG.jsonEmpty,
                              ),
                            ),
                            // child: Image.asset(IMG.empty),
                          );
                        }
                    }
                  },
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}