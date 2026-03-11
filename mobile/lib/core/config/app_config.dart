/// App environment configuration
class AppConfig {
  // Toggle this for production builds
  static const bool isProduction = true;

  // API Base URLs
  static const String _prodBaseUrl = 'https://asifgroceries.pk/api/v1';
  static const String _devBaseUrl = 'https://10.0.2.2/api/v1';

  static String get baseUrl => isProduction ? _prodBaseUrl : _devBaseUrl;
  static String? get hostHeader => isProduction ? null : 'cubagroceries.test';
  static bool get trustSelfSigned => !isProduction;

  // Google Sign-In Web Client ID
  static const String googleWebClientId =
      '970803843908-1rvkl62d20kkrskg0qkfua9c8dts2kir.apps.googleusercontent.com';

  // GlitchTip / Sentry DSN
  static const String glitchtipDsn =
      'https://887bb9ba1d004606b06272f250f2b914@errors.zegobyte.com/3';

  static String get environment => isProduction ? 'production' : 'development';
}
