import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/data/models/extra_image_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';

class PhotoGalleryPage extends ConsumerStatefulWidget {
  final int rentalId;

  const PhotoGalleryPage({super.key, required this.rentalId});

  @override
  ConsumerState<PhotoGalleryPage> createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends ConsumerState<PhotoGalleryPage> {
  late final _imagesProvider =
      FutureProvider.autoDispose<List<ExtraImageModel>>((ref) async {
        final repo = ref.read(houseRepositoryProvider);
        return repo.getExtraImages(rentalId: widget.rentalId);
      });

  @override
  Widget build(BuildContext context) {
    final imagesAsync = ref.watch(_imagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Photo Gallery')),
      body: imagesAsync.when(
        data: (images) {
          if (images.isEmpty) {
            return const Center(
              child: Text("No photos available for this property."),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final img = images[index];
              return GestureDetector(
                onTap: () {
                  _showFullScreenImage(context, images, index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(img.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (err, stack) =>
            Center(child: Text('Error loading photos: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _showFullScreenImage(
    BuildContext context,
    List<ExtraImageModel> images,
    int initialIndex,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: PageView.builder(
            itemCount: images.length,
            controller: PageController(initialPage: initialIndex),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Center(
                  child: Image.network(
                    images[index].image,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
