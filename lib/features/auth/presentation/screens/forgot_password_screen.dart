import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pathfinder_app/core/constants/app_assets.dart';
import 'package:pathfinder_app/features/auth/presentation/widgets/login_header.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/login_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendVerificationCode() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text('auth.verificationCodeSent'.tr(),
            style: AppTextStyles.bodyMedium(
                Theme.of(context).colorScheme.onPrimary)),
      ),
    );

    Navigator.pushNamed(context, AppRoutes.verifyEmail);
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
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.forgetPassword,
                      width: 120.w,
                      height: 120.h,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'auth.forgotPassword'.tr(),
                      style: AppTextStyles.headlineLarge(colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'auth.forgotPasswordSubtitle'.tr(),
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
                      'common.email'.tr(),
                      style: AppTextStyles.labelLarge(colorScheme.onSurface),
                    ),
                    SizedBox(height: 8.h),
                    LoginInputField(
                      controller: _emailController,
                      hint: 'name@example.com',
                      prefixIcon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              AppButton(
                label: 'auth.sendCode'.tr(),
                onPressed: _sendVerificationCode,
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.login,
                ),
                child: Text(
                  'auth.backToLogin'.tr(),
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
