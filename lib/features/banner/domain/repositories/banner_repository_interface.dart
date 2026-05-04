import 'package:bokashi/common/enums/data_source_enum.dart';
import 'package:bokashi/data/model/api_response.dart';
import 'package:bokashi/interface/repo_interface.dart';

abstract class BannerRepositoryInterface<T> implements RepositoryInterface{
  Future<ApiResponseModel<T>> getBannerList<T>({required DataSourceEnum source});


}