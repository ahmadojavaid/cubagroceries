import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/address_model.dart';
import '../providers/address_provider.dart';
import 'map_picker_screen.dart';

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

  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.address?.label ?? '');
    _addressController =
        TextEditingController(text: widget.address?.address ?? '');
    _cityController = TextEditingController(text: widget.address?.city ?? '');
    _phoneController = TextEditingController(text: widget.address?.phone ?? '');
    _latitude = widget.address?.latitude;
    _longitude = widget.address?.longitude;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _openMapPicker() async {
    final result = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (_) => MapPickerScreen(
          initialLatitude: _latitude,
          initialLongitude: _longitude,
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _latitude = result.latitude;
        _longitude = result.longitude;
      });
    }
  }

  void _clearCoordinates() {
    setState(() {
      _latitude = null;
      _longitude = null;
    });
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
      'latitude': _latitude,
      'longitude': _longitude,
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

    final hasCoordinates = _latitude != null && _longitude != null;

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
              const SizedBox(height: AppDimens.lg),

              // ── Map Pin Location ──────────────────────────
              _buildLocationSection(hasCoordinates),
              const SizedBox(height: AppDimens.xl),

              // Save button
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(widget.isEditing ? 'Update Address' : 'Save Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection(bool hasCoordinates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pin Location',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Pin your exact location on the map so the rider can find you easily.',
          style: TextStyle(fontSize: 12, color: AppColors.textHint),
        ),
        const SizedBox(height: AppDimens.sm),
        if (hasCoordinates) ...[
          // Show coordinates + mini map preview
          Container(
            decoration: BoxDecoration(
              color: AppColors.primarySurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: AppColors.primary, width: 1),
            ),
            child: Column(
              children: [
                // Static map preview via coordinates
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppDimens.radiusMd - 1),
                  ),
                  child: SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_latitude!, _longitude!),
                        zoom: 16,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('pinned'),
                          position: LatLng(_latitude!, _longitude!),
                        ),
                      },
                      zoomControlsEnabled: false,
                      scrollGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      liteModeEnabled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${_latitude!.toStringAsFixed(6)}, ${_longitude!.toStringAsFixed(6)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      // Change button
                      GestureDetector(
                        onTap: _openMapPicker,
                        child: const Text(
                          'Change',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Remove button
                      GestureDetector(
                        onTap: _clearCoordinates,
                        child: const Icon(Icons.close_rounded,
                            size: 18, color: AppColors.error),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          // No coordinates — show button to pick
          OutlinedButton.icon(
            onPressed: _openMapPicker,
            icon: const Icon(Icons.map_rounded, size: 20),
            label: const Text('Pin on Map'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
            ),
          ),
        ],
      ],
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
