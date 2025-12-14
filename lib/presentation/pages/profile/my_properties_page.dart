import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';
import 'package:inn/presentation/shared/house_card.dart';

class MyPropertiesPage extends ConsumerStatefulWidget {
  const MyPropertiesPage({super.key});

  @override
  ConsumerState<MyPropertiesPage> createState() => _MyPropertiesPageState();
}

class _MyPropertiesPageState extends ConsumerState<MyPropertiesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Trigger fetch logic
      ref.read(houseRepositoryProvider).fetchMyProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stream = ref.watch(houseRepositoryProvider).watchMyProperties();

    return Scaffold(
      appBar: AppBar(title: const Text('My Properties')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('create-house');
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<HouseModel>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final houses = snapshot.data ?? [];

          if (houses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No properties found.'),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(houseRepositoryProvider)
                          .fetchMyProperties(forceRefresh: true);
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(houseRepositoryProvider)
                  .fetchMyProperties(forceRefresh: true);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: houses.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final house = houses[index];
                return Stack(
                  children: [
                    HouseCard(
                      house: house,
                      tagPrefix: 'my_prop', // Unique tag
                    ),
                    Positioned(
                      top: 10,
                      right: 4,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.photo_library,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              context.pushNamed(
                                'manage-images',
                                extra: house.id,
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              context.pushNamed('create-house', extra: house);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _confirmDelete(context, ref, house.id),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    int houseId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Property'),
        content: const Text('Are you sure you want to delete this property?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // Show blocking loader
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        await ref.read(houseRepositoryProvider).deleteHouse(houseId);

        if (context.mounted) {
          Navigator.pop(context); // Pop loader
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Property deleted successfully')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          Navigator.pop(context); // Pop loader
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to delete property. Please try again.'),
            ),
          );
        }
      }
    }
  }
}
