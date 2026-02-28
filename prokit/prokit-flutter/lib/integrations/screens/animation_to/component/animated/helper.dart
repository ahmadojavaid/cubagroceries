import 'package:flutter/rendering.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/component/animated/action.dart';

/// cached values for calculation
class OffsetCache {
  OffsetCache({
    this.scrollLast,
    this.scrollOriginal,
    this.last,
  });

  final Offset? scrollLast;
  final Offset? scrollOriginal;
  final Offset? last;

  OffsetCache copyWith({
    Offset? scrollLast,
    Offset? scrollOriginal,
    Offset? last,
  }) =>
      OffsetCache(
        scrollLast: scrollLast ?? this.scrollLast,
        scrollOriginal: scrollOriginal ?? this.scrollOriginal,
        last: last ?? this.last,
      );
}

extension ProvideContextExt on List<MutationAction> {
  List<MutationAction> provided(PaintingContext context) => map(
        (mutation) =>
            mutation is PaintChild ? mutation.provide(context) : mutation,
      ).toList();
}
