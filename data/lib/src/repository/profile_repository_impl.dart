import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../data.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileSupabaseService _profileSupabaseService;
  final ProfileMapper _profileMapper;

  ProfileRepositoryImpl(this._profileMapper, this._profileSupabaseService);

  @override
  Future<ProfileEntity> getProfileById({required String userId}) async {
    final dto = await _profileSupabaseService.getProfileById(userId: userId);
    return _profileMapper.mapToEntity(dto);
  }

  @override
  Future<ProfileEntity> updateProfile({
    required String userId,
    required UpdateProfileRequestEntity data,
  }) async {
    final dto = _profileMapper.mapToDto(data);
    final responseDto = await _profileSupabaseService.updateProfile(
      userId: userId,
      data: dto.toJson(),
    );
    return _profileMapper.mapToEntity(responseDto);
  }

  @override
  Future<ProfileEntity> getProfile() async {
    final dto = await _profileSupabaseService.getProfile();
    return _profileMapper.mapToEntity(dto);
  }
}
