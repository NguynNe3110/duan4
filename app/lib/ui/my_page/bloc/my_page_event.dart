import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';

part 'my_page_event.freezed.dart';

abstract class MyPageEvent extends BaseBlocEvent {
  const MyPageEvent();
}

@freezed
sealed class MyPagePageInitiated extends MyPageEvent with _$MyPagePageInitiated {
  const MyPagePageInitiated._();
  const factory MyPagePageInitiated() = _MyPagePageInitiated;
}

@freezed
sealed class LogoutButtonPressed extends MyPageEvent with _$LogoutButtonPressed {
  const LogoutButtonPressed._();
  const factory LogoutButtonPressed() = _LogoutButtonPressed;
}
