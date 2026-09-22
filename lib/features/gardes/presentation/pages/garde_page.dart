import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myinoface/core/injection/injection_container.dart';
import 'package:myinoface/core/ui/error_app.dart';
import 'package:myinoface/core/ui/loading_app.dart';
import 'package:myinoface/core/ui/responsive_safe_area.dart';
import 'package:myinoface/core/util/flash_helper.dart';
import 'package:myinoface/features/gardes/presentation/bloc/garde_bloc.dart';
import 'package:myinoface/features/gardes/presentation/widgets/garde_calendar.dart';
import 'package:myinoface/features/gardes/presentation/widgets/loaded_garde_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class GardesPage extends StatelessWidget {
  const GardesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('gardes'.tr),
        ),
        backgroundColor: Colors.white,
        // backgroundColor: Colors.pink.shade50,
        body: BlocProvider(
          create: (_) => sl<GardeBloc>()
            ..add(GetPersonneGardeByDate(date: DateTime.now())),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const GardeCalendar(),
                BlocConsumer<GardeBloc, GardeState>(
                  listener: (context, state) {
                    if (state is GardeError) {
                      FlashHelper.errorBar(message: state.message ?? 'something_wrong'.tr);
                    }
                  },
                  builder: (context, state) {
                    if (state is GardeInitial) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is GardeLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is GardeLoaded) {
                      return LoadedGardeWidget(
                        model: state.model,
                      );
                    } else if (state is GardeError) {
                      return ErrorApp(message: state.message);
                    } else {
                      return const ErrorApp();
                    }
                  },
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}

