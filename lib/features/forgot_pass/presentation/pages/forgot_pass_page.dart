import '../../../../core/injection/injection_container.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../../../core/ui/responsive_safe_area.dart';
import '../../../../core/util/flash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/loading_app.dart';
import '../widgets/initial_forgot_pass.dart';
import '../widgets/loaded_forgot_pass.dart';
import '../../../../core/ui/error_app.dart';
import 'package:flutter/material.dart';
import '../bloc/forgot_pass_bloc.dart';
import 'package:get/get.dart';



class ForgotPassPage extends StatelessWidget {
  const ForgotPassPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => BlocProvider(
        create: (_) => sl<ForgotPassBloc>(),
        child: BlocListener<ForgotPassBloc, ForgotPassState>(
          listener: (context, state) {
            if (state is LoadedForgotPassState) {
              if (!state.entity.erreur) {
                FlashHelper.successBar(message: state.entity.message);
                Get.offAll(() => const LoginPage());
              } else {
                FlashHelper.errorBar(message: state.entity.message);
              }
            }
          },
          child: BlocBuilder<ForgotPassBloc, ForgotPassState>(
            builder: (context, state) {
              if (state is InitialForgotPassState) {
                return const InitialForgotPass();
              } else if (state is LoadingForgotPassState) {
                return const LoadingApp();
              } else if (state is LoadedForgotPassState) {
                return LoadedForgotPass(state.entity);
              } else if (state is ErrorForgotPassState) {
                return ErrorApp(message: state.message);
              } else {
                return const ErrorApp();
              }
            },
          ),
        ),
      ),
    );
  }
}
