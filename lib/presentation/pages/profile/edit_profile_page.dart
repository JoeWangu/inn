import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inn/data/models/user_profile_model.dart';
import 'package:inn/presentation/controllers/profile_controller.dart';
import 'package:inn/presentation/controllers/security_controller.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  final UserProfileModel? userProfile;

  const EditProfilePage({super.key, this.userProfile});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _addressController;
  late TextEditingController _bioController;

  String? _gender;
  File? _imageFile;
  String _selectedCountryCode = '+254';

  final List<String> _countryCodes = ['+254', '+255', '+256', '+1', '+44'];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.userProfile?.firstName,
    );
    _lastNameController = TextEditingController(
      text: widget.userProfile?.lastName,
    );
    var phone = widget.userProfile?.phoneNumber ?? '';
    // Check if phone starts with any known code
    for (var code in _countryCodes) {
      if (phone.startsWith(code)) {
        _selectedCountryCode = code;
        phone = phone.substring(code.length);
        break;
      }
    }
    _phoneController = TextEditingController(text: phone);
    _dobController = TextEditingController(
      text: widget.userProfile?.dob,
    ); // Use a picker later
    _addressController = TextEditingController(
      text: widget.userProfile?.address,
    );
    _bioController = TextEditingController(text: widget.userProfile?.bio);
    _gender = widget.userProfile?.gender;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    ref.read(securityControllerProvider.notifier).ignoreNextResume();
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      // Format YYYY-MM-DD
      final formatted =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      _dobController.text = formatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userProfile == null ? 'Create Profile' : 'Edit Profile',
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Image Picker
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : (widget.userProfile?.profilePicture != null
                                  ? NetworkImage(
                                          widget.userProfile!.profilePicture!,
                                        )
                                        as ImageProvider
                                  : null),
                        child:
                            (_imageFile == null &&
                                widget.userProfile?.profilePicture == null)
                            ? const Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Personal Info
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedCountryCode,
                            decoration: const InputDecoration(
                              labelText: 'Code',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                            ),
                            items: _countryCodes
                                .map(
                                  (code) => DropdownMenuItem(
                                    value: code,
                                    child: Text(code),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedCountryCode = v!),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _selectDate,
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _dobController,
                          decoration: const InputDecoration(
                            labelText: 'Date of Birth (YYYY-MM-DD)',
                          ),
                          // validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: _gender,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      items: const [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(value: 'Other', child: Text('Other')),
                      ],
                      onChanged: (v) => setState(() => _gender = v),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _bioController,
                      decoration: const InputDecoration(labelText: 'Bio'),
                      maxLines: 3,
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final success = widget.userProfile == null
                                ? await ref
                                      .read(profileControllerProvider.notifier)
                                      .createProfile(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        phoneNumber:
                                            "$_selectedCountryCode${_phoneController.text}",
                                        dob: _dobController.text.isEmpty
                                            ? null
                                            : _dobController.text,
                                        gender: _gender,
                                        address: _addressController.text,
                                        bio: _bioController.text,
                                        profilePicture: _imageFile,
                                      )
                                : await ref
                                      .read(profileControllerProvider.notifier)
                                      .updateProfile(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        phoneNumber:
                                            "$_selectedCountryCode${_phoneController.text}",
                                        dob: _dobController.text.isEmpty
                                            ? null
                                            : _dobController.text,
                                        gender: _gender,
                                        address: _addressController.text,
                                        bio: _bioController.text,
                                        profilePicture: _imageFile,
                                      );

                            if (success && context.mounted) {
                              context.pop();
                              ref.invalidate(profileControllerProvider);
                            } else if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to save profile'),
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          widget.userProfile == null ? 'Create' : 'Update',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
