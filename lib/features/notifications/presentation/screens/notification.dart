
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/core/theme/app_text_styles.dart';

import '../../../../../core/theme/app_colors.dart';
import '../widgets/notification_card.dart';
import 'dummy_data_model.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationTab _selectedTab = NotificationTab.all;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final notifications = NotificationDummyData.filtered(_selectedTab);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PathFinder AI',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Text(
              'notifications.title'.tr(),
              style: AppTextStyles.header600Blue28(colorScheme.onSurface),
            ),
          ),
          // Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: NotificationTab.values.map((tab) {
                final isSelected = _selectedTab == tab;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTab = tab),
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Text(
                      _tabLabel(tab),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16.h),
          // Notifications list
          Expanded(
            child: notifications.isEmpty
                ? Center(
              child: Text(
                'No notifications',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: notifications.length,
              itemBuilder: (_, i) =>
                  NotificationCard(notification: notifications[i]),
            ),
          ),
        ],
      ),
    );
  }

  String _tabLabel(NotificationTab tab) {
    switch (tab) {
      case NotificationTab.all:
        return 'notifications.all'.tr();
      case NotificationTab.jobs:
        return 'notifications.jobs'.tr();
      case NotificationTab.learning:
        return 'notifications.learning'.tr();
    }
  }
}