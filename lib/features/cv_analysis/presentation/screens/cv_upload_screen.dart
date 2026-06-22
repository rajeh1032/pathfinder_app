import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../jobs/presentation/widgets/job_details/ai_recommendation_card.dart';
import '../widgets/selected_file_card.dart';

class CvUploadScreen extends StatefulWidget {
  const CvUploadScreen({super.key});

  @override
  State<CvUploadScreen> createState() => _CvUploadScreenState();
}

class _CvUploadScreenState extends State<CvUploadScreen> {
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      setState(() => _selectedFile = result.files.single);
    }
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  IconData _fileIcon(String? ext) {
    switch (ext?.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'doc':
      case 'docx':
        return Icons.description_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _fileColor(String? ext) {
    switch (ext?.toLowerCase()) {
      case 'pdf':
        return AppColors.error;
      case 'doc':
      case 'docx':
        return AppColors.primary;
      default:
        return AppColors.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasFile = _selectedFile != null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PathFinder AI',
          style: AppTextStyles.titleMedium(AppColors.primary).copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: 24.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.md.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Text(
              'cvUpload.title'.tr(),
              style: AppTextStyles.headlineMedium(colorScheme.onSurface)
                  .copyWith(fontSize: 24.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              'cvUpload.subtitle'.tr(),
              style: AppTextStyles.bodyMedium(colorScheme.onSurfaceVariant)
                  .copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: AppSpacing.lg.h),

            // ── Upload Area ──
            GestureDetector(
              onTap: _pickFile,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 48.h,
                  horizontal: AppSpacing.md.w,
                ),
                constraints: BoxConstraints(minHeight: 220.h),
                decoration: BoxDecoration(
                  color: hasFile
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.lg.r),
                  border: Border.all(
                    color: hasFile
                        ? AppColors.primary.withValues(alpha: 0.4)
                        : colorScheme.outline.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    // Upload icon
                    Container(
                      width: 64.w,
                      height: 64.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.upload_file_rounded,
                        size: 32.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    Text(
                      'cvUpload.uploadTitle'.tr(),
                      style: AppTextStyles.titleSmall(colorScheme.onSurface)
                          .copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'cvUpload.formats'.tr(),
                      style:
                          AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                              .copyWith(fontSize: 12.sp),
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    // Format chips
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ['PDF', 'DOC', 'DOCX'].map((fmt) {
                        return Container(
                          margin: EdgeInsets.only(right: 6.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppRadius.pill.r),
                          ),
                          child: Text(
                            fmt,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: AppSpacing.sm.h),
                    Text(
                      'cvUpload.maxSize'.tr(),
                      style:
                          AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                              .copyWith(fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSpacing.md.h),

            //  Selected File Card
            if (hasFile) ...[
              SelectedFileCard(
                file: _selectedFile!,
                formatSize: _formatSize,
                fileIcon: _fileIcon,
                fileColor: _fileColor,
                onRemove: () => setState(() => _selectedFile = null),
              ),
              SizedBox(height: AppSpacing.md.h),
            ],

            // AI Recommendation Card
            AiRecommendationCard(),
            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
      // Bottom Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md.w,
          AppSpacing.sm.h,
          AppSpacing.md.w,
          AppSpacing.lg.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton.icon(
                onPressed: hasFile
                    ? () => Navigator.pushNamed(
                          context,
                          AppRoutes.cvUploadLoading,
                        )
                    : null,
                icon: Icon(Icons.analytics_outlined, size: 20.sp),
                label: Text(
                  'cvUpload.analyzeButton'.tr(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: colorScheme.surfaceContainerHighest,
                  disabledForegroundColor: colorScheme.onSurfaceVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            if (!hasFile)
              Text(
                'cvUpload.selectPrompt'.tr(),
                style: AppTextStyles.bodySmall(colorScheme.onSurfaceVariant)
                    .copyWith(fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
