import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../theme/app_colors.dart';

/// Custom cache manager that sends the Host header for Herd .test domains.
class _HerdCacheManager extends CacheManager {
  static const key = 'herdImageCache';
  static final _instance = _HerdCacheManager._();

  factory _HerdCacheManager() => _instance;

  _HerdCacheManager._()
      : super(Config(
          key,
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 200,
          fileService: _HerdHttpFileService(),
        ));
}

class _HerdHttpFileService extends FileService {
  final HttpClient _httpClient;

  _HerdHttpFileService()
      : _httpClient = HttpClient()
          ..badCertificateCallback = (cert, host, port) => true;

  @override
  Future<FileServiceResponse> get(String url,
      {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final request = await _httpClient.getUrl(uri);

    // Add Host header for emulator → Herd routing
    request.headers.set('Host', 'cubagroceries.test');

    if (headers != null) {
      headers.forEach((key, value) {
        request.headers.set(key, value);
      });
    }

    final response = await request.close();

    return HttpGetResponse(HttpFileServiceResponse(response));
  }
}

class HttpFileServiceResponse extends FileServiceResponse {
  final HttpClientResponse _response;

  HttpFileServiceResponse(this._response);

  @override
  Stream<List<int>> get content => _response;

  @override
  int? get contentLength => _response.contentLength;

  @override
  String get eTag => _response.headers.value('etag') ?? '';

  @override
  String get fileExtension {
    final contentType = _response.headers.contentType;
    if (contentType != null) {
      switch (contentType.subType) {
        case 'jpeg':
        case 'jpg':
          return '.jpg';
        case 'png':
          return '.png';
        case 'gif':
          return '.gif';
        case 'webp':
          return '.webp';
      }
    }
    return '.jpg';
  }

  @override
  int get statusCode => _response.statusCode;

  @override
  DateTime get validTill {
    final cacheControl = _response.headers.value('cache-control');
    if (cacheControl != null && cacheControl.contains('max-age=')) {
      final maxAge = int.tryParse(
          cacheControl.split('max-age=').last.split(',').first.trim());
      if (maxAge != null) {
        return DateTime.now().add(Duration(seconds: maxAge));
      }
    }
    return DateTime.now().add(const Duration(days: 7));
  }
}

/// App-wide network image widget that handles Herd self-signed certs.
class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return errorWidget ?? _defaultError();
    }

    final image = CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      cacheManager: _HerdCacheManager(),
      placeholder: (_, __) =>
          placeholder ??
          Container(
            color: AppColors.surfaceBg,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      errorWidget: (_, __, ___) => errorWidget ?? _defaultError(),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }

  Widget _defaultError() {
    return Container(
      width: width,
      height: height,
      color: AppColors.primarySurface,
      child: const Icon(Icons.image_outlined,
          size: 32, color: AppColors.primaryLight),
    );
  }
}
