import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/routing/route_arguments.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../domain/entities/cv_anaysis_entity.dart';
import '../../domain/repositories/cv_anaylsis_repo.dart';
import '../cubit/cv_history_cubit.dart';
import '../cubit/cv_history_state.dart';
import '../widgets/cv_history_card.dart';

class CvHistoryScreen extends StatelessWidget {
  const CvHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CvHistoryCubit(getIt<CvAnalysisRepository>())..loadHistory(),
      child: const _CvHistoryView(),
    );
  }
}

class _CvHistoryView extends StatelessWidget {
  const _CvHistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('routes.cvHistory'.tr())),
      body: SafeArea(
        child: BlocConsumer<CvHistoryCubit, CvHistoryState>(
          listener: (context, state) async {
            if (state is CvHistoryError) {
              CustomSnackbar.showError(
                context: context,
                message: state.message.tr(),
              );
            }
            if (state is CvHistoryFileReady) {
              final file = state.file;
              context.read<CvHistoryCubit>().markFileHandled();
              await Navigator.pushNamed(
                context,
                AppRoutes.cvPdfViewer,
                arguments: CvPdfViewerArgs(
                  url: file.url,
                  title: file.cv.originalName,
                ),
              );
              if (context.mounted) {
                context.read<CvHistoryCubit>().loadHistory();
              }
            }
          },
          builder: (context, state) => switch (state) {
            CvHistoryLoading() || CvHistoryInitial() => const Center(
                child: CircularProgressIndicator(),
              ),
            CvHistoryEmpty() => _EmptyView(
                onUpload: () => Navigator.pop(context),
              ),
            CvHistoryError() => _ErrorView(
                onRetry: context.read<CvHistoryCubit>().loadHistory,
              ),
            CvHistoryFileReady(:final items) => _HistoryList(items: items),
            CvHistoryLoaded(:final items, :final openingCvId) => _HistoryList(
                items: items,
                openingCvId: openingCvId,
              ),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({required this.items, this.openingCvId});

  final List<CvHistoryItemEntity> items;
  final String? openingCvId;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<CvHistoryCubit>().loadHistory,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(AppSpacing.md.w),
        itemCount: items.length + 1,
        separatorBuilder: (_, __) => SizedBox(height: AppSpacing.md.h),
        itemBuilder: (context, index) {
          if (index == 0) return const _Header();
          final item = items[index - 1];
          return CvHistoryCard(
            item: item,
            isOpening: openingCvId == item.id,
            onOpen: () => context.read<CvHistoryCubit>().openFile(item),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cvHistory.title'.tr(),
          style: AppTextStyles.headlineMedium(colors.onSurface)
              .copyWith(fontSize: 24.sp),
        ),
        SizedBox(height: AppSpacing.xs.h),
        Text(
          'cvHistory.subtitle'.tr(),
          style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.onUpload});

  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return _CenteredMessage(
      icon: Icons.history_rounded,
      titleKey: 'cvHistory.emptyTitle',
      bodyKey: 'cvHistory.emptyBody',
      color: colors.primary,
      child: CustomButton(
        labelKey: 'cvHistory.uploadAction',
        icon: Icons.upload_file_rounded,
        onPressed: onUpload,
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _CenteredMessage(
      icon: Icons.error_outline_rounded,
      titleKey: 'cvHistory.errorTitle',
      bodyKey: 'cvHistory.errorBody',
      color: Theme.of(context).colorScheme.error,
      child: CustomButton(
        labelKey: 'common.retry',
        icon: Icons.refresh_rounded,
        onPressed: onRetry,
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({
    required this.icon,
    required this.titleKey,
    required this.bodyKey,
    required this.child,
    required this.color,
  });

  final IconData icon;
  final String titleKey;
  final String bodyKey;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56.sp, color: color),
            SizedBox(height: AppSpacing.md.h),
            Text(
              titleKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge(colors.onSurface),
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              bodyKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(colors.onSurfaceVariant),
            ),
            SizedBox(height: AppSpacing.lg.h),
            child,
          ],
        ),
      ),
    );
  }
}
