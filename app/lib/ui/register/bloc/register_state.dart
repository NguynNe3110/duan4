import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState extends BaseBlocState with _$RegisterState {
  const factory RegisterState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(true) bool obscureText,
    @Default(true) bool confirmObscureText,
    @Default(false) bool isTermsAccepted,
    @Default(false) bool isRegisterButtonEnabled,
    @Default('') String onPageError,
  }) = _RegisterState;
}
