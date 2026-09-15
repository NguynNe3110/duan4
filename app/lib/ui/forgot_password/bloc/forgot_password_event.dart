import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'forgot_password_event.freezed.dart';

abstract class ForgotPasswordEvent extends BaseBlocEvent {
  const ForgotPasswordEvent();
}

@freezed
class ForgotPasswordEmailChanged extends ForgotPasswordEvent
    with _$ForgotPasswordEmailChanged {
  const factory ForgotPasswordEmailChanged({required String email}) =
      _ForgotPasswordEmailChanged;
}

@freezed
class SendResetCodePressed extends ForgotPasswordEvent
    with _$SendResetCodePressed {
  const factory SendResetCodePressed() = _SendResetCodePressed;
}
