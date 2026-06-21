import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/custom_button.dart';
import '../../domain/entities/courses_query.dart';

class CoursesFilterSheet extends StatefulWidget {
  const CoursesFilterSheet({required this.query, super.key});
  final CoursesQuery query;

  @override
  State<CoursesFilterSheet> createState() => _CoursesFilterSheetState();
}

class _CoursesFilterSheetState extends State<CoursesFilterSheet> {
  late final TextEditingController _category;
  late final TextEditingController _level;
  late final TextEditingController _provider;
  late final TextEditingController _language;
  late CourseSort _sort;
  bool? _isFree;

  @override
  void initState() {
    super.initState();
    _category = TextEditingController(text: widget.query.category);
    _level = TextEditingController(text: widget.query.level);
    _provider = TextEditingController(text: widget.query.provider);
    _language = TextEditingController(text: widget.query.language);
    _sort = widget.query.sort;
    _isFree = widget.query.isFree;
  }

  @override
  void dispose() {
    _category.dispose();
    _level.dispose();
    _provider.dispose();
    _language.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('courses.filters'.tr(),
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              _field(_category, 'courses.category'),
              _field(_level, 'courses.level'),
              _field(_provider, 'courses.provider'),
              _field(_language, 'courses.language'),
              DropdownButtonFormField<CourseSort>(
                initialValue: _sort,
                decoration: InputDecoration(labelText: 'courses.sort'.tr()),
                items: CourseSort.values
                    .map((sort) => DropdownMenuItem(
                          value: sort,
                          child: Text('courses.sortValues.${sort.name}'.tr()),
                        ))
                    .toList(growable: false),
                onChanged: (value) => setState(() => _sort = value ?? _sort),
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<bool?>(
                initialValue: _isFree,
                decoration:
                    InputDecoration(labelText: 'courses.priceFilter'.tr()),
                items: [
                  DropdownMenuItem(
                      value: null, child: Text('courses.all'.tr())),
                  DropdownMenuItem(
                      value: true, child: Text('courses.free'.tr())),
                  DropdownMenuItem(
                      value: false, child: Text('courses.paid'.tr())),
                ],
                onChanged: (value) => setState(() => _isFree = value),
              ),
              const SizedBox(height: AppSpacing.lg),
              CustomButton(
                labelKey: 'courses.applyFilters',
                onPressed: () => Navigator.pop(
                    context,
                    CoursesQuery(
                      q: widget.query.q,
                      limit: widget.query.limit,
                      category: _text(_category),
                      level: _text(_level),
                      provider: _text(_provider),
                      language: _text(_language),
                      isFree: _isFree,
                      sort: _sort,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String key) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: key.tr()),
        ),
      );

  String? _text(TextEditingController controller) =>
      controller.text.trim().isEmpty ? null : controller.text.trim();
}
