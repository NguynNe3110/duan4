import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:app/app.dart';
import 'package:shared/shared.dart';

@Injectable()
class MyPageBloc extends BaseBloc<MyPageEvent, MyPageState> {
  MyPageBloc(
      this._getMeUseCase,
      this._logoutUseCase
      ) : super(const MyPageState()) {
    on<MyPagePageInitiated>(_onPageInitiated, transformer: log());
    on<LogoutButtonPressed>(_onLogoutButtonPressed, transformer: log());
  }

  final GetMeUseCase _getMeUseCase;
  final LogoutUseCase _logoutUseCase;

  FutureOr<void> _onPageInitiated( // handel loading manual,
    MyPagePageInitiated event,
    Emitter<MyPageState> emit,
  ) async {
    emit(state.copyWith(isShimmerLoading: true));
    try {
      final output = await _getMeUseCase.execute(const GetMeUseCaseInput());
      emit(state.copyWith(profile: output.profile, isShimmerLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isShimmerLoading: false,
        loadException: e is AppException ? e : AppUncaughtException(e),
      ));
    }
  }

  FutureOr<void> _onLogoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<MyPageState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        await _logoutUseCase.execute(const LogoutInput());
      },
    );
  }
}
