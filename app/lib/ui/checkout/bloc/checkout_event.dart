import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';

part 'checkout_event.freezed.dart';

abstract class CheckoutEvent extends BaseBlocEvent {
  const CheckoutEvent();
}

@freezed
sealed class CheckoutPageInitiated extends CheckoutEvent with _$CheckoutPageInitiated {
  const CheckoutPageInitiated._();
  const factory CheckoutPageInitiated() = _CheckoutPageInitiated;
}

@freezed
sealed class CheckoutSubmitted extends CheckoutEvent with _$CheckoutSubmitted {
  const CheckoutSubmitted._();
  const factory CheckoutSubmitted() = _CheckoutSubmitted;
}
