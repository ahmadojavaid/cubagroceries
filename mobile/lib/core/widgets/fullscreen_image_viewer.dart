import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_network_image.dart';

/// Full-screen image viewer with pinch-to-zoom and swipe-to-dismiss.
///
/// Usage:
/// ```dart
/// FullscreenImageViewer.open(context, imageUrl: '...', heroTag: 'product_1');
/// ```
class FullscreenImageViewer extends StatefulWidget {
  final String? imageUrl;
  final String? heroTag;

  const FullscreenImageViewer({
    super.key,
    required this.imageUrl,
    this.heroTag,
  });

  /// Convenience method to push the viewer
  static void open(
    BuildContext context, {
    required String? imageUrl,
    String? heroTag,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) return;

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FullscreenImageViewer(
            imageUrl: imageUrl,
            heroTag: heroTag,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenImageViewer> {
  final _transformationController = TransformationController();
  double _dragOffset = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      _dragOffset += details.delta.dy;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset.abs() > 100 ||
        details.velocity.pixelsPerSecond.dy.abs() > 800) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _isDragging = false;
        _dragOffset = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final opacity = _isDragging
        ? (1.0 - (_dragOffset.abs() / 400)).clamp(0.3, 1.0)
        : 1.0;

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: opacity),
      body: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: Stack(
          children: [
            Center(
              child: Transform.translate(
                offset: Offset(0, _dragOffset),
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: widget.heroTag != null
                      ? Hero(
                          tag: widget.heroTag!,
                          child: _buildImage(),
                        )
                      : _buildImage(),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              right: 16,
              child: Material(
                color: Colors.black45,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AppNetworkImage(
      imageUrl: widget.imageUrl,
      width: double.infinity,
      fit: BoxFit.contain,
      placeholder: const Center(
        child: CircularProgressIndicator(
          color: Colors.white70,
          strokeWidth: 2,
        ),
      ),
      errorWidget: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Colors.white38,
          size: 48,
        ),
      ),
    );
  }
}
