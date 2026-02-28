// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'otp_resend_time.g.dart';

class OtpResendTimer = _OtpResendTimer with _$OtpResendTimer;

abstract class _OtpResendTimer with Store {
  @observable
  int time = 60;
}
