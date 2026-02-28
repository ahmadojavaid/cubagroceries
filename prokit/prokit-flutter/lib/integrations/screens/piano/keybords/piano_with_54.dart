import 'package:prokit_flutter/integrations/screens/piano/component/piano_component.dart';
import 'package:prokit_flutter/integrations/screens/piano/piano_common.dart';
import 'package:flutter/material.dart';

class PianoWith54 extends StatefulWidget {
  const PianoWith54({super.key});

  @override
  State<PianoWith54> createState() => _PianoWith54State();
}

class _PianoWith54State extends State<PianoWith54> {
  final PianoAudioPlayer _audio = PianoAudioPlayer();
  final Set<String> _pressedNotes = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PianoWidget.keys54(
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
