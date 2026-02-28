import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TexturedNumber extends StatelessWidget {
  final int number;
  final String textureUrl;

  const TexturedNumber({
    super.key,
    required this.number,
    required this.textureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: loadNetworkImage(textureUrl),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final image = snapshot.data!;
        final paintShader = Paint()
          ..shader = ImageShader(
            image,
            TileMode.repeated,
            TileMode.repeated,
            Matrix4.identity().storage,
          );
        return Stack(
          children: [
            Text(
              '$number',
              style: GoogleFonts.roboto(
                fontSize: 90,
                fontWeight: FontWeight.w700,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.white,
              ),
            ),
            Text(
              '$number',
              style: GoogleFonts.roboto(
                fontSize: 90,
                fontWeight: FontWeight.w700,
                foreground: paintShader,
              ),
            ),
          ],
        );
      },
    );
  }
  Future<ui.Image> loadNetworkImage(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to load image from network');
    }

    final Uint8List bytes = response.bodyBytes;
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }
}
