class RouteArguments {
  const RouteArguments({this.id, this.payload});

  final String? id;
  final Object? payload;
}

/// Arguments passed to [SetupProfileScreen] from the register screen.
class SetupProfileArgs {
  const SetupProfileArgs({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String email;
  final String password;
  final String confirmPassword;
}

class CvPdfViewerArgs {
  const CvPdfViewerArgs({required this.url, required this.title});

  final String url;
  final String title;
}
