import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'register_event.freezed.dart';

abstract class RegisterEvent extends BaseBlocEvent {
  const RegisterEvent();
}

@freezed
class NameTextFieldChanged extends RegisterEvent with _$NameTextFieldChanged {
  const factory NameTextFieldChanged({
    required String name,
  }) = _NameTextFieldChanged;
}

@freezed
class EmailTextFieldChanged extends RegisterEvent with _$EmailTextFieldChanged {
  const factory EmailTextFieldChanged({
    required String email,
  }) = _EmailTextFieldChanged;
}

@freezed
class PasswordTextFieldChanged extends RegisterEvent
    with _$PasswordTextFieldChanged {
  const factory PasswordTextFieldChanged({
    required String password,
  }) = _PasswordTextFieldChanged;
}

@freezed
class ConfirmPasswordTextFieldChanged extends RegisterEvent
    with _$ConfirmPasswordTextFieldChanged {
  const factory ConfirmPasswordTextFieldChanged({
    required String confirmPassword,
  }) = _ConfirmPasswordTextFieldChanged;
}

@freezed
class EyeIconPressed extends RegisterEvent with _$EyeIconPressed {
  const factory EyeIconPressed() = _EyeIconPressed;
}

@freezed
class ConfirmEyeIconPressed extends RegisterEvent with _$ConfirmEyeIconPressed {
  const factory ConfirmEyeIconPressed() = _ConfirmEyeIconPressed;
}

@freezed
class TermsCheckboxToggled extends RegisterEvent with _$TermsCheckboxToggled {
  const factory TermsCheckboxToggled({
    required bool isAccepted,
  }) = _TermsCheckboxToggled;
}

@freezed
class RegisterButtonPressed extends RegisterEvent
    with _$RegisterButtonPressed {
  const factory RegisterButtonPressed() = _RegisterButtonPressed;
}
