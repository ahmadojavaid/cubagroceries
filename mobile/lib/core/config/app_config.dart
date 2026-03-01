/// App environment configuration
class AppConfig {
  // Toggle this for production builds
  static const bool isProduction = false;

  // API Base URLs
  static const String _prodBaseUrl = 'https://cubagroceries.zegobyte.com/api/v1';
  static const String _devBaseUrl = 'https://10.0.2.2/api/v1';

  static String get baseUrl => isProduction ? _prodBaseUrl : _devBaseUrl;
  static String? get hostHeader => isProduction ? null : 'cubagroceries.test';
  static bool get trustSelfSigned => !isProduction;
}
