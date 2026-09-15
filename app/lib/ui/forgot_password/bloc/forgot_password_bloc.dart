import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../base/bloc/base_bloc.dart';
import 'forgot_password.dart';

@injectable
class ForgotPasswordBloc
    extends BaseBloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(_onForgotPasswordEmailChanged);
    on<SendResetCodePressed>(_onSendResetCodePressed);
  }

  void _onForgotPasswordEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
      isButtonEnabled: event.email.trim().isNotEmpty,
    ));
  }

  FutureOr<void> _onSendResetCodePressed(
    SendResetCodePressed event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        // ponytail: call forgot password API when available
        emit(state.copyWith(isEmailSent: true));
      },
    );
  }
}
