import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ProfileMapper extends BaseDataMapper<ProfileResponseDto, ProfileEntity> {
  @override
  ProfileEntity mapToEntity(ProfileResponseDto? data) {
    return ProfileEntity(
      id: data?.id ?? '',
      fullName: data?.fullName ?? '',
      phoneNumber: data?.phoneNumber,
      avatarUrl: data?.avatarUrl,
      createdAt: DateTime.tryParse(data?.createdAt ?? ''),
      updatedAt: DateTime.tryParse(data?.updatedAt ?? ''),
    );
  }

  UpdateProfileRequestDto mapToDto(UpdateProfileRequestEntity data) {
    return UpdateProfileRequestDto(
      fullName: data.fullName,
      phoneNumber: data.phoneNumber,
      avatarUrl: data.avatarUrl,
    );
  }
}
