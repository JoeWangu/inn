import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/image_repository.dart';

class ImageSelectorSheet extends ConsumerStatefulWidget {
  const ImageSelectorSheet({super.key});

  @override
  ConsumerState<ImageSelectorSheet> createState() => _ImageSelectorSheetState();
}

class _ImageSelectorSheetState extends ConsumerState<ImageSelectorSheet> {
  // We manage the "fetch" state locally or via a provider.
  // Ideally, use a FutureProvider for the list.
  // For simplicity, I'll fetch in initState.
  List<ImageDetail> _images = [];
  bool _isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    try {
      final images = await ref.read(imageRepositoryProvider).getImages();
      if (mounted) {
        setState(() {
          _images = images;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        // Show error
      }
    }
  }

  Future<void> _pickAndUploadImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      if (mounted) setState(() => _isLoading = true);
      try {
        final file = File(pickedFile.path);

        await ref.read(imageRepositoryProvider).uploadImage(file);

        // Refresh list from API to show the uploaded image
        await _fetchImages();

        // Log selection (optional: maybe just show it in the list now and let user select)
        // If we want to auto-select, we can still do:
        // _onSelect(newImage);
        // But the user might want to confirm it in the grid first.
        // Let's just refresh the list as requested.

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        if (mounted) setState(() => _isLoading = false);
        // Show error?
      }
    }
  }

  void _onSelect(ImageDetail image) {
    Navigator.of(context).pop(image.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Image',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: _pickAndUploadImage,
                tooltip: "Upload New Image",
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _images.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "No images found.\nPlease upload one from the top right.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final img = _images[index];
                      // Construct full URL if needed, depending on API response.
                      // Assuming 'img.image' is a full URL or relative path.
                      // If relative, prepend constants.baseUrl.
                      // Usually backend returns full URL if configured right.
                      final imageUrl = img.image ?? '';
                      // If it's relative, we might need to handle it.
                      // Let's assume full URL for now or use a heuristic.

                      return GestureDetector(
                        onTap: () => _onSelect(img),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, _) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.image),
                            ),
                            errorWidget: (_, _, _) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
