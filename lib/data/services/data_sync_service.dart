import 'package:bokashi/common/enums/data_source_enum.dart';
import 'package:bokashi/data/model/api_response.dart';
import 'package:bokashi/data/reposotories/data_sync_repo_interface.dart';
import 'package:bokashi/data/services/data_sync_service_interface.dart';

class DataSyncService implements DataSyncServiceInterface {
  DataSyncRepoInterface dataSyncRepoInterface;

  DataSyncService({required this.dataSyncRepoInterface});

  @override
  Future<ApiResponseModel<T>> fetchData<T>(String uri, DataSourceEnum source) async {
    return await dataSyncRepoInterface.fetchData(uri, source);
  }
}