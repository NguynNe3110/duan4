import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';

part 'add_search_history_use_case.freezed.dart';

@Injectable()
class AddSearchHistoryUseCase extends BaseFutureUseCase<AddSearchHistoryInput, AddSearchHistoryOutput> {
  AddSearchHistoryUseCase();

  @protected
  @override
  Future<AddSearchHistoryOutput> buildUseCase(AddSearchHistoryInput input) async {
    // TODO: implement call to local DB or remote API to save keyword/product
    return AddSearchHistoryOutput();
  }
}

@freezed
sealed class AddSearchHistoryInput extends BaseInput with _$AddSearchHistoryInput {
  const factory AddSearchHistoryInput({
    required String keyword,
  }) = _AddSearchHistoryInput;
}

@freezed
sealed class AddSearchHistoryOutput extends BaseOutput with _$AddSearchHistoryOutput {
  const factory AddSearchHistoryOutput() = _AddSearchHistoryOutput;
}


