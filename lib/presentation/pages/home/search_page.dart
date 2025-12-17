import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/home_controller/search_controller.dart';
import 'package:inn/core/errors/error_handler.dart';

import 'package:inn/presentation/shared/search_filter_sheet.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _textController = TextEditingController();

  // Filter State
  num? _minPrice;
  num? _maxPrice;
  String? _city;
  String? _category;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _triggerSearch() {
    ref
        .read(searchHouseControllerProvider.notifier)
        .search(
          _textController.text,
          minPrice: _minPrice,
          maxPrice: _maxPrice,
          city: _city,
          category: _category,
        );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SearchFilterSheet(
        initialMinPrice: _minPrice,
        initialMaxPrice: _maxPrice,
        initialCity: _city,
        initialCategory: _category,
        onApply: (min, max, city, category) {
          setState(() {
            _minPrice = min;
            _maxPrice = max;
            _city = city;
            _category = category;
          });
          _triggerSearch();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchHouseControllerProvider);
    final cs = Theme.of(context).colorScheme;

    // Check if any filter is active to show a badge or color
    final isFilterActive =
        _minPrice != null ||
        _maxPrice != null ||
        (_city != null && _city!.isNotEmpty) ||
        (_category != null && _category!.isNotEmpty);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextField(
            controller: _textController,
            autofocus: true,
            onChanged: (value) => _triggerSearch(),
            decoration: InputDecoration(
              hintText: 'Search location, title...',
              hintStyle: TextStyle(color: cs.onSurface.withValues(alpha: 0.5)),
              border: InputBorder.none,
              filled: true,
              fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.3),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
        actions: [
          IconButton(
            onPressed: _showFilterSheet,
            icon: Icon(
              isFilterActive ? Icons.filter_list_alt : Icons.filter_list,
              color: isFilterActive ? cs.primary : null,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: searchState.when(
        data: (houses) {
          if (houses.isEmpty) {
            final hasQuery = _textController.text.isNotEmpty || isFilterActive;
            if (hasQuery) {
              return const Center(child: Text("No results found"));
            }
            return const Center(child: Text("Type to find your next home"));
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
                ref.read(searchHouseControllerProvider.notifier).loadNextPage();
              }
              return false;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: houses.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final house = houses[index];
                final tag = 'search_${house.id}';

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
                        imageUrl: house.imageDetail?.image ?? '',
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
            ),
          );
        },
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
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
