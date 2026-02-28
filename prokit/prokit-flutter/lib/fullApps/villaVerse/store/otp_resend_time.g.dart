// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_brace_in_string_interps

part of 'otp_resend_time.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas,
// prefer_expression_function_bodies, lines_longer_than_80_chars,
// avoid_as, avoid_annotating_with_dynamic

mixin _$OtpResendTimer on _OtpResendTimer, Store {
  late final _$timeAtom = Atom(name: '_OtpResendTimer.time', context: context);

  @override
  int get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(int value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  @override
  String toString() {
    return '''
time: ${time}
    ''';
  }
}
