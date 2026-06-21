import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_gradient_back_button.dart';
import '../../domain/entities/settings_preferences.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import 'settings_section.dart';

enum SettingsOptionValue { mentorTone, careerGoal }

class SettingsOption {
  const SettingsOption({
    required this.titleKey,
    required this.subtitleKey,
    required this.valueKey,
  });

  final String titleKey;
  final String subtitleKey;
  final String valueKey;
}

class SettingsOptionsView extends StatefulWidget {
  const SettingsOptionsView({
    required this.titleKey,
    required this.sectionIcon,
    required this.currentValue,
    required this.successKey,
    required this.options,
    super.key,
  });

  final String titleKey;
  final IconData sectionIcon;
  final SettingsOptionValue currentValue;
  final String successKey;
  final List<SettingsOption> options;

  @override
  State<SettingsOptionsView> createState() => _SettingsOptionsViewState();
}

class _SettingsOptionsViewState extends State<SettingsOptionsView> {
  String? _draftValueKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppGradientBackButton(),
        title: Text(context.tr(widget.titleKey)),
      ),
      bottomNavigationBar: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is! SettingsSuccess) return const SizedBox.shrink();
          final savedValueKey = _savedValueKey(state.preferences);
          final hasChanges =
              _draftValueKey != null && _draftValueKey != savedValueKey;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: CustomButton(
                labelKey: 'common.update',
                isLoading: state.isSubmitting,
                onPressed: hasChanges ? () => _updateSelection(context) : null,
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsSuccess) {
              final savedValueKey = _savedValueKey(state.preferences);

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  SettingsSection(
                    icon: widget.sectionIcon,
                    titleKey: widget.titleKey,
                    children: _optionTiles(context, savedValueKey),
                  ),
                ],
              );
            }

            if (state is SettingsError) {
              return AppErrorView(
                message: context.tr(state.messageKey),
                onRetry: context.read<SettingsCubit>().loadSettings,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  List<Widget> _optionTiles(BuildContext context, String savedValueKey) {
    final selectedValueKey = _draftValueKey ?? savedValueKey;

    return [
      for (var index = 0; index < widget.options.length; index++) ...[
        SettingsTile(
          titleKey: widget.options[index].titleKey,
          subtitleKey: widget.options[index].subtitleKey,
          trailing: selectedValueKey == widget.options[index].valueKey
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                )
              : const Icon(Icons.circle_outlined),
          onTap: () => _selectDraft(
            widget.options[index].valueKey,
            savedValueKey,
          ),
        ),
        if (index != widget.options.length - 1) const SettingsDivider(),
      ],
    ];
  }

  void _selectDraft(String valueKey, String savedValueKey) {
    setState(() {
      _draftValueKey = valueKey == savedValueKey ? null : valueKey;
    });
  }

  Future<void> _updateSelection(BuildContext context) async {
    final draftValueKey = _draftValueKey;
    if (draftValueKey == null) return;

    final cubit = context.read<SettingsCubit>();
    final updated = switch (widget.currentValue) {
      SettingsOptionValue.mentorTone =>
        await cubit.updateMentorTone(draftValueKey),
      SettingsOptionValue.careerGoal =>
        await cubit.updateCareerGoal(draftValueKey),
    };

    if (!context.mounted) return;
    if (!updated) {
      CustomSnackbar.showErrorKey(context: context, messageKey: 'common.error');
      return;
    }

    setState(() => _draftValueKey = null);
    CustomSnackbar.showSuccessKey(
      context: context,
      messageKey: widget.successKey,
    );
  }

  String _savedValueKey(SettingsPreferences preferences) {
    return switch (widget.currentValue) {
      SettingsOptionValue.mentorTone => preferences.mentorToneKey,
      SettingsOptionValue.careerGoal => preferences.careerGoalKey,
    };
  }
}
