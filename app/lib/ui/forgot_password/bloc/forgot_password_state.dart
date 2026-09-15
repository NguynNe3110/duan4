import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState extends BaseBlocState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default('') String email,
    @Default(false) bool isButtonEnabled,
    @Default(false) bool isEmailSent,
  }) = _ForgotPasswordState;
}
