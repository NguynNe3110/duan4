import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AddressMapper extends BaseDataMapper<AddressResponseDto, AddressEntity> {
  @override
  AddressEntity mapToEntity(AddressResponseDto? data) {
    return AddressEntity(
      id: data?.id ?? '',
      userId: data?.userId ?? '',
      label: data?.label,
      receiverName: data?.receiverName ?? '',
      phoneNumber: data?.phoneNumber ?? '',
      addressLine: data?.addressLine ?? '',
      city: data?.city ?? '',
      district: data?.district ?? '',
      ward: data?.ward,
      postalCode: data?.postalCode,
      isDefault: data?.isDefault ?? false,
      createdAt: DateTime.tryParse(data?.createdAt ?? ''),
      updatedAt: DateTime.tryParse(data?.updatedAt ?? ''),
    );
  }

  AddressResponseDto mapToDto(AddressEntity entity) {
    return AddressResponseDto(
      id: entity.id,
      userId: entity.userId,
      label: entity.label,
      receiverName: entity.receiverName,
      phoneNumber: entity.phoneNumber,
      addressLine: entity.addressLine,
      city: entity.city,
      district: entity.district,
      ward: entity.ward,
      postalCode: entity.postalCode,
      isDefault: entity.isDefault ?? false,
      createdAt: entity.createdAt?.toIso8601String() ?? '',
      updatedAt: entity.updatedAt?.toIso8601String() ?? '',
    );
  }
}
