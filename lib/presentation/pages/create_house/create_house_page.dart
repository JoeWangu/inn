import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/create_house_controller.dart';
import 'package:inn/presentation/pages/create_house/widgets/image_selector_sheet.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/core/errors/error_handler.dart';

class CreateHousePage extends ConsumerStatefulWidget {
  final HouseModel? house;
  const CreateHousePage({super.key, this.house});

  @override
  ConsumerState<CreateHousePage> createState() => _CreateHousePageState();
}

class _CreateHousePageState extends ConsumerState<CreateHousePage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _categoryController = TextEditingController();
  final _unitsController = TextEditingController();

  bool _available = true;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    if (widget.house != null) {
      final h = widget.house!;
      _titleController.text = h.title ?? '';
      _priceController.text = h.price.toString();
      _descController.text = h.description ?? '';
      _categoryController.text = h.category ?? '';
      _unitsController.text = h.totalUnits.toString();
      _available = h.available;
      _isActive = h.isActive;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(createHouseControllerProvider.notifier).initializeForEdit(h);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _categoryController.dispose();
    _unitsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final state = ref.read(createHouseControllerProvider).asData?.value;
    if (state?.imageId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an image')));
      return;
    }

    final success = await ref
        .read(createHouseControllerProvider.notifier)
        .submit(
          houseId: widget.house?.id,
          title: _titleController.text,
          price: double.tryParse(_priceController.text) ?? 0.0,
          description: _descController.text,
          category: _categoryController.text,
          totalUnits: int.tryParse(_unitsController.text) ?? 1,
          available: _available,
          isActive: _isActive,
        );

    if (success && mounted) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property created successfully!')),
      );
    }
  }

  void _showImagePicker() async {
    final imageId = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ImageSelectorSheet(),
    );

    if (imageId != null) {
      ref.read(createHouseControllerProvider.notifier).setImage(imageId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(createHouseControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.house != null ? 'Edit Property' : 'Add New Property',
        ),
      ),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              getReadableError(err),
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ),
        data: (state) {
          if (state.isSubmitting) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Image Selection ---
                  InkWell(
                    onTap: _showImagePicker,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _buildImagePreview(
                        state,
                        Theme.of(context).colorScheme,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Basic Info ---
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Category'),
                    initialValue: _categoryController.text.isNotEmpty
                        ? _categoryController.text
                        : null,
                    items: const [
                      DropdownMenuItem(
                        value: "bedsitter",
                        child: Text("Bedsitter"),
                      ),
                      DropdownMenuItem(value: "single", child: Text("Single")),
                      DropdownMenuItem(value: "double", child: Text("Double")),
                      DropdownMenuItem(
                        value: "1 bedroom",
                        child: Text("1 Bedroom"),
                      ),
                      DropdownMenuItem(
                        value: "2 bedroom",
                        child: Text("2 Bedroom"),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        _categoryController.text = val;
                      }
                    },
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),

                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _unitsController,
                    decoration: const InputDecoration(labelText: 'Total Units'),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    "Location",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),

                  // --- Cascading Dropdowns ---
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Country'),
                    initialValue: state.countryId,
                    items: state.countries.map((c) {
                      return DropdownMenuItem<int>(
                        value: c.id,
                        child: Text(c.name ?? 'Unknown'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      ref
                          .read(createHouseControllerProvider.notifier)
                          .setCountry(val);
                    },
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  if (widget.house?.country != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(
                        "Current: ${widget.house!.country!.name}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'State'),
                    initialValue: state.stateId,
                    items: state.states.map((s) {
                      return DropdownMenuItem<int>(
                        value: s.id,
                        child: Text(s.name ?? 'Unknown'),
                      );
                    }).toList(),
                    onChanged: state.countryId == null
                        ? null
                        : (val) {
                            ref
                                .read(createHouseControllerProvider.notifier)
                                .setStateData(val);
                          },
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  if (widget.house?.state != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(
                        "Current: ${widget.house!.state!.name}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'City'),
                    initialValue: state.cityId,
                    items: state.cities.map((c) {
                      return DropdownMenuItem<int>(
                        value: c.id,
                        child: Text(c.name ?? 'Unknown'),
                      );
                    }).toList(),
                    onChanged: state.stateId == null
                        ? null
                        : (val) {
                            ref
                                .read(createHouseControllerProvider.notifier)
                                .setCity(val);
                          },
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  if (widget.house?.city != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(
                        "Current: ${widget.house!.city!.name}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Neighborhood',
                    ),
                    initialValue: state.neighborhoodId,
                    items: state.neighborhoods.map((n) {
                      return DropdownMenuItem<int>(
                        value: n.id,
                        child: Text(n.name ?? 'Unknown'),
                      );
                    }).toList(),
                    onChanged: state.cityId == null
                        ? null
                        : (val) {
                            ref
                                .read(createHouseControllerProvider.notifier)
                                .setNeighborhood(val);
                          },
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  if (widget.house?.neighborhood != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(
                        "Current: ${widget.house!.neighborhood!.name}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Status Checks
                  SwitchListTile(
                    title: const Text("Available"),
                    value: _available,
                    onChanged: (v) => setState(() => _available = v),
                  ),
                  SwitchListTile(
                    title: const Text("Active"),
                    value: _isActive,
                    onChanged: (v) => setState(() => _isActive = v),
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: state.isLoadingLocations ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      widget.house != null
                          ? "Update Property"
                          : "Create Property",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImagePreview(CreateHouseFormState state, ColorScheme cs) {
    if (widget.house?.imageDetail != null &&
        state.imageId == widget.house!.imageDetail!.id) {
      final imgUrl = widget.house!.imageDetail!.image;
      if (imgUrl != null) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    const Center(child: Icon(Icons.broken_image, size: 40)),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: const Text(
                  "Current Image",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        );
      }
    }

    if (state.imageId != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: cs.primary, size: 40),
            Text("Image ID: ${state.imageId} Selected"),
            const SizedBox(height: 4),
            Text(
              "(Tap to change)",
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo, size: 40, color: cs.onSurfaceVariant),
          const Text("Select Image"),
        ],
      ),
    );
  }
}
