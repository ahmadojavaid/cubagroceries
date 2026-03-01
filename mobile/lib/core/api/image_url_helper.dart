import '../config/app_config.dart';

/// Rewrites image URLs from the API to work in the current environment.
///
/// In development: API returns `https://cubagroceries.test/storage/...`
/// but the emulator connects via `https://10.0.2.2` with a Host header.
///
/// In production: URLs already point to the correct domain, no rewrite needed.
class ImageUrlHelper {
  static const String _apiHost = 'cubagroceries.test';
  static const String _emulatorHost = '10.0.2.2';

  /// Rewrite a single image URL for the current environment.
  /// Returns null if input is null.
  static String? rewrite(String? url) {
    if (url == null || url.isEmpty) return null;
    if (AppConfig.isProduction) return url;
    return url.replaceFirst(_apiHost, _emulatorHost);
  }
}
