import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inn/data/models/extra_image_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';
import 'package:inn/core/errors/error_handler.dart';

class ManageImagesPage extends ConsumerStatefulWidget {
  final int rentalId;

  const ManageImagesPage({super.key, required this.rentalId});

  @override
  ConsumerState<ManageImagesPage> createState() => _ManageImagesPageState();
}

class _ManageImagesPageState extends ConsumerState<ManageImagesPage> {
  final List<File> _selectedImages = [];
  bool _isUploading = false;

  // Fetch images provider
  late final _imagesProvider =
      FutureProvider.autoDispose<List<ExtraImageModel>>((ref) async {
        final repo = ref.read(houseRepositoryProvider);
        return repo.getExtraImages(rentalId: widget.rentalId);
      });

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      if ((_selectedImages.length + pickedFiles.length) > 10) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You can only select up to 10 images at a time.'),
            ),
          );
        }
        return;
      }

      setState(() {
        _selectedImages.addAll(pickedFiles.map((x) => File(x.path)));
      });
    }
  }

  Future<void> _uploadImages() async {
    if (_selectedImages.isEmpty) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final repo = ref.read(houseRepositoryProvider);
      await repo.uploadExtraImages(widget.rentalId, _selectedImages);

      setState(() {
        _selectedImages.clear();
      });
      ref.invalidate(_imagesProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Images uploaded successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(getReadableError(e))));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<void> _deleteImage(int id) async {
    try {
      final repo = ref.read(houseRepositoryProvider);
      await repo.deleteExtraImage(id);
      ref.invalidate(_imagesProvider);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Image deleted.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(getReadableError(e))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagesAsync = ref.watch(_imagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Images')),
      body: Column(
        children: [
          // Upload Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  onPressed: _isUploading ? null : _pickImages,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Pick Images'),
                ),
                if (_selectedImages.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(_selectedImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedImages.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  FilledButton.icon(
                    onPressed: _isUploading ? null : _uploadImages,
                    icon: _isUploading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.cloud_upload),
                    label: const Text('Upload Selected'),
                  ),
                ],
              ],
            ),
          ),
          const Divider(),

          // Existing Images
          Expanded(
            child: imagesAsync.when(
              data: (images) {
                if (images.isEmpty) {
                  return const Center(child: Text("No extra images yet."));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final img = images[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(img.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withAlpha(180),
                            radius: 16,
                            child: IconButton(
                              iconSize: 16,
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteImage(img.id),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    getReadableError(err),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
