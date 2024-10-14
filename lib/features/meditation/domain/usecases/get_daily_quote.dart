import 'package:mind_care/features/meditation/domain/entities/daily_quote.dart';
import 'package:mind_care/features/meditation/domain/repositories/meditation_repository.dart';

class GetDailyQuote {
  final MeditationRepository repository;

  GetDailyQuote({required this.repository});

  Future<DailyQuote> call() async {
    return await repository.getDailyQuotes();
  }
}
