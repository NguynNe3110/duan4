import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:app/app.dart';

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

  FutureOr<void> _onPageInitiated(
    MyPagePageInitiated event,
    Emitter<MyPageState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(isShimmerLoading: true));
        final output = await _getMeUseCase.execute(const GetMeUseCaseInput());
        emit(state.copyWith(
          profile: output.profile,
          isShimmerLoading: false,
        ));
      },
      handleError: (error) async {
        emit(state.copyWith(
          isShimmerLoading: false,
          loadException: error,
        ));
      },
    );
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
