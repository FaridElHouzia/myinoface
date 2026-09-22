import 'package:myinoface/features/login/domain/usecases/get_login_with_email_and_pass.dart';
import 'package:myinoface/features/login/domain/usecases/get_login_with_qrcode.dart';
import 'package:myinoface/features/login/domain/usecases/input_qrcode_model.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/login/data/models/login_model.dart';
import 'package:myinoface/core/usecases/constants.dart';
import '../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final GetLoginWithEmailAndPass getLoginWithEmailAndPass;
  final GetLoginWithQrcode getLoginWithQrcode;

  LoginBloc({required this.getLoginWithEmailAndPass, required this.getLoginWithQrcode}) : super(const InitialLoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginWithEmailAndPass) {
        try {
          emit(const LoadingLoginState());
          Either<Failure, LoginModel> either = await getLoginWithEmailAndPass.call(event.inputLogin);
          either.fold((failure) {
            final messageFailure = (failure.props.isNotEmpty ? failure.props.first : null)?.toString() ?? '';
            logger.e('messageFailure: $messageFailure');
            emit(ErrorLoginState(message: messageFailure.isNotEmpty ? messageFailure : 'error_server'.tr));
          }, (values) {
            if (values.erreur) {
              emit(ErrorLoginState(
                message: values.message.isNotEmpty ? values.message : 'error_server'.tr,
              ));
              return;
            }
            emit(LoadedLoginState(model: values));
          });
        } catch(e) {
          return emit(ErrorLoginState(message: e.toString()));
        }
      } else if (event is LoginWithQRCode) {
        try {
          Either<Failure, LoginModel> either = await getLoginWithQrcode.call(event.inputQrcode);
          either.fold((failure) {
            final messageFailure = (failure.props.isNotEmpty ? failure.props.first : null)?.toString() ?? '';
            logger.e('messageFailure: $messageFailure');
            emit(ErrorLoginState(message: messageFailure.isNotEmpty ? messageFailure : 'error_server'.tr));
          }, (values) {
            if (values.erreur) {
              emit(ErrorLoginState(
                message: values.message.isNotEmpty ? values.message : 'error_qrcode'.tr,
              ));
              return;
            }
            emit(LoadedLoginState(model: values));
          });
        } catch(e) {
          return emit(ErrorLoginState(message: e.toString()));
        }
      }
    });
  }
}
