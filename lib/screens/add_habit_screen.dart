import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../l10n/app_localizations.dart';
import '../providers/habits_provider.dart';
import '../widgets/emoji_picker_sheet.dart';

const _colors = [
  Color(0xFF6C63FF),
  Color(0xFF4CAF50),
  Color(0xFFFF5722),
  Color(0xFF2196F3),
  Color(0xFFFF9800),
  Color(0xFFE91E63),
  Color(0xFF00BCD4),
  Color(0xFF9C27B0),
];

class AddHabitScreen extends ConsumerStatefulWidget {
  final String? habitId;

  const AddHabitScreen({super.key, this.habitId});

  @override
  ConsumerState<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _emoji = '📚';
  int _colorValue = _colors[0].toARGB32();

  bool get _isEditing => widget.habitId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final habits = ref.read(habitsProvider);
      final habit = habits.firstWhere((h) => h.id == widget.habitId);
      _nameController.text = habit.name;
      _emoji = habit.emoji;
      _colorValue = habit.colorValue;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (_isEditing) {
      ref.read(habitsProvider.notifier).editHabit(
            widget.habitId!,
            name: _nameController.text.trim(),
            emoji: _emoji,
            colorValue: _colorValue,
          );
    } else {
      ref.read(habitsProvider.notifier).addHabit(
            name: _nameController.text.trim(),
            emoji: _emoji,
            colorValue: _colorValue,
          );
    }
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l.editHabit : l.newHabit),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(l.save,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => EmojiPickerSheet(
                    selected: _emoji,
                    onSelected: (e) => setState(() => _emoji = e),
                  ),
                ),
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Color(_colorValue).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text(_emoji, style: const TextStyle(fontSize: 48)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                l.tapToChangeIcon,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ),
            const SizedBox(height: 28),
            TextFormField(
              controller: _nameController,
              autofocus: !_isEditing,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l.habitName,
                hintText: l.habitNameHint,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l.habitNameError : null,
            ),
            const SizedBox(height: 28),
            Text(l.color,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: _colors.map((c) {
                final selected = c.toARGB32() == _colorValue;
                return GestureDetector(
                  onTap: () => setState(() => _colorValue = c.toARGB32()),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: selected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 3)
                          : null,
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                  color: c.withValues(alpha: 0.5),
                                  blurRadius: 8)
                            ]
                          : null,
                    ),
                    child: selected
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
