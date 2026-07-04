import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../data/data_sources/remote/cover_letters_remote_data_source.dart';
import '../../data/repositories/cover_letters_repository_impl.dart';
import '../../domain/entities/cover_letter.dart';
import '../cubit/cover_letters_cubit.dart';
import '../cubit/cover_letters_state.dart';
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
  CoverLettersCubit? _cubit;
  String? _syncedLetterKey;
  bool _hasValidArgs = true;

  @override
  void initState() {
    super.initState();
    _letterController = TextEditingController();
  }

  @override
  void dispose() {
    _letterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    _hasValidArgs = args is CoverLetter || (args is String && args.isNotEmpty);
    _cubit ??= _createCubit().._seed(args);

    return BlocProvider.value(
      value: _cubit!,
      child: BlocConsumer<CoverLettersCubit, CoverLettersState>(
        listener: (context, state) {
          _syncLetterContent(state.current);
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          final letter = state.current;
          final isLoading = state.status == CoverLettersStatus.loading;
          _syncLetterContent(letter);

          return Scaffold(
            appBar: AppBar(
              leading: const AppGradientBackButton(),
              title: Text('routes.coverLetterResult'.tr()),
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.coverLetterHistory),
                  icon: const Icon(Icons.history),
                ),
              ],
            ),
            body: SafeArea(
              child: !_hasValidArgs
                  ? _MissingCoverLetterMessage(
                      onGenerate: () =>
                          Navigator.of(context).pushReplacementNamed(
                        AppRoutes.coverLetterGenerator,
                      ),
                    )
                  : isLoading && letter == null
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          padding: EdgeInsets.all(AppSpacing.md.w),
                          children: [
                            Text(
                              letter?.title ??
                                  'coverLetter.result.subtitle'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    height: 1.35,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            ResultScoreCard(
                              score: letter?.score ?? 0,
                              description: letter?.insights.isNotEmpty == true
                                  ? letter!.insights.first.message
                                  : 'No AI review returned yet.',
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            ResultEditorCard(
                              title: letter?.title ?? 'Generated cover letter',
                              controller: _letterController,
                              isEditing: _isEditing,
                              onEditModeChanged: _setEditMode,
                              onCopy: _copyDraft,
                              onRegenerate: _regenerateDraft,
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            ResultActions(
                              insights: letter?.insights ?? const [],
                              onSaveDraft: () =>
                                  context.read<CoverLettersCubit>().saveDraft(
                                        _letterController.text,
                                      ),
                              onExportPdf: () => context
                                  .read<CoverLettersCubit>()
                                  .exportCurrent(),
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }

  void _setEditMode(bool editing) {
    setState(() => _isEditing = editing);
  }

  void _syncLetterContent(CoverLetter? letter) {
    if (letter == null) return;

    final syncKey = '${letter.id}:${letter.version}:${letter.content.hashCode}';
    if (_syncedLetterKey == syncKey) return;

    _syncedLetterKey = syncKey;
    _letterController.text = letter.content;
  }

  Future<void> _copyDraft() async {
    await Clipboard.setData(ClipboardData(text: _letterController.text));
    if (mounted) _showMessage('coverLetter.result.copied');
  }

  void _regenerateDraft() {
    final jobId = _cubit?.state.current?.jobId;
    if (jobId == null || jobId.isEmpty) return;
    _cubit?.generate(jobId);
  }

  void _showMessage(String key) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(key.tr())),
    );
  }
}

class _MissingCoverLetterMessage extends StatelessWidget {
  const _MissingCoverLetterMessage({required this.onGenerate});

  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.description_outlined,
              color: colors.primary,
              size: 44.sp,
            ),
            SizedBox(height: AppSpacing.md.h),
            Text(
              'No cover letter generated yet',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              'Generate a cover letter first, then it will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: AppSpacing.md.h),
            FilledButton(
              onPressed: onGenerate,
              child: const Text('Generate cover letter'),
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

extension on CoverLettersCubit {
  void _seed(Object? args) {
    if (args is CoverLetter) {
      setCurrent(args);
    } else if (args is String && args.isNotEmpty) {
      loadOne(args);
    }
  }
}
