import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';
import 'package:domain/domain.dart';
import 'package:shared/shared.dart';

part 'my_page_state.freezed.dart';

@freezed
sealed class MyPageState extends BaseBlocState with _$MyPageState {
  const MyPageState._();

  const factory MyPageState({
    ProfileEntity? profile,
    @Default(false) bool isShimmerLoading,
    AppException? loadException,
  }) = _MyPageState;
}
