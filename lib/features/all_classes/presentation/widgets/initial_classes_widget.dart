import 'package:myinoface/features/all_classes/presentation/bloc/classes_bloc.dart';
import 'package:myinoface/core/injection/injection_container.dart';
import 'package:myinoface/core/ui/responsive_safe_area.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/util/flash_helper.dart';
import 'package:myinoface/core/ui/loading_app.dart';
import 'package:myinoface/core/ui/error_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loaded_casses_widget.dart';




class InitialClassesWidget extends StatelessWidget {
  final ClassEntitie model;
  const InitialClassesWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        body: BlocProvider(
            create: (_) => sl<ClassesBloc>()
              ..add(GetAllClasses(idClass: model.id_classe)),
            child: BlocConsumer<ClassesBloc, ClassesState>(
              listener: (context, state) {
                if (state is ErrorClassesState) {
                  FlashHelper.errorBar(message: state.message??'');
                }
              },
              builder: (context, state) {
                if (state is InitialClassesState) {
                  return const LoadingApp();
                } else if (state is LoadingClassesState) {
                  return const LoadingApp();
                } else if (state is LoadedClassesState) {
                  return LoadedClassesWidget(
                    model: state.model,
                  );
                } else if (state is ErrorClassesState) {
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
