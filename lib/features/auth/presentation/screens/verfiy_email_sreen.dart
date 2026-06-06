import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/core/constants/app_assets.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/login_header.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/login_form.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _sendVerificationCode() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    Navigator.pushNamed(context, AppRoutes.changePassword);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginHeader(),
              SizedBox(height: 32.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.verifyEmail,
                      width: 120.w,
                      height: 120.h,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'auth.verfiyEmail'.tr(),
                      style: AppTextStyles.headlineLarge(colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'auth.verfiyEmailSubtitle'.tr(),
                      style: AppTextStyles.bodyMedium(
                          colorScheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'auth.verfiyCode'.tr(),
                      style: AppTextStyles.labelLarge(colorScheme.onSurface),
                    ),
                    SizedBox(height: 8.h),
                    LoginInputField(
                      controller: _codeController,
                      hint: '0000',
                      prefixIcon: Icons.numbers,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Code is required';
                        }
                       
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              AppButton(
                label: 'auth.verfiy'.tr(),
                onPressed: _sendVerificationCode,
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'auth.resendCode'.tr(),
                  style: AppTextStyles.bodyMedium(colorScheme.primary)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
