import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/custom_button.dart';

class CvPdfViewerScreen extends StatefulWidget {
  const CvPdfViewerScreen({
    required this.url,
    required this.title,
    super.key,
  });

  final String url;
  final String title;

  @override
  State<CvPdfViewerScreen> createState() => _CvPdfViewerScreenState();
}

class _CvPdfViewerScreenState extends State<CvPdfViewerScreen> {
  late final WebViewController _controller;
  var _progress = 0;
  var _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) setState(() => _progress = progress);
          },
          onPageStarted: (_) {
            if (mounted) setState(() => _hasError = false);
          },
          onWebResourceError: (error) {
            if (error.isForMainFrame == false || !mounted) return;
            setState(() => _hasError = true);
          },
        ),
      )
      ..loadRequest(_viewerUri(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title.trim().isEmpty
        ? 'routes.cvPdfViewer'.tr()
        : widget.title.trim();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'common.retry'.tr(),
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _reload,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_progress < 100 && !_hasError)
              LinearProgressIndicator(value: _progress / 100),
            Expanded(
              child: _hasError
                  ? _ViewerError(onRetry: _reload)
                  : WebViewWidget(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }

  void _reload() {
    setState(() {
      _hasError = false;
      _progress = 0;
    });
    _controller.loadRequest(_viewerUri(widget.url));
  }

  Uri _viewerUri(String fileUrl) {
    return Uri.https('docs.google.com', '/gview', {
      'embedded': '1',
      'url': fileUrl,
    });
  }
}

class _ViewerError extends StatelessWidget {
  const _ViewerError({required this.onRetry});

  final VoidCallback onRetry;

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
              Icons.picture_as_pdf_outlined,
              size: 56.sp,
              color: colors.error,
            ),
            SizedBox(height: AppSpacing.md.h),
            Text(
              'cvHistory.openError'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge(colors.onSurface),
            ),
            SizedBox(height: AppSpacing.lg.h),
            CustomButton(
              labelKey: 'common.retry',
              icon: Icons.refresh_rounded,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
