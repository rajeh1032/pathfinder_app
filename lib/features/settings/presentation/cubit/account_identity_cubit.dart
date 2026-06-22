import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/storage/token_storage.dart';
import '../../../../core/utils/jwt.dart';
import '../../../career_paths/domain/entities/career_path.dart';
import '../../../career_paths/domain/use_cases/get_career_paths_use_case.dart';
import '../../../profile/domain/use_cases/get_my_profile_use_case.dart';
import 'account_identity_state.dart';

/// Loads the authenticated user's real name, target career path title and
/// email for the settings account header. Reuses existing profile and
/// career-path use cases; email is read from the JWT access token.
@injectable
class AccountIdentityCubit extends Cubit<AccountIdentityState> {
  AccountIdentityCubit(
    this._getMyProfile,
    this._getCareerPaths,
    this._tokenStorage,
  ) : super(const AccountIdentityState());

  final GetMyProfileUseCase _getMyProfile;
  final GetCareerPathsUseCase _getCareerPaths;
  final TokenStorage _tokenStorage;

  Future<void> load() async {
    if (state.status == AccountIdentityStatus.loading) return;
    emit(state.copyWith(status: AccountIdentityStatus.loading));

    final token = await _tokenStorage.getAccessToken();
    final email = emailFromToken(token);

    final profileResult = await _getMyProfile();
    final profile = profileResult.fold((_) => null, (p) => p);

    String? careerPath;
    final targetCareerId = profile?.targetCareerId;
    if (targetCareerId != null && targetCareerId.isNotEmpty) {
      final pathsResult = await _getCareerPaths();
      final paths = pathsResult.fold((_) => const <CareerPath>[], (p) => p);
      for (final path in paths) {
        if (path.id == targetCareerId) {
          careerPath = path.title;
          break;
        }
      }
    }

    emit(state.copyWith(
      status: AccountIdentityStatus.success,
      name: profile?.name,
      careerPath: careerPath ?? profile?.headline,
      email: email,
    ));
  }
}
