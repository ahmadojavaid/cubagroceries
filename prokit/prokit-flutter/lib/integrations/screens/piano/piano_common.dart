import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Utility helper class for pitch and filename mapping.
class PianoHelper {
  static String noteToFileName(Pitch pitch) {
    final octave = pitch.value ~/ 12 + 1;
    final key = pitch.key.contains('#') ? pitch.key.replaceAll('#', '-') : pitch.key;
    return '$key$octave.mp3';
  }

  static Pitch mockPitchFromName(String note) {
    final match = RegExp(r'^([A-G])(-?#?)(\d)$').firstMatch(note);
    if (match == null) return Pitch('C', 48); // fallback

    final base = match.group(1)!;
    final accidental = match.group(2)!;
    final octave = int.parse(match.group(3)!);
    final key = accidental == '-' ? '$base#' : base;

    final midi = (octave - 1) * 12 + _keyToSemitone(key);
    return Pitch(key, midi);
  }

  static int _keyToSemitone(String key) {
    const map = {
      'C': 0, 'C#': 1, 'D': 2, 'D#': 3,
      'E': 4, 'F': 5, 'F#': 6, 'G': 7,
      'G#': 8, 'A': 9, 'A#': 10, 'B': 11,
    };
    return map[key] ?? 0;
  }
}

/// Simple wrapper around AudioPlayer to play notes by pitch.
class PianoAudioPlayer {
  Future<void> playNote(Pitch pitch) async {
    final fileName = PianoHelper.noteToFileName(pitch);
    final player = AudioPlayer();

    try {
      // Load audio file from assets as bytes
      final bytes = await rootBundle.load('images/piano/sounds/$fileName');
      await player.play(BytesSource(bytes.buffer.asUint8List()), volume: 1.0);

      Future.delayed(const Duration(seconds: 2), () => player.dispose());
    } catch (e) {
      debugPrint('Failed to play $fileName: $e');
    }
  }
}


/// Reusable note button used below the keyboard.
class NoteButton extends StatelessWidget {
  final String noteName;
  final void Function(String noteName) onTapDown;
  final void Function(String noteName) onTapUp;

  const NoteButton({
    super.key,
    required this.noteName,
    required this.onTapDown,
    required this.onTapUp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onTapDown(noteName),
      onTapUp: (_) => onTapUp(noteName),
      onTapCancel: () => onTapUp(noteName),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          noteName,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

/// Piano key widget used inside PianoWidget.keyBuilder.
class PianoKey extends StatelessWidget {
  final double width;
  final double height;
  final Pitch pitch;
  final bool isPressed;
  final VoidCallback onDown;
  final VoidCallback onUp;

  const PianoKey({
    super.key,
    required this.width,
    required this.height,
    required this.pitch,
    required this.isPressed,
    required this.onDown,
    required this.onUp,
  });

  @override
  Widget build(BuildContext context) {
    final isBlack = pitch.key.contains('#');

    return GestureDetector(
      onTapDown: (_) => onDown(),
      onTapUp: (_) => onUp(),
      onTapCancel: onUp,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isPressed
              ? Colors.red
              : (isBlack ? Colors.black : Colors.white),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
          ),
        ),
      ),
    );
  }
}

/// Optional logger class to help debug notes and audio.
class PianoDebug {
  static void logPitch(Pitch pitch) {
    debugPrint('Playing: ${pitch.key}, MIDI: ${pitch.value}');
  }

  static void logFile(String fileName) {
    debugPrint('Attempting to play file: $fileName');
  }
}



class Pitch {
  final String key; 
  final int value;

  Pitch(this.key, this.value);
}