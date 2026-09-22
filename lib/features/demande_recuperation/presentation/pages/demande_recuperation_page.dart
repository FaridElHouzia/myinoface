import 'package:myinoface/features/demande_recuperation/presentation/widgets/loaded_demande_recuperation_widget.dart';
import 'package:myinoface/features/demande_recuperation/presentation/bloc/demande_recuperation_bloc.dart';
import 'package:myinoface/core/injection/injection_container.dart';
import 'package:myinoface/core/ui/responsive_safe_area.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/util/flash_helper.dart';
import '../../../../core/notifier/model_notifier.dart';
import 'package:myinoface/core/ui/loading_app.dart';
import 'package:myinoface/core/ui/error_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';




class DemandeRecuperationPage extends StatelessWidget {
  final ClassEntitie classEntitie;
  const DemandeRecuperationPage({Key? key, required this.classEntitie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _notify = context.watch<ModelNotifier>();
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        body: BlocProvider(
            create: (_) => sl<DemandeRecuperationBloc>()
              ..add(GetDemandesRecuperationsByIdClasse(idClass: classEntitie.id_classe)),
            child: BlocConsumer<DemandeRecuperationBloc, DemandeRecuperationState>(
              listener: (context, state) {
                if (state is ErrorDemandeRecuperationState) {
                  FlashHelper.errorBar(message: state.message);
                }

                if (state is LoadedDemandeRecuperationState) {
                  _notify.setDemandeRecuperationModell(
                    state.model, initial: false,
                  );
                }
              },
              builder: (context, state) {
                if (state is InitialDemandeRecuperationState) {
                  return const LoadingApp();
                } else if (state is LoadedDemandeRecuperationState) {
                  return LoadedDemandeRecuperationWidget(
                    classEntitie: classEntitie,
                    model: state.model,
                  );
                } else if (state is ErrorDemandeRecuperationState) {
                  return ErrorApp(message: state.message);
                } else {
                  return const ErrorApp();
                }
              },
            )
        ),
      ),
    );
  }
}
