import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading.dart';
import '../cubit/interview_result_cubit.dart';
import '../widgets/interview_result_content.dart';

class InterviewResultScreen extends StatefulWidget {
  const InterviewResultScreen({this.sessionId, super.key});

  final String? sessionId;

  @override
  State<InterviewResultScreen> createState() => _InterviewResultScreenState();
}

class _InterviewResultScreenState extends State<InterviewResultScreen> {
  late final InterviewResultCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<InterviewResultCubit>();
    _cubit.loadResult(widget.sessionId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          title: Text('interview.assessmentResults'.tr()),
        ),
        body: SafeArea(
          child: BlocBuilder<InterviewResultCubit, InterviewResultState>(
            builder: (context, state) {
              if (state.isLoading && !state.hasResult) {
                return const AppLoading();
              }

              if (state.errorMessage != null && !state.hasResult) {
                return AppErrorView(
                  message: state.errorMessage,
                  onRetry: () => _cubit.loadResult(widget.sessionId),
                );
              }

              final result = state.result;
              if (result == null) {
                return AppErrorView(
                  onRetry: () => _cubit.loadResult(widget.sessionId),
                );
              }

              return InterviewResultContent(result: result);
            },
          ),
        ),
      ),
    );
  }
}
