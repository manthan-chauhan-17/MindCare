import 'package:mind_care/features/meditation/domain/entities/daily_quote.dart';
import 'package:mind_care/features/meditation/domain/entities/mood_message.dart';

abstract class MeditationRepository {
  Future<DailyQuote> getDailyQuotes();
  Future<MoodMessage> getMoodMessage(String mood);
}
