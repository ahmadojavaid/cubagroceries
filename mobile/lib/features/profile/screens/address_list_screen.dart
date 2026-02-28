import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/address_model.dart';
import '../providers/address_provider.dart';

class AddressListScreen extends ConsumerStatefulWidget {
  const AddressListScreen({super.key});

  @override
  ConsumerState<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends ConsumerState<AddressListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(addressProvider.notifier).fetchAddresses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addressProvider);

    ref.listen<AddressState>(addressProvider, (prev, next) {
      if (next.error != null && prev?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
          ),
        );
        ref.read(addressProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () async {
          final result = await context.push('/addresses/add');
          if (result == true) {
            ref.read(addressProvider.notifier).fetchAddresses();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: state.isLoading && state.addresses.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.addresses.isEmpty
              ? _buildEmpty()
              : RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () =>
                      ref.read(addressProvider.notifier).fetchAddresses(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppDimens.pagePadding),
                    itemCount: state.addresses.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppDimens.sm),
                    itemBuilder: (context, index) {
                      return _AddressCard(
                        address: state.addresses[index],
                        onEdit: () async {
                          final result = await context.push(
                            '/addresses/${state.addresses[index].id}/edit',
                            extra: state.addresses[index],
                          );
                          if (result == true) {
                            ref
                                .read(addressProvider.notifier)
                                .fetchAddresses();
                          }
                        },
                        onDelete: () =>
                            _confirmDelete(state.addresses[index]),
                        onSetDefault: () => ref
                            .read(addressProvider.notifier)
                            .setDefault(state.addresses[index].id),
                      );
                    },
                  ),
                ),
    );
  }

  void _confirmDelete(AddressModel address) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text(
            'Are you sure you want to delete "${address.displayName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(addressProvider.notifier).deleteAddress(address.id);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off_outlined,
              size: 48, color: AppColors.textHint),
          const SizedBox(height: AppDimens.md),
          const Text('No addresses saved',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: AppDimens.sm),
          Text('Tap + to add your first address',
              style: TextStyle(
                  fontSize: 13, color: AppColors.textHint)),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const _AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(
          color: address.isDefault ? AppColors.primary : AppColors.border,
          width: address.isDefault ? 1.5 : 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: label + default badge
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 18, color: AppColors.primary),
              const SizedBox(width: AppDimens.xs),
              if (address.label != null)
                Text(
                  address.label!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
              const Spacer(),
              if (address.isDefault)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                  ),
                  child: const Text(
                    'Default',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppDimens.sm),

          // Address text
          Text(
            address.address,
            style: const TextStyle(
                fontSize: 14, color: AppColors.textSecondary, height: 1.4),
          ),
          if (address.city != null) ...[
            const SizedBox(height: 2),
            Text(address.city!,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
          ],
          if (address.phone != null) ...[
            const SizedBox(height: 2),
            Text(address.phone!,
                style:
                    const TextStyle(fontSize: 13, color: AppColors.textHint)),
          ],

          const SizedBox(height: AppDimens.sm),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: AppDimens.xs),

          // Actions
          Row(
            children: [
              if (!address.isDefault)
                _actionButton(Icons.star_outline, 'Set Default', onSetDefault),
              const Spacer(),
              _actionButton(Icons.edit_outlined, 'Edit', onEdit),
              const SizedBox(width: AppDimens.sm),
              _actionButton(Icons.delete_outline, 'Delete', onDelete,
                  color: AppColors.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap,
      {Color? color}) {
    final c = color ?? AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.sm, vertical: AppDimens.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: c),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 12, color: c)),
          ],
        ),
      ),
    );
  }
}
