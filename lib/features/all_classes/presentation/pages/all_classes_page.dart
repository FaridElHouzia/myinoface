import 'package:myinoface/features/all_classes/presentation/widgets/initial_classes_widget.dart';
import 'package:myinoface/features/all_classes/presentation/widgets/eleves_by_query.dart';
import 'package:myinoface/features/all_classes/presentation/widgets/search_eleve.dart';
import 'package:myinoface/core/ui/responsive_safe_area.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myinoface/core/util/img.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';



class AllClassesPage extends StatelessWidget {
  const AllClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return ResponsiveSafeArea(
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          title: Text('all_classes'.tr,
            style: GoogleFonts.acme(),
          ),
          actions: [
            IconButton(
              tooltip: 'log_out'.tr,
              icon: const Icon(Icons.search),
              onPressed: () async {
                final result = await showSearch(
                  context: context,
                  // query: _address1Controller.text.trim(),
                  delegate: SearchEleve(),
                );
                if (result != null && result.isNotEmpty) {
                  Get.to(() => ElevesByQuery(query: result));
                }
              }
            ),
          ],
        ),
        body: Stack(
          children: [
            Lottie.asset(
                'assets/jsons/81517-ios-timer-background.json',
                width: Get.width, height: Get.height,
                fit: BoxFit.fill
            ),
            Align(
              alignment: Alignment.topCenter,
              child: FutureBuilder<List<ClassEntitie>>(
                future: db.classEntitiesDao.getAllClassEntities(),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            await appUtils.getAllClasses();
                          },
                          child: GridView.builder(
                            // child: ListView.builder(
                            //   crossAxisCount: 2 ,
                            padding: const EdgeInsets.all(16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: (Get.width > 400) ? 3 : 2),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final model = snapshot.data![index];
                              return Container(
                                margin: const EdgeInsets.all(16),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                  child: Container(
                                    padding: const EdgeInsets.all(0),
                                    margin: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.pink),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100.0) //                 <--- border radius here
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: () => Get.to(() => InitialClassesWidget(model: model)),
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
                                                            color: Colors.pink,
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
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              //! TODO: By Mazen
                                                              // badgeColor: Colors.pink,
                                                              child: Image.asset(IMG.classes,
                                                                height: 30, width: 30,
                                                                color: Colors.pink,
                                                              ),
                                                            );
                                                          } else {
                                                            return Image.asset(
                                                              IMG.classes,
                                                              height: 30, width: 30,
                                                              color: Colors.pink,
                                                            );
                                                          }
                                                      }
                                                    }
                                                ),

                                                Text(model.classe_description,
                                                  style: GoogleFonts.acme(
                                                    color: Colors.pink,
                                                    fontSize: constraints.maxWidth/9,
                                                  ),
                                                ),
                                                Text(model.niveau,
                                                  style: GoogleFonts.acme(
                                                    color: Colors.pink,
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
                              'assets/jsons/lf30_editor_22fkb0ee.json',
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
        ),
        /*
        body: FutureBuilder<List<ClassEntitie>>(
          future: db.classEntitiesDao.getAllClassEntities(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.data.isNotEmpty) {
                  return SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    header: const MaterialClassicHeader(
                      color: Colors.pink,
                    ),
                    onRefresh: () async {
                      await appUtils.getAllClasses();
                      return _refreshController.refreshCompleted();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final model = snapshot.data[index];
                        // final hasNotify = (model.nbrnotification > 0)??false;
                        return Card(
                          child: ListTile(
                            onTap: () => Get.to(() => InitialClassesWidget(model: model)),
                            title: Text(model.classe_description,
                              style: GoogleFonts.acme(),
                            ),
                            leading: SizedBox(
                              height: 25, width: 25,
                              child: StreamBuilder<ClassEntitie>(
                                  stream: db.classEntitiesDao.watchClassEntitieById(model.id_classe),
                                  builder: (context, snapNotify) {
                                    switch(snapNotify.connectionState) {
                                      case ConnectionState.waiting:
                                        return Image.asset(
                                          IMG.classes,
                                          height: 25,
                                          width: 25,
                                        );
                                      default:
                                        final entity = snapNotify.data;
                                        final hasNotify = (entity != null && entity.nbrnotification > 0)??false;
                                        if (hasNotify) {
                                          return Badge(
                                            badgeContent: Text("${entity.nbrnotification??0}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            badgeColor: Colors.pink,
                                            child: Image.asset(IMG.classes,
                                              height: 25, width: 25,
                                            ),
                                          );
                                        } else {
                                          return Image.asset(
                                            IMG.classes,
                                            height: 25,
                                            width: 25,
                                          );
                                        }
                                    }
                                  }
                              ),
                            ),
                            /*
                            leading: hasNotify ? Badge(
                              badgeContent: Text("${model.nbrnotification??0}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              badgeColor: Colors.pink,
                              child: Image.asset(IMG.classes,
                                height: 25, width: 25,
                              ),
                            ) : Image.asset(
                              IMG.classes,
                              height: 25,
                              width: 25,
                            ),
                            */
                            subtitle: Text('niveau'.trArgs([model.niveau]),
                              style: GoogleFonts.acme(),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios_sharp),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          IMG.empty,
                          width: Get.width/2,
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),

         */
      ),
    );
  }
}

