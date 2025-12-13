import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/create_house_controller.dart';
import 'package:inn/presentation/pages/create_house/widgets/image_selector_sheet.dart';

class CreateHousePage extends ConsumerStatefulWidget {
  const CreateHousePage({super.key});

  @override
  ConsumerState<CreateHousePage> createState() => _CreateHousePageState();
}

class _CreateHousePageState extends ConsumerState<CreateHousePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _categoryController = TextEditingController(); // Or dropdown?
  final _unitsController = TextEditingController();

  bool _available = true;
  bool _isActive = true;

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

    // Check if image selected
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
          title: _titleController.text,
          price: double.tryParse(_priceController.text) ?? 0.0,
          description: _descController.text,
          category: _categoryController.text,
          totalUnits: int.tryParse(_unitsController.text) ?? 1,
          available: _available,
          isActive: _isActive,
        );

    if (success && mounted) {
      context.pop(); // Go back to "My Properties"
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
      appBar: AppBar(title: const Text('Add New Property')),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
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
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: state.imageId != null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                  Text(
                                    "Image ID: ${state.imageId} Selected",
                                  ), // Could show preview if we stored URL
                                ],
                              ),
                            )
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  Text("Select Image"),
                                ],
                              ),
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
                  const SizedBox(height: 12),

                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'State'),
                    initialValue: state.stateId,
                    // Disable if no states available (or no country selected)
                    // Actually checking state.states.isEmpty might trigger briefly during load
                    // But 'isLoadingLocations' helps via UI feedback if we wanted
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
                    child: const Text("Create Property"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
