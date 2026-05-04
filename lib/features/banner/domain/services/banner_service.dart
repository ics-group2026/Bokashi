import 'package:bokashi/common/enums/data_source_enum.dart';
import 'package:bokashi/data/model/api_response.dart';
import 'package:bokashi/features/banner/domain/repositories/banner_repository_interface.dart';
import 'package:bokashi/features/banner/domain/services/banner_service_interface.dart';

class BannerService implements BannerServiceInterface{
  BannerRepositoryInterface bannerRepositoryInterface;
  BannerService({required this.bannerRepositoryInterface});

  @override
  Future<ApiResponseModel<T>> getList<T>({required DataSourceEnum source}) async{
    return await bannerRepositoryInterface.getBannerList(source: source);
  }


}