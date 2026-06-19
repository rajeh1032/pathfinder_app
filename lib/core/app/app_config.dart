class AppConfig {
  const AppConfig._();

  static const appName = 'PathFinder AI';
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://192.168.1.8:5000',
  );
  static const connectTimeout = Duration(seconds: 20);
  static const receiveTimeout = Duration(seconds: 20);
}
