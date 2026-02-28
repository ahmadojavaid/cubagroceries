import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Utility class for launching external apps (Google Maps, WhatsApp).
class LauncherUtils {
  LauncherUtils._();

  /// Opens Google Maps with turn-by-turn navigation to the given coordinates.
  /// Falls back to a search query if lat/lng are null.
  static Future<bool> openGoogleMaps({
    double? latitude,
    double? longitude,
    String? addressFallback,
    BuildContext? context,
  }) async {
    String url;

    if (latitude != null && longitude != null) {
      // Direct navigation with coordinates
      url = 'google.navigation:q=$latitude,$longitude&mode=d';
    } else if (addressFallback != null && addressFallback.isNotEmpty) {
      // Search by address text
      final encoded = Uri.encodeComponent(addressFallback);
      url = 'geo:0,0?q=$encoded';
    } else {
      _showSnackbar(context, 'No address or coordinates available.');
      return false;
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return true;
    }

    // Fallback to Google Maps web URL
    final webUrl = latitude != null && longitude != null
        ? 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving'
        : 'https://www.google.com/maps/search/${Uri.encodeComponent(addressFallback ?? '')}';

    final webUri = Uri.parse(webUrl);
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
      return true;
    }

    _showSnackbar(context, 'Could not open Google Maps.');
    return false;
  }

  /// Opens WhatsApp chat with the given phone number.
  /// Phone should be in local format (e.g., 03001234567).
  /// Converts to international format (e.g., 923001234567).
  static Future<bool> openWhatsApp({
    required String phone,
    String? message,
    BuildContext? context,
  }) async {
    // Convert Pakistani local format to international
    String internationalPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (internationalPhone.startsWith('0')) {
      internationalPhone = '92${internationalPhone.substring(1)}';
    } else if (!internationalPhone.startsWith('+') &&
        !internationalPhone.startsWith('92')) {
      internationalPhone = '92$internationalPhone';
    }
    internationalPhone = internationalPhone.replaceAll('+', '');

    final msgParam = message != null ? '&text=${Uri.encodeComponent(message)}' : '';
    final url = 'https://wa.me/$internationalPhone?$msgParam';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return true;
    }

    _showSnackbar(context, 'Could not open WhatsApp.');
    return false;
  }

  static void _showSnackbar(BuildContext? context, String message) {
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
