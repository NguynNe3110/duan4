import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../base/bloc/base_bloc.dart';
import 'register.dart';

@injectable
class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc(
    this._registerAccountUseCase,
  ) : super(const RegisterState()) {
    on<NameTextFieldChanged>(_onNameTextFieldChanged);
    on<EmailTextFieldChanged>(_onEmailTextFieldChanged);
    on<PasswordTextFieldChanged>(_onPasswordTextFieldChanged);
    on<ConfirmPasswordTextFieldChanged>(_onConfirmPasswordTextFieldChanged);
    on<EyeIconPressed>(_onEyeIconPressed);
    on<ConfirmEyeIconPressed>(_onConfirmEyeIconPressed);
    on<TermsCheckboxToggled>(_onTermsCheckboxToggled);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  final RegisterAccountUseCase _registerAccountUseCase;

  bool _checkCanRegister({
    required String email,
    required String password,
    required String confirmPassword,
    required bool isTermsAccepted,
  }) {
    return email.trim().isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword &&
        isTermsAccepted;
  }

  void _onNameTextFieldChanged(
    NameTextFieldChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      isRegisterButtonEnabled: _checkCanRegister(
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isTermsAccepted: state.isTermsAccepted,
      ),
    ));
  }

  void _onEmailTextFieldChanged(
    EmailTextFieldChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
      onPageError: '',
      isRegisterButtonEnabled: _checkCanRegister(
        email: event.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isTermsAccepted: state.isTermsAccepted,
      ),
    ));
  }

  void _onPasswordTextFieldChanged(
    PasswordTextFieldChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
      onPageError: '',
      isRegisterButtonEnabled: _checkCanRegister(
        email: state.email,
        password: event.password,
        confirmPassword: state.confirmPassword,
        isTermsAccepted: state.isTermsAccepted,
      ),
    ));
  }

  void _onConfirmPasswordTextFieldChanged(
    ConfirmPasswordTextFieldChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      onPageError: '',
      isRegisterButtonEnabled: _checkCanRegister(
        email: state.email,
        password: state.password,
        confirmPassword: event.confirmPassword,
        isTermsAccepted: state.isTermsAccepted,
      ),
    ));
  }

  void _onEyeIconPressed(
    EyeIconPressed event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void _onConfirmEyeIconPressed(
    ConfirmEyeIconPressed event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(confirmObscureText: !state.confirmObscureText));
  }

  void _onTermsCheckboxToggled(
    TermsCheckboxToggled event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      isTermsAccepted: event.isAccepted,
      isRegisterButtonEnabled: _checkCanRegister(
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isTermsAccepted: event.isAccepted,
      ),
    ));
  }

  FutureOr<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        final username = state.name.trim().isNotEmpty
            ? state.name.trim()
            : state.email.trim().split('@').first;
        await _registerAccountUseCase.execute(
          RegisterAccountInput(
            username: username,
            email: state.email.trim(),
            password: state.password,
            gender: Gender.other,
          ),
        );
        await navigator.replace(const AppRouteInfo.main());
      },
      doOnError: (e) async {
        emit(state.copyWith(onPageError: e.toString()));
      },
    );
  }
}
