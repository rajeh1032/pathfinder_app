import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../cubit/jobs_cubit.dart';
import '../../cubit/jobs_state.dart';

class JobSearchField extends StatefulWidget {
  const JobSearchField({super.key});

  @override
  State<JobSearchField> createState() => _JobSearchFieldState();
}

class _JobSearchFieldState extends State<JobSearchField> {
  late final TextEditingController _controller;
  bool _isSyncingFromState = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_isSyncingFromState) return;
    context.read<JobsCubit>().updateSearch(_controller.text);
  }

  void _syncController(String value) {
    if (_controller.text == value) return;
    _isSyncingFromState = true;
    _controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    _isSyncingFromState = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobsCubit, JobsState>(
      listenWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery,
      listener: (_, state) => _syncController(state.searchQuery),
      buildWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery,
      builder: (context, state) {
        final colors = Theme.of(context).colorScheme;

        return Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md.r),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(alpha: .06),
                blurRadius: 22,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
            decoration: InputDecoration(
              hintText: 'jobs.matching.searchHint'.tr(),
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
              prefixIcon: Icon(
                Icons.search,
                color: colors.onSurfaceVariant,
                size: 22.sp,
              ),
              suffixIcon: state.searchQuery.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear',
                      onPressed: () => context.read<JobsCubit>().clearSearch(),
                      icon: Icon(
                        Icons.close,
                        color: colors.onSurfaceVariant,
                        size: 20.sp,
                      ),
                    ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: 18.h,
              ),
            ),
          ),
        );
      },
    );
  }
}
