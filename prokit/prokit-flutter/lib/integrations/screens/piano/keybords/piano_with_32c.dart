
import 'package:flutter/material.dart';
import 'package:prokit_flutter/integrations/screens/piano/component/piano_component.dart';
import 'package:prokit_flutter/integrations/screens/piano/piano_common.dart';

class PianoWith32c extends StatefulWidget {
  const PianoWith32c({super.key});

  @override
  State<PianoWith32c> createState() => _PianoWith32cState();
}

class _PianoWith32cState extends State<PianoWith32c> {
  final PianoAudioPlayer _audio = PianoAudioPlayer();
  final Set<String> _pressedNotes = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PianoWidget.keys32c(
          keyBuilder: (width, height, pitchMap) {
            final pitch = Pitch(pitchMap.key, pitchMap.value);
            final noteName = '${pitch.key}${pitch.value ~/ 12 + 1}';
            return PianoKey(
              width: width,
              height: height,
              pitch: pitch,
              isPressed: _pressedNotes.contains(noteName),
              onDown: () {
                setState(() => _pressedNotes.add(noteName));
                _audio.playNote(pitch);
              },
              onUp: () => setState(() => _pressedNotes.remove(noteName)),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
