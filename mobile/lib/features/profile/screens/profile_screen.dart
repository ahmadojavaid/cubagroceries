import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../data/user_model.dart';

/// Whether the current user is a rider (hides customer-specific UI)
bool _isRider(WidgetRef ref) {
  return ref.watch(isRiderProvider);
}

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isEditing = false;

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(profileProvider.notifier).fetchProfile(),
    );
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _populateFields() {
    final user = ref.read(profileProvider).user;
    if (user != null) {
      _firstnameController.text = user.firstname;
      _lastnameController.text = user.lastname;
      _emailController.text = user.email;
      _dobController.text = _formatDateForEdit(user.dateOfBirth);
    }
  }

  void _toggleEdit() {
    if (!_isEditing) _populateFields();
    setState(() => _isEditing = !_isEditing);
  }

  Future<void> _saveProfile() async {
    final success = await ref.read(profileProvider.notifier).updateProfile(
          firstname: _firstnameController.text.trim(),
          lastname: _lastnameController.text.trim(),
          email: _emailController.text.trim(),
          dateOfBirth: _dobController.text.trim().isEmpty
              ? null
              : _dobController.text.trim(),
        );

    if (success && mounted) {
      setState(() => _isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  /// Format ISO date string to human-readable
  String _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    try {
      final date = DateTime.parse(raw);
      return DateFormat('d MMM, yyyy').format(date);
    } catch (_) {
      return raw;
    }
  }

  /// Format for edit field (YYYY-MM-DD)
  String _formatDateForEdit(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    try {
      final date = DateTime.parse(raw);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (_) {
      return raw;
    }
  }

  /// Get initials from name
  String _initials(UserModel user) {
    final f = user.firstname.isNotEmpty ? user.firstname[0] : '';
    final l = user.lastname.isNotEmpty ? user.lastname[0] : '';
    return '$f$l'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);

    ref.listen<ProfileState>(profileProvider, (prev, next) {
      if (next.error != null && prev?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(profileProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: state.isLoading && state.user == null
          ? const Center(child: CircularProgressIndicator())
          : state.user == null
              ? _buildEmpty()
              : RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () =>
                      ref.read(profileProvider.notifier).fetchProfile(),
                  child: _buildContent(state),
                ),
    );
  }

  Widget _buildContent(ProfileState state) {
    final user = state.user!;
    final rider = _isRider(ref);

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // ── Header with avatar + name + wallet ──
        _buildProfileHeader(user, showWallet: !rider),

        const SizedBox(height: AppDimens.lg),

        // ── Personal Info or Edit Form ──
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: _isEditing
              ? _buildEditForm(state.isLoading)
              : _buildPersonalInfo(user),
        ),

        const SizedBox(height: AppDimens.lg),

        // ── Menu Section ──
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: _buildMenuSection(isRider: rider),
        ),

        const SizedBox(height: AppDimens.xxl),
      ],
    );
  }

  /// Gradient header with avatar, name and wallet
  Widget _buildProfileHeader(UserModel user, {bool showWallet = true}) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppDimens.lg,
        bottom: AppDimens.lg,
        left: AppDimens.pagePadding,
        right: AppDimens.pagePadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryDark,
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: Column(
        children: [
          // Top bar with edit action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Profile',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Material(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                child: InkWell(
                  onTap: _toggleEdit,
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      _isEditing ? Icons.close_rounded : Icons.edit_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimens.lg),

          // Avatar + Name row
          Row(
            children: [
              // Avatar circle with initials
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    _initials(user),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.md),
              // Name + email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (showWallet) ...[
            const SizedBox(height: AppDimens.lg),

            // Wallet card — tappable
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.push('/wallet'),
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.md,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppDimens.sm + 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wallet Balance',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.6),
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Rs. ${user.walletAmount}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white.withValues(alpha: 0.5),
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Personal info card
  Widget _buildPersonalInfo(UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 0.3,
              ),
        ),
        const SizedBox(height: AppDimens.sm + 2),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _infoTile(
                Icons.phone_outlined,
                'Phone',
                user.identity,
                isFirst: true,
              ),
              _divider(),
              _infoTile(
                Icons.cake_outlined,
                'Date of Birth',
                _formatDate(user.dateOfBirth),
              ),
              _divider(),
              _infoTile(
                Icons.email_outlined,
                'Email',
                user.email,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoTile(IconData icon, String label, String value,
      {bool isFirst = false, bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.md,
        vertical: 14,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primarySurface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: AppDimens.md - 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textHint,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isNotEmpty ? value : '—',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 38 + AppDimens.md + AppDimens.md - 2),
      child: Container(
        height: 0.5,
        color: AppColors.divider,
      ),
    );
  }

  /// Menu section — grouped card
  Widget _buildMenuSection({bool isRider = false}) {
    final menuItems = <Widget>[];

    if (!isRider) {
      menuItems.add(_menuItem(
        icon: Icons.location_on_outlined,
        title: 'My Addresses',
        subtitle: 'Manage delivery addresses',
        onTap: () => context.push('/addresses'),
        isFirst: true,
        isLast: false,
      ));
      menuItems.add(_menuDivider());
      menuItems.add(_menuItem(
        icon: Icons.chat_bubble_outline_rounded,
        title: 'My Complaints',
        subtitle: 'View or file complaints',
        onTap: () => context.push('/complaints'),
      ));
      menuItems.add(_menuDivider());
    }

    menuItems.add(_menuItem(
      icon: Icons.settings_outlined,
      title: 'Settings',
      subtitle: 'Password, FAQs & more',
      onTap: () => context.push('/settings'),
      isFirst: isRider, // first item when rider (no address/complaints above)
      isLast: true,
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 0.3,
              ),
        ),
        const SizedBox(height: AppDimens.sm + 2),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: menuItems),
        ),
      ],
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(AppDimens.radiusLg) : Radius.zero,
          bottom:
              isLast ? const Radius.circular(AppDimens.radiusLg) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.md,
            vertical: 14,
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.accentLight.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: AppColors.accentDark),
              ),
              const SizedBox(width: AppDimens.md - 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textHint,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 38 + AppDimens.md + AppDimens.md - 2),
      child: Container(height: 0.5, color: AppColors.divider),
    );
  }

  /// Edit form
  Widget _buildEditForm(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 0.3,
              ),
        ),
        const SizedBox(height: AppDimens.sm + 2),
        Container(
          padding: const EdgeInsets.all(AppDimens.md + 4),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _textField(_firstnameController, 'First Name',
                  icon: Icons.person_outline),
              const SizedBox(height: AppDimens.md),
              _textField(_lastnameController, 'Last Name',
                  icon: Icons.person_outline),
              const SizedBox(height: AppDimens.md),
              _textField(_emailController, 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: AppDimens.md),
              _dateField(_dobController, 'Date of Birth',
                  icon: Icons.cake_outlined),
              const SizedBox(height: AppDimens.lg),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _saveProfile,
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textField(TextEditingController controller, String label,
      {TextInputType? keyboardType, IconData? icon}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null
            ? Icon(icon, size: 20, color: AppColors.textSecondary)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
      ),
    );
  }

  Widget _dateField(TextEditingController controller, String label,
      {IconData? icon}) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final now = DateTime.now();
        DateTime initial;
        try {
          initial = DateTime.parse(controller.text);
        } catch (_) {
          initial = DateTime(2000, 1, 1);
        }
        final picked = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: DateTime(1940),
          lastDate: now,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primary,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null
            ? Icon(icon, size: 20, color: AppColors.textSecondary)
            : null,
        suffixIcon: const Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.textHint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_off_outlined,
                  size: 36, color: AppColors.textHint),
            ),
            const SizedBox(height: AppDimens.lg),
            const Text(
              'Could not load profile',
              style: TextStyle(
                  fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppDimens.lg),
            OutlinedButton.icon(
              onPressed: () =>
                  ref.read(profileProvider.notifier).fetchProfile(),
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
