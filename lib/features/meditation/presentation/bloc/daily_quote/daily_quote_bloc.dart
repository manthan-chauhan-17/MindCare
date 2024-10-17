import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_care/features/meditation/domain/usecases/get_daily_quote.dart';
import 'package:mind_care/features/meditation/presentation/bloc/daily_quote/daily_quote_event.dart';
import 'package:mind_care/features/meditation/presentation/bloc/daily_quote/daily_quote_state.dart';

class DailyQuoteBloc extends Bloc<DailyQuoteEvent, DailyQuoteState> {
  final GetDailyQuote getDailyQuote;

  DailyQuoteBloc({required this.getDailyQuote}) : super(DailyQuoteInitial()) {
    on<FetchDailtyQuotes>((event, emit) async {
      emit(DailyQuoteLoading());

      try {
        final dailyQuote = await getDailyQuote();
        emit(DailyQuoteLoaded(dailyQuote: dailyQuote));
      } catch (e) {
        emit(DailyQuoteError(message: e.toString()));
      }
    });
  }
}
