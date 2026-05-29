import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/utils/date_helpers.dart';

void main() {
  group('dateKey', () {
    test('форматує дату з лідуючими нулями', () {
      expect(dateKey(DateTime(2026, 1, 5)), '2026-01-05');
      expect(dateKey(DateTime(2026, 12, 31)), '2026-12-31');
      expect(dateKey(DateTime(2026, 5, 29)), '2026-05-29');
    });
  });

  group('isCompletedToday', () {
    test('повертає true якщо є ключ сьогодні', () {
      final today = dateKey(DateTime.now());
      expect(isCompletedToday([today]), isTrue);
    });

    test('повертає false якщо ключа немає', () {
      expect(isCompletedToday([]), isFalse);
    });

    test('повертає false для вчорашньої дати', () {
      final yesterday =
          dateKey(DateTime.now().subtract(const Duration(days: 1)));
      expect(isCompletedToday([yesterday]), isFalse);
    });
  });

  group('calculateStreak', () {
    test('повертає 0 для порожнього списку', () {
      expect(calculateStreak([]), 0);
    });

    test('повертає 1 якщо відмічено тільки сьогодні', () {
      final today = dateKey(DateTime.now());
      expect(calculateStreak([today]), 1);
    });

    test('рахує послідовні дні включно з сьогодні', () {
      final now = DateTime.now();
      final dates = List.generate(
        5,
        (i) => dateKey(now.subtract(Duration(days: i))),
      );
      expect(calculateStreak(dates), 5);
    });

    test('скидається після пропуску одного дня', () {
      final now = DateTime.now();
      // Сьогодні і 2 дні тому (вчора пропущено)
      final dates = [
        dateKey(now),
        dateKey(now.subtract(const Duration(days: 2))),
        dateKey(now.subtract(const Duration(days: 3))),
      ];
      expect(calculateStreak(dates), 1);
    });

    test('повертає 0 якщо остання відмітка вчора, а сьогодні нема', () {
      final yesterday =
          dateKey(DateTime.now().subtract(const Duration(days: 1)));
      expect(calculateStreak([yesterday]), 0);
    });

    test('не враховує майбутні дати', () {
      final future =
          dateKey(DateTime.now().add(const Duration(days: 1)));
      final today = dateKey(DateTime.now());
      expect(calculateStreak([future, today]), 1);
    });

    test('порядок дат у списку не важливий', () {
      final now = DateTime.now();
      // Перемішаний порядок
      final dates = [
        dateKey(now.subtract(const Duration(days: 2))),
        dateKey(now),
        dateKey(now.subtract(const Duration(days: 1))),
      ];
      expect(calculateStreak(dates), 3);
    });
  });
}
