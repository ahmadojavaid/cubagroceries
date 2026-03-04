import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../providers/auth_provider.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  String? _verificationId;
  bool _otpSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  String get _fullPhoneNumber {
    final phone = _phoneController.text.trim();
    if (phone.startsWith('+')) return phone;
    if (phone.startsWith('0')) return '+92${phone.substring(1)}';
    return '+92$phone';
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;

    await ref.read(authProvider.notifier).sendPhoneOtp(
      phoneNumber: _fullPhoneNumber,
      onCodeSent: (verificationId) {
        if (mounted) {
          setState(() {
            _verificationId = verificationId;
            _otpSent = true;
          });
        }
      },
      onError: (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: AppColors.error),
          );
        }
      },
    );
  }

  Future<void> _verifyOtp() async {
    if (_verificationId == null || _otpController.text.trim().length != 6) return;

    final success = await ref.read(authProvider.notifier).verifyPhoneOtp(
      verificationId: _verificationId!,
      smsCode: _otpController.text.trim(),
      phoneNumber: _fullPhoneNumber,
    );

    if (success && mounted) {
      final isRider = ref.read(authProvider).isRider;
      context.go(isRider ? '/rider-home' : '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/login'),
        ),
        title: const Text('Phone Login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_android_rounded,
                    size: 36,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                _otpSent ? 'Enter OTP' : 'Enter Phone Number',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _otpSent
                    ? 'We sent a 6-digit code to ${_phoneController.text}'
                    : 'We\'ll send you a verification code via SMS',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Error
              if (auth.error != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppDimens.md),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    border: Border.all(color: AppColors.error.withOpacity(0.15)),
                  ),
                  child: Text(
                    auth.error!,
                    style: TextStyle(color: AppColors.error, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              if (!_otpSent) ...[
                // Phone input
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '03001234567',
                    prefixIcon: Icon(Icons.phone_outlined, size: 20),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  onFieldSubmitted: (_) => _sendOtp(),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: auth.isLoading ? null : _sendOtp,
                    child: auth.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Send OTP'),
                  ),
                ),
              ] else ...[
                // OTP input
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 12,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'OTP Code',
                    hintText: '000000',
                    prefixIcon: Icon(Icons.lock_outline_rounded, size: 20),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onFieldSubmitted: (_) => _verifyOtp(),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: auth.isLoading ? null : _verifyOtp,
                    child: auth.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Verify & Sign In'),
                  ),
                ),
                const SizedBox(height: 16),

                // Resend / Change number
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: auth.isLoading
                          ? null
                          : () => setState(() {
                                _otpSent = false;
                                _verificationId = null;
                                _otpController.clear();
                              }),
                      child: const Text('Change Number'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: auth.isLoading ? null : _sendOtp,
                      child: const Text('Resend OTP'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
