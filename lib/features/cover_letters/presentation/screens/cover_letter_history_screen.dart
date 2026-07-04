import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../data/data_sources/remote/cover_letters_remote_data_source.dart';
import '../../data/repositories/cover_letters_repository_impl.dart';
import '../cubit/cover_letters_cubit.dart';
import '../cubit/cover_letters_state.dart';
import '../widgets/cover_letter_history/history_letter_card.dart';
import '../widgets/cover_letter_history/history_section_title.dart';

class CoverLetterHistoryScreen extends StatelessWidget {
  const CoverLetterHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createCubit()..loadHistory(),
      child: Scaffold(
        appBar: AppBar(
          leading: const AppGradientBackButton(),
          title: Text('routes.coverLetterHistory'.tr()),
        ),
        body: SafeArea(
          child: BlocConsumer<CoverLettersCubit, CoverLettersState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            builder: (context, state) {
              if (state.status == CoverLettersStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == CoverLettersStatus.failure) {
                return Center(
                  child: Text(
                      state.errorMessage ?? 'coverLetter.history.empty'.tr()),
                );
              }
              final letters = state.history;
              if (letters.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.lg.w),
                    child: Text(
                      'No generated cover letters yet.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.all(AppSpacing.md.w),
                itemCount: letters.length + 2,
                separatorBuilder: (_, __) => SizedBox(height: AppSpacing.md.h),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text(
                      'coverLetter.history.subtitle'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            height: 1.35,
                            fontWeight: FontWeight.w600,
                          ),
                    );
                  }
                  if (index == 1) {
                    return HistorySectionTitle(
                      'coverLetter.history.thisWeek'.tr(),
                    );
                  }
                  final letter = letters[index - 2];
                  return HistoryLetterCard(
                    letter: letter,
                    onDelete: () =>
                        context.read<CoverLettersCubit>().deleteLetter(
                              letter.id,
                            ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

CoverLettersCubit _createCubit() {
  final remote = CoverLettersRemoteDataSourceImpl(getIt<ApiClient>());
  final repository = CoverLettersRepositoryImpl(remote, getIt<NetworkInfo>());
  return CoverLettersCubit(repository);
}
