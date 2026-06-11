import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../widgets/cover_letter_result/result_actions.dart';
import '../widgets/cover_letter_result/result_editor_card.dart';
import '../widgets/cover_letter_result/result_score_card.dart';

class CoverLetterResultScreen extends StatefulWidget {
  const CoverLetterResultScreen({super.key});

  @override
  State<CoverLetterResultScreen> createState() =>
      _CoverLetterResultScreenState();
}

class _CoverLetterResultScreenState extends State<CoverLetterResultScreen> {
  late final TextEditingController _letterController;
  bool _isEditing = true;

  @override
  void initState() {
    super.initState();
    _letterController =
        TextEditingController(text: 'coverLetter.draft.body'.tr());
  }

  @override
  void dispose() {
    _letterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text('routes.coverLetterResult'.tr()),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.coverLetterHistory),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md.w),
          children: [
            Text(
              'coverLetter.result.subtitle'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: AppSpacing.md.h),
            const ResultScoreCard(),
            SizedBox(height: AppSpacing.md.h),
            ResultEditorCard(
              controller: _letterController,
              isEditing: _isEditing,
              onEditModeChanged: _setEditMode,
              onCopy: _copyDraft,
              onRegenerate: _regenerateDraft,
            ),
            SizedBox(height: AppSpacing.md.h),
            ResultActions(
              onSaveDraft: _saveDraft,
              onExportPdf: () => _showMessage('coverLetter.result.exportReady'),
            ),
          ],
        ),
      ),
    );
  }

  void _setEditMode(bool editing) {
    setState(() => _isEditing = editing);
  }

  Future<void> _copyDraft() async {
    await Clipboard.setData(ClipboardData(text: _letterController.text));
    if (mounted) _showMessage('coverLetter.result.copied');
  }

  void _regenerateDraft() {
    setState(() {
      _letterController.text = 'coverLetter.draft.body'.tr();
      _isEditing = true;
    });
    _showMessage('coverLetter.result.regenerated');
  }

  void _saveDraft() {
    setState(() {
      _isEditing = false;
    });
    _showMessage('coverLetter.result.saved');
  }

  void _showMessage(String key) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(key.tr())),
    );
  }
}
