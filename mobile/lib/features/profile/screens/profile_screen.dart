import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../providers/profile_provider.dart';
import '../widgets/wallet_balance_card.dart';

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
      _dobController.text = user.dateOfBirth ?? '';
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
          dateOfBirth:
              _dobController.text.trim().isEmpty ? null : _dobController.text.trim(),
        );

    if (success && mounted) {
      setState(() => _isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);

    // Show error snackbar
    ref.listen<ProfileState>(profileProvider, (prev, next) {
      if (next.error != null && prev?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
          ),
        );
        ref.read(profileProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (state.user != null)
            IconButton(
              icon: Icon(_isEditing ? Icons.close : Icons.edit_outlined),
              onPressed: _toggleEdit,
            ),
        ],
      ),
      body: state.isLoading && state.user == null
          ? const Center(child: CircularProgressIndicator())
          : state.user == null
              ? _buildEmpty()
              : RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () =>
                      ref.read(profileProvider.notifier).fetchProfile(),
                  child: ListView(
                    padding: const EdgeInsets.all(AppDimens.pagePadding),
                    children: [
                      // Wallet card
                      WalletBalanceCard(amount: state.user!.walletAmount),
                      const SizedBox(height: AppDimens.lg),

                      // Profile info
                      if (_isEditing)
                        _buildEditForm(state.isLoading)
                      else
                        _buildProfileInfo(state.user!),

                      const SizedBox(height: AppDimens.lg),

                      // Quick links
                      _buildMenuTile(
                        icon: Icons.location_on_outlined,
                        title: 'My Addresses',
                        onTap: () => context.push('/addresses'),
                      ),
                      _buildMenuTile(
                        icon: Icons.chat_bubble_outline,
                        title: 'My Complaints',
                        onTap: () => context.push('/complaints'),
                      ),
                      _buildMenuTile(
                        icon: Icons.settings_outlined,
                        title: 'Settings',
                        onTap: () => context.push('/settings'),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileInfo(user) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          _infoRow(Icons.person_outline, 'Name', user.fullName),
          const Divider(height: 24, color: AppColors.divider),
          _infoRow(Icons.email_outlined, 'Email', user.email),
          const Divider(height: 24, color: AppColors.divider),
          _infoRow(Icons.phone_outlined, 'Phone', user.identity),
          if (user.dateOfBirth != null) ...[
            const Divider(height: 24, color: AppColors.divider),
            _infoRow(Icons.cake_outlined, 'Date of Birth', user.dateOfBirth!),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: AppDimens.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    fontSize: 15, color: AppColors.textPrimary)),
          ],
        ),
      ],
    );
  }

  Widget _buildEditForm(bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          _textField(_firstnameController, 'First Name'),
          const SizedBox(height: AppDimens.md),
          _textField(_lastnameController, 'Last Name'),
          const SizedBox(height: AppDimens.md),
          _textField(_emailController, 'Email',
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: AppDimens.md),
          _textField(_dobController, 'Date of Birth (YYYY-MM-DD)',
              keyboardType: TextInputType.datetime),
          const SizedBox(height: AppDimens.lg),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isLoading ? null : _saveProfile,
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(TextEditingController controller, String label,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.sm),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing:
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_off_outlined,
              size: 48, color: AppColors.textHint),
          const SizedBox(height: AppDimens.md),
          const Text('Could not load profile',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: AppDimens.md),
          TextButton(
            onPressed: () =>
                ref.read(profileProvider.notifier).fetchProfile(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
