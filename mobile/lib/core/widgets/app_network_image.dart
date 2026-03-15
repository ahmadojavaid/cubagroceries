import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../theme/app_colors.dart';

/// App-wide network image widget that handles:
/// - Herd self-signed SSL certs (dev only)
/// - Host header for emulator → Herd routing (dev only)
/// - Production: standard HTTPS image loading via Image.network
class AppNetworkImage extends StatefulWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage> {
  // Only used in dev mode for self-signed certs + Host header
  static final HttpClient _devClient = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  /// Simple in-memory cache for dev mode
  static final Map<String, Uint8List> _devCache = {};

  Uint8List? _imageBytes;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    if (!AppConfig.isProduction) {
      _loadImageDev();
    }
  }

  @override
  void didUpdateWidget(covariant AppNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl && !AppConfig.isProduction) {
      _loadImageDev();
    }
  }

  /// Dev-only: uses custom HttpClient for self-signed certs
  Future<void> _loadImageDev() async {
    final url = widget.imageUrl;
    if (url == null || url.isEmpty) {
      if (mounted) setState(() { _loading = false; _error = true; });
      return;
    }

    if (_devCache.containsKey(url)) {
      if (mounted) setState(() { _imageBytes = _devCache[url]; _loading = false; });
      return;
    }

    try {
      final uri = Uri.parse(url);
      final request = await _devClient.getUrl(uri);
      if (AppConfig.hostHeader != null) {
        request.headers.set('Host', AppConfig.hostHeader!);
      }
      final response = await request.close();

      if (response.statusCode == 200) {
        final bytes = await _consolidate(response);
        _devCache[url] = bytes;
        if (mounted) setState(() { _imageBytes = bytes; _loading = false; });
      } else {
        if (mounted) setState(() { _loading = false; _error = true; });
      }
    } catch (e) {
      debugPrint('AppNetworkImage dev error: $e');
      if (mounted) setState(() { _loading = false; _error = true; });
    }
  }

  Future<Uint8List> _consolidate(HttpClientResponse response) async {
    final builder = BytesBuilder(copy: false);
    await for (final chunk in response) {
      builder.add(chunk);
    }
    return builder.takeBytes();
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.imageUrl;

    // No URL — show error
    if (url == null || url.isEmpty) {
      return widget.errorWidget ?? _defaultError();
    }

    // Production: use standard Image.network (handles concurrency properly)
    if (AppConfig.isProduction) {
      return Image.network(
        url,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return widget.placeholder ?? _defaultPlaceholder();
        },
        errorBuilder: (_, _, _) => widget.errorWidget ?? _defaultError(),
      );
    }

    // Dev: use custom HttpClient loaded bytes
    if (_loading) {
      return widget.placeholder ?? _defaultPlaceholder();
    }

    if (_error || _imageBytes == null) {
      return widget.errorWidget ?? _defaultError();
    }

    return Image.memory(
      _imageBytes!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      errorBuilder: (_, _, _) => widget.errorWidget ?? _defaultError(),
    );
  }

  Widget _defaultPlaceholder() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: AppColors.surfaceBg,
      child: const Center(
        child: SizedBox(
          width: 20, height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _defaultError() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: AppColors.primarySurface,
      child: const Icon(Icons.image_outlined, size: 32, color: AppColors.primaryLight),
    );
  }
}
