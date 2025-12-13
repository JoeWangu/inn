import 'package:flutter/material.dart';

class SearchFilterSheet extends StatefulWidget {
  final num? initialMinPrice;
  final num? initialMaxPrice;
  final String? initialCity;
  final String? initialCategory;
  final Function(num?, num?, String?, String?) onApply;

  const SearchFilterSheet({
    super.key,
    this.initialMinPrice,
    this.initialMaxPrice,
    this.initialCity,
    this.initialCategory,
    required this.onApply,
  });

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  late TextEditingController _minPriceCtrl;
  late TextEditingController _maxPriceCtrl;
  late TextEditingController _cityCtrl;
  late TextEditingController _categoryCtrl;

  @override
  void initState() {
    super.initState();
    _minPriceCtrl = TextEditingController(
      text: widget.initialMinPrice?.toString() ?? '',
    );
    _maxPriceCtrl = TextEditingController(
      text: widget.initialMaxPrice?.toString() ?? '',
    );
    _cityCtrl = TextEditingController(text: widget.initialCity ?? '');
    _categoryCtrl = TextEditingController(text: widget.initialCategory ?? '');
  }

  @override
  void dispose() {
    _minPriceCtrl.dispose();
    _maxPriceCtrl.dispose();
    _cityCtrl.dispose();
    _categoryCtrl.dispose();
    super.dispose();
  }

  void _handleApply() {
    final minPrice = num.tryParse(_minPriceCtrl.text);
    final maxPrice = num.tryParse(_maxPriceCtrl.text);
    final city = _cityCtrl.text.isEmpty ? null : _cityCtrl.text;
    final category = _categoryCtrl.text.isEmpty ? null : _categoryCtrl.text;

    widget.onApply(minPrice, maxPrice, city, category);
    Navigator.pop(context);
  }

  void _handleClear() {
    _minPriceCtrl.clear();
    _maxPriceCtrl.clear();
    _cityCtrl.clear();
    _categoryCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24.0),
      height:
          MediaQuery.of(context).size.height * 0.75, // Take up 75% of screen
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _handleClear,
                child: const Text("Clear All"),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range
                  Text("Price Range", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _minPriceCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Min Price",
                            prefixText: "KES ",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _maxPriceCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Max Price",
                            prefixText: "KES ",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // City
                  Text("Location", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _cityCtrl,
                    decoration: const InputDecoration(
                      labelText: "City",
                      hintText: "e.g. Nairobi",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Category
                  Text("Category", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _categoryCtrl,
                    decoration: const InputDecoration(
                      labelText: "Category",
                      hintText: "e.g. Apartment, Villa",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Apply Button
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: _handleApply,
              child: const Text("Show Results"),
            ),
          ),
        ],
      ),
    );
  }
}
