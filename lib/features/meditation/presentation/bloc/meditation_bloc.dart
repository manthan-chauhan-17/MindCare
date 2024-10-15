import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_care/features/meditation/domain/usecases/get_daily_quote.dart';
import 'package:mind_care/features/meditation/domain/usecases/get_mood_message.dart';
import 'package:mind_care/features/meditation/presentation/bloc/meditation_event.dart';
import 'package:mind_care/features/meditation/presentation/bloc/meditation_state.dart';

class MeditationBloc extends Bloc<MeditationEvent, MeditationState> {
  final GetDailyQuote getDailyQuote;
  final GetMoodMessage getMoodMessage;

  MeditationBloc({required this.getDailyQuote, required this.getMoodMessage})
      : super(MeditationInitial()) {
    on<FetchDailyQuote>((event, emit) async {
      emit(MeditationLoading());

      try {
        final dailyQuote = await getDailyQuote();
        emit(DailyQuoteLoaded(dailyQuote: dailyQuote));
      } catch (e) {
        emit(MeditationError(message: e.toString()));
      }
    });

    on<FetchMoodMessage>((event, emit) async {
      emit(MeditationLoading());

      try {
        final moodMessage = await getMoodMessage(event.mood);
        emit(MoodMessageLoaded(moodMessage: moodMessage));
      } catch (e) {
        emit(MeditationError(message: e.toString()));
      }
    });
  }
}
