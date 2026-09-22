import 'package:myinoface/features/login/presentation/widgets/initial_login_widget.dart';
import 'package:myinoface/features/login/presentation/widgets/loaded_login_widget.dart';
import 'package:myinoface/features/login/presentation/bloc/login_bloc.dart';
import 'package:myinoface/core/injection/injection_container.dart';
import 'package:myinoface/core/ui/responsive_safe_area.dart';
import 'package:myinoface/core/util/flash_helper.dart';
import 'package:myinoface/core/ui/loading_app.dart';
import 'package:myinoface/core/ui/error_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _identifiantController = TextEditingController();
  final TextEditingController _passwordController    = TextEditingController();
  final TextEditingController _codeController        = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        body: BlocProvider(
            create: (_) => sl<LoginBloc>(),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is ErrorLoginState) {
                  FlashHelper.errorBar(message: state.message);
                } else if (state is LoadedLoginState) {
                  FlashHelper.successBar(message: state.model.message);
                }
              },
              builder: (context, state) {
                if (state is InitialLoginState) {
                  return InitialLoginWidget(
                    identifiantController: _identifiantController,
                    passwordController: _passwordController,
                    codeController: _codeController,
                  );
                } else if (state is LoadingLoginState) {
                  return const LoadingApp();
                } else if (state is LoadedLoginState) {
                  return LoadedLoginWidget(model: state.model);
                } else if (state is ErrorLoginState) {
                  return InitialLoginWidget(
                    identifiantController: _identifiantController,
                    passwordController: _passwordController,
                    codeController: _codeController,
                  );
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
