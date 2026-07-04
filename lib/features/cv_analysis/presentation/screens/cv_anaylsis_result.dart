import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/cv_anaylsis_state.dart';
import '../cubit/cv_anaysis_cubit.dart';
import '../widgets/cv_analysis_result_content.dart';
import '../widgets/upload_cv_button.dart';

class CvAnalysisResult extends StatelessWidget {
  const CvAnalysisResult({super.key, this.cvId, this.filePath});

  final String? cvId;
  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CvAnalysisCubit>();
        if (filePath != null) {
          cubit.uploadAndAnalyze(filePath!);
        } else {
          cubit.loadLatestAnalysis();
        }
        return cubit;
      },
      child: const _CvAnalysisResultView(),
    );
  }
}

class _CvAnalysisResultView extends StatefulWidget {
  const _CvAnalysisResultView();

  @override
  State<_CvAnalysisResultView> createState() => _CvAnalysisResultViewState();
}

class _CvAnalysisResultViewState extends State<_CvAnalysisResultView> {
  bool _didRefreshJobMatches = false;
  bool _cvAnalysisCompleted = false;

  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, _cvAnalysisCompleted);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
            onPressed: () => Navigator.pop(context, _cvAnalysisCompleted),
          ),
          title: Text('cvAnalysis.title'.tr()),
        ),
        body: SafeArea(
          child: BlocBuilder<CvAnalysisCubit, CvAnalysisState>(
            builder: (context, state) {
              if (state is CvAnalysisInitial || state is CvStatusLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CvUploadLoading || state is CvAnalyzing) {
                return _ProgressView(isUploading: state is CvUploadLoading);
              }
              if (state is CvAnalysisError) {
                return _MessageView(
                  message: state.message.tr(),
                  isError: true,
                );
              }
              if (state is CvStatusLoaded) {
                return _MessageView(
                  message: (state.status.hasCv
                          ? 'cvAnalysis.analyzingHint'
                          : 'cvAnalysis.noCvYet')
                      .tr(),
                );
              }
              if (state is CvAnalysisLoaded) {
                _cvAnalysisCompleted = true;
                _refreshJobMatchesAfterCv();
                return CvAnalysisResultContent(
                  result: state.result,
                  onUploadNewCv: () => _upload(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _upload(BuildContext context) =>
      context.read<CvAnalysisCubit>().pickAndUpload();

  void _refreshJobMatchesAfterCv() {
    if (_didRefreshJobMatches) return;
    _didRefreshJobMatches = true;

    Future.microtask(() async {
      try {
        await getIt<ApiClient>().post(
          ApiEndpoints.generateJobMatches,
          data: const {
            'limit': 30,
            'concurrency': 2,
          },
        );
      } catch (_) {
        // The CV result should remain visible even if match regeneration fails.
      }
    });
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView({required this.isUploading});
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    return _CenteredContent(
      children: [
        const CircularProgressIndicator(),
        SizedBox(height: AppSpacing.lg.h),
        Text(
          (isUploading ? 'cvAnalysis.uploading' : 'cvAnalysis.analyzing').tr(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({required this.message, this.isError = false});
  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return _CenteredContent(
      children: [
        Icon(
          isError ? Icons.error_outline : Icons.description_outlined,
          size: 52.sp,
          color: isError ? colors.error : colors.onSurfaceVariant,
        ),
        SizedBox(height: AppSpacing.md.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium(colors.onSurface),
        ),
        SizedBox(height: AppSpacing.lg.h),
        UploadCvButton(
          onPressed: () => context.read<CvAnalysisCubit>().pickAndUpload(),
        ),
      ],
    );
  }
}

class _CenteredContent extends StatelessWidget {
  const _CenteredContent({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg.w),
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      );
}
