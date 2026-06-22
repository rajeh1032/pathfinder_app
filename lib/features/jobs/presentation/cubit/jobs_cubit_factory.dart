import '../../../../core/di/di.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_info.dart';
import '../../data/data_sources/remote/jobs_remote_data_source.dart';
import '../../data/repositories/jobs_repository_impl.dart';
import 'jobs_cubit.dart';

JobsCubit createJobsCubit() {
  final remoteDataSource = JobsRemoteDataSourceImpl(getIt<ApiClient>());
  final repository = JobsRepositoryImpl(remoteDataSource, getIt<NetworkInfo>());
  return JobsCubit(repository);
}
