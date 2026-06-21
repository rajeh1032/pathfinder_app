class AppConfig {
  const AppConfig._();

  static const appName = 'PathFinder AI';
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://pathfinder-backend-mwlr.onrender.com',

  );

  static const connectTimeout = Duration(seconds: 20);
  static const receiveTimeout = Duration(seconds: 20);
}
