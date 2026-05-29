import 'package:flutter/material.dart';

const kEmojis = [
  '📚',
  '💪',
  '🧘',
  '🏃',
  '💧',
  '🥗',
  '😴',
  '✍️',
  '🎸',
  '🎨',
  '🧹',
  '💊',
  '🐕',
  '🌿',
  '☀️',
  '🧠',
  '💰',
  '🎯',
  '🚴',
  '🏊',
  '🍎',
  '🫖',
  '📝',
  '🌙',
];

class EmojiPickerSheet extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const EmojiPickerSheet({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Оберіть іконку',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: kEmojis.map((e) {
              final isSelected = e == selected;
              return GestureDetector(
                onTap: () {
                  onSelected(e);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Center(
                    child: Text(e, style: const TextStyle(fontSize: 26)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
