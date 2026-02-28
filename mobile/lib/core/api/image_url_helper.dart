/// Rewrites image URLs from the API to work on the Android emulator.
///
/// The API returns `https://cubagroceries.test/storage/...`
/// but the emulator connects via `https://10.0.2.2` with a Host header.
/// CachedNetworkImage doesn't send that Host header, so we need to
/// rewrite URLs to use the emulator-accessible host.
class ImageUrlHelper {
  static const String _apiHost = 'cubagroceries.test';
  static const String _emulatorHost = '10.0.2.2';

  /// Rewrite a single image URL for emulator access.
  /// Returns null if input is null.
  static String? rewrite(String? url) {
    if (url == null || url.isEmpty) return null;
    return url.replaceFirst(_apiHost, _emulatorHost);
  }
}
