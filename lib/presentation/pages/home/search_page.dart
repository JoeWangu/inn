import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/home_controller/search_controller.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchHouseControllerProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: TextField(
            controller: _textController,
            autofocus: true, // ✅ Keyboard opens immediately
            onChanged: (value) {
              // Trigger controller
              ref.read(searchHouseControllerProvider.notifier).search(value);
            },
            decoration: InputDecoration(
              hintText: 'Search location, title...',
              hintStyle: TextStyle(color: cs.onSurface.withValues(alpha: 0.5)),
              border: InputBorder.none,
              filled: true,
              fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.3),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              // Rounded corners for the search box
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      body: searchState.when(
        data: (houses) {
          if (houses.isEmpty) {
            if (_textController.text.isNotEmpty) {
              return const Center(child: Text("No results found"));
            }
            return const Center(child: Text("Type to find your next home"));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: houses.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final house = houses[index];
              final tag = 'search_${house.id}'; // Unique Hero tag

              return ListTile(
                onTap: () => context.pushNamed(
                  'house-details',
                  extra: {'house': house, 'tag': tag},
                ),
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: house.imageDetail.image ?? '',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  house.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  "KES ${house.price.toStringAsFixed(0)} • ${house.city?.name ?? ''}",
                ),
                trailing: const Icon(Icons.chevron_right),
              );
            },
          );
        },
        error: (err, stack) => Center(child: Text("Error: $err")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
