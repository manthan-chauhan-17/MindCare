import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_care/features/meditation/presentation/bloc/daily_quote/daily_quote_bloc.dart';
import 'package:mind_care/features/meditation/presentation/bloc/daily_quote/daily_quote_state.dart';
import 'package:mind_care/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:mind_care/features/meditation/presentation/bloc/mood_message/mood_message_event.dart';
import 'package:mind_care/features/meditation/presentation/bloc/mood_message/mood_message_state.dart';
import 'package:mind_care/features/meditation/presentation/widgets/feeling_button.dart';
import 'package:mind_care/features/meditation/presentation/widgets/task_card.dart';
import 'package:mind_care/theme.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.white,
        elevation: 0,
        title: Text(
          "MindCare",
          style: AppTheme.lightTheme.textTheme.bodyLarge,
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: DefaultColors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome back, $name!',
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: 32,
              ),
              Text(
                'How are you feeling today ?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeelingButton(
                      label: 'Happy',
                      image: 'assets/images/happy.png',
                      color: DefaultColors.pink,
                      onTap: () {
                        context.read<MoodMessageBloc>().add(
                              FetchMoodMessage(
                                mood: 'happy',
                              ),
                            );
                      }),
                  FeelingButton(
                      label: 'Calm',
                      image: 'assets/images/calm.png',
                      color: DefaultColors.purple,
                      onTap: () {
                        context.read<MoodMessageBloc>().add(
                              FetchMoodMessage(
                                mood: 'calm',
                              ),
                            );
                      }),
                  FeelingButton(
                      label: 'Relax',
                      image: 'assets/images/relax.png',
                      color: DefaultColors.orange,
                      onTap: () {
                        context.read<MoodMessageBloc>().add(
                              FetchMoodMessage(
                                mood: 'relax',
                              ),
                            );
                      }),
                  FeelingButton(
                      label: 'Focus',
                      image: 'assets/images/focus.png',
                      color: DefaultColors.lightteal,
                      onTap: () {
                        context.read<MoodMessageBloc>().add(
                              FetchMoodMessage(
                                mood: 'focus',
                              ),
                            );
                      })
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Today\'s Task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<DailyQuoteBloc, DailyQuoteState>(
                builder: (context, state) {
                  if (state is DailyQuoteLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DailyQuoteLoaded) {
                    return Column(
                      children: [
                        TaskCard(
                          title: 'Morning',
                          description: state.dailyQuote.morningQuote,
                          color: DefaultColors.task1,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TaskCard(
                          title: 'Noon',
                          description: state.dailyQuote.noonQuote,
                          color: DefaultColors.task2,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TaskCard(
                          title: 'Evening',
                          description: state.dailyQuote.eveningQuote,
                          color: DefaultColors.task3,
                        )
                      ],
                    );
                  } else if (state is DailyQuoteError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No data found',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    );
                  }
                },
              ),
              BlocBuilder<MoodMessageBloc, MoodMessageState>(
                builder: (context, state) {
                  if (state is MoodMessageLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  'My advice for you',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                content: Text(
                                  state.moodMessage.text,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context
                                            .read<MoodMessageBloc>()
                                            .add(ResetMoodMessage());
                                      },
                                      child: Text('ok'))
                                ],
                              ));
                    });
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
