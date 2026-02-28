import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/address_model.dart';
import '../providers/address_provider.dart';

class AddressFormScreen extends ConsumerStatefulWidget {
  final AddressModel? address; // null = add mode, non-null = edit mode

  const AddressFormScreen({super.key, this.address});

  bool get isEditing => address != null;

  @override
  ConsumerState<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends ConsumerState<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _labelController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _phoneController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.address?.label ?? '');
    _addressController =
        TextEditingController(text: widget.address?.address ?? '');
    _cityController = TextEditingController(text: widget.address?.city ?? '');
    _phoneController = TextEditingController(text: widget.address?.phone ?? '');
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final data = {
      'label': _labelController.text.trim().isEmpty
          ? null
          : _labelController.text.trim(),
      'address': _addressController.text.trim(),
      'city': _cityController.text.trim().isEmpty
          ? null
          : _cityController.text.trim(),
      'phone': _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
    };

    final notifier = ref.read(addressProvider.notifier);
    final success = widget.isEditing
        ? await notifier.updateAddress(widget.address!.id, data)
        : await notifier.addAddress(data);

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isEditing ? 'Address updated' : 'Address added'),
        ),
      );
      context.pop(true); // return true to trigger refresh in list
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen for provider errors
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
        title: Text(widget.isEditing ? 'Edit Address' : 'Add Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Label
              TextFormField(
                controller: _labelController,
                decoration: _inputDecoration(
                  label: 'Label',
                  hint: 'e.g., Home, Office',
                  icon: Icons.label_outline,
                ),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppDimens.md),

              // Address (required)
              TextFormField(
                controller: _addressController,
                decoration: _inputDecoration(
                  label: 'Address',
                  hint: 'Full street address',
                  icon: Icons.location_on_outlined,
                ),
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimens.md),

              // City
              TextFormField(
                controller: _cityController,
                decoration: _inputDecoration(
                  label: 'City',
                  hint: 'e.g., Lahore',
                  icon: Icons.location_city_outlined,
                ),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppDimens.md),

              // Phone
              TextFormField(
                controller: _phoneController,
                decoration: _inputDecoration(
                  label: 'Phone',
                  hint: 'e.g., 03001234567',
                  icon: Icons.phone_outlined,
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppDimens.xl),

              // Save button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(widget.isEditing ? 'Update Address' : 'Save Address'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
      ),
    );
  }
}
