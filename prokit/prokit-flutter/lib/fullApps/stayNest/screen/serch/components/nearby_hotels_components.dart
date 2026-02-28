import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const FilterButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Text(label),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              hotel['image'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < hotel['rating'].round() ? Icons.star : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${hotel['rating']} (${hotel['reviews']} Reviews)',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  hotel['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${hotel['location']}, Maharashtra',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${hotel['price']}/night',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: stayNestPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SortBottomSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selected;
  final Function(String) onSelect;

  const SortBottomSheet({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...options.map(
            (option) => ListTile(
              title: Text(option),
              trailing: selected == option ? Icon(Icons.check_circle, color: stayNestPrimaryColor) : null,
              onTap: () => onSelect(option),
            ),
          ),
        ],
      ),
    );
  }
}

class LocalityFilterBottomSheet extends StatelessWidget {
  final List<String> options;
  final List<String> selected;
  final Function(String) onChanged;
  final VoidCallback onApply;
  final VoidCallback onClear;

  const LocalityFilterBottomSheet({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.onApply,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Locality',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...options.map(
            (option) => CheckboxListTile(
              title: Text(option),
              value: selected.contains(option),
              onChanged: (_) => onChanged(option),
              activeColor: stayNestPrimaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: onClear, child: Text('Clear All')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: stayNestPrimaryColor),
                onPressed: onApply,
                child: Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
