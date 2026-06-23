import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../../jobs/domain/entities/job.dart';
import '../../data/data_sources/remote/cover_letters_remote_data_source.dart';
import '../../data/repositories/cover_letters_repository_impl.dart';
import '../cubit/cover_letters_cubit.dart';
import '../cubit/cover_letters_state.dart';
import '../widgets/cover_letter/cover_header.dart';
import '../widgets/cover_letter/generate_button.dart';
import '../widgets/cover_letter/personalize_card.dart';
import '../widgets/cover_letter/selected_role_card.dart';
import '../widgets/cover_letter/target_goal_card.dart';

class CoverLetterGeneratorScreen extends StatefulWidget {
  const CoverLetterGeneratorScreen({super.key});

  @override
  State<CoverLetterGeneratorScreen> createState() =>
      _CoverLetterGeneratorScreenState();
}

class _CoverLetterGeneratorScreenState
    extends State<CoverLetterGeneratorScreen> {
  late final TextEditingController _companyInterestController;
  late final TextEditingController _achievementController;
  String _selectedTone = 'professional';
  final Set<String> _selectedKeywords = {};
  String? _seededJobId;

  @override
  void initState() {
    super.initState();
    _companyInterestController = TextEditingController();
    _achievementController = TextEditingController();
  }

  @override
  void dispose() {
    _companyInterestController.dispose();
    _achievementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final selectedJob = arguments is Job ? arguments : null;
    final jobId = selectedJob?.id ?? arguments?.toString();
    _seedKeywordsFromJob(selectedJob);
    final availableKeywords = selectedJob?.requiredSkills
            .where((skill) => skill.trim().isNotEmpty)
            .toSet()
            .take(8)
            .toList(growable: false) ??
        const <String>[];
    final goalProgress = availableKeywords.isEmpty
        ? 0.0
        : (_selectedKeywords.length / availableKeywords.length).clamp(0.0, 1.0);

    return BlocProvider(
      create: (_) => _createCubit(),
      child: BlocConsumer<CoverLettersCubit, CoverLettersState>(
        listener: (context, state) {
          if (state.status == CoverLettersStatus.success &&
              state.current != null) {
            Navigator.of(context).pushNamed(
              AppRoutes.coverLetterResult,
              arguments: state.current,
            );
          }
          if (state.status == CoverLettersStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == CoverLettersStatus.loading;

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              leading: const AppGradientBackButton(),
              title: Text('routes.coverLetterGenerator'.tr()),
            ),
            body: SafeArea(
              child: selectedJob == null
                  ? _MissingJobState(
                      onChooseJob: () => Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.jobs),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            AppSpacing.md.w,
                            AppSpacing.sm.h,
                            AppSpacing.md.w,
                            AppSpacing.xl.h,
                          ),
                          sliver: SliverList.list(
                            children: [
                              const CoverHeader(),
                              SizedBox(height: AppSpacing.md.h),
                              SelectedRoleCard(
                                title: selectedJob.title,
                                company: selectedJob.company,
                                location: selectedJob.location,
                                onChangeRole: () => Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.jobs),
                              ),
                              SizedBox(height: AppSpacing.md.h),
                              PersonalizeCard(
                                selectedTone: _selectedTone,
                                selectedKeywords: _selectedKeywords,
                                companyInterestController:
                                    _companyInterestController,
                                achievementController: _achievementController,
                                availableKeywords: availableKeywords,
                                onToneChanged: (tone) {
                                  setState(() => _selectedTone = tone);
                                },
                                onKeywordToggled: (keyword) {
                                  setState(() {
                                    if (_selectedKeywords.contains(keyword)) {
                                      _selectedKeywords.remove(keyword);
                                    } else if (_selectedKeywords.length < 5) {
                                      _selectedKeywords.add(keyword);
                                    }
                                  });
                                },
                              ),
                              SizedBox(height: AppSpacing.md.h),
                              TargetGoalCard(
                                title: selectedJob.title,
                                progress: goalProgress,
                                selectedSkills: _selectedKeywords.toList(),
                                remainingSkills: availableKeywords
                                    .where((skill) =>
                                        !_selectedKeywords.contains(skill))
                                    .take(3)
                                    .toList(),
                              ),
                              SizedBox(height: AppSpacing.md.h),
                              GenerateCoverLetterButton(
                                isLoading: isLoading,
                                onPressed: jobId == null || jobId.isEmpty
                                    ? null
                                    : () => context
                                        .read<CoverLettersCubit>()
                                        .generate(
                                          jobId,
                                          tone: _selectedTone,
                                          keywords: _selectedKeywords.toList(),
                                          companyInterest:
                                              _companyInterestController.text
                                                  .trim(),
                                          achievement: _achievementController
                                              .text
                                              .trim(),
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  void _seedKeywordsFromJob(Job? job) {
    if (job == null || _seededJobId == job.id) return;
    _seededJobId = job.id;
    _selectedKeywords
      ..clear()
      ..addAll(
          job.requiredSkills.where((skill) => skill.trim().isNotEmpty).take(3));
  }
}

class _MissingJobState extends StatelessWidget {
  const _MissingJobState({required this.onChooseJob});

  final VoidCallback onChooseJob;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.work_outline, color: colors.primary, size: 44.sp),
            SizedBox(height: AppSpacing.md.h),
            Text(
              'Choose a job first',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              'Open a job, then generate a cover letter tailored to it.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: AppSpacing.md.h),
            FilledButton(
              onPressed: onChooseJob,
              child: const Text('Choose job'),
            ),
          ],
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
