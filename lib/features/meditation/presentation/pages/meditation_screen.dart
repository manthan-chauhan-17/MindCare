import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_care/features/meditation/presentation/bloc/meditation_bloc.dart';
import 'package:mind_care/features/meditation/presentation/bloc/meditation_event.dart';
import 'package:mind_care/features/meditation/presentation/bloc/meditation_state.dart';
import 'package:mind_care/features/meditation/presentation/widgets/feeling_button.dart';
import 'package:mind_care/features/meditation/presentation/widgets/task_card.dart';
import 'package:mind_care/theme.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.white,
        elevation: 0,
        leading: Image.asset("assets/images/menu_burger.png"),
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
      body: BlocBuilder<MeditationBloc, MeditationState>(
        builder: (context, state) {
          if (state is MeditationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DailyQuoteLoaded) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back , Sabrina !",
                      style: AppTheme.lightTheme.textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "How are you feeling today ?",
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FeelingButton(
                            onTap: () {
                              context
                                  .read<MeditationBloc>()
                                  .add(FetchMoodMessage('Today i am happy'));
                            },
                            label: "Happy",
                            image: "assets/images/happy.png",
                            color: DefaultColors.pink),
                        FeelingButton(
                            onTap: () {
                              context
                                  .read<MeditationBloc>()
                                  .add(FetchMoodMessage('Today i am calm'));
                            },
                            label: "Calm",
                            image: "assets/images/calm.png",
                            color: DefaultColors.purple),
                        FeelingButton(
                            onTap: () {
                              context
                                  .read<MeditationBloc>()
                                  .add(FetchMoodMessage('Today i am relax'));
                            },
                            label: "Relax",
                            image: "assets/images/relax.png",
                            color: DefaultColors.orange),
                        FeelingButton(
                            onTap: () {
                              context.read<MeditationBloc>().add(FetchMoodMessage(
                                  'Today i need to focus but feel like missing something'));
                            },
                            label: "Focus",
                            image: "assets/images/focus.png",
                            color: DefaultColors.lightteal),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Today's Task",
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TaskCard(
                      title: "Morning",
                      description: state.dailyQuote.morningQuote,
                      color: DefaultColors.task1,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TaskCard(
                      title: "Noon",
                      description: state.dailyQuote.noonQuote,
                      color: DefaultColors.task2,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TaskCard(
                      title: "Evening",
                      description: state.dailyQuote.eveningQuote,
                      color: DefaultColors.task3,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is MoodMessageLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'My message for you',
                    style: AppTheme.lightTheme.textTheme.labelSmall,
                  ),
                  content: Text(state.moodMessage.text),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Ok',
                        style: AppTheme.lightTheme.textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              );
            });
            return Container();
          } else if (state is MeditationError) {
            return Center(
              child: Text(
                state.message,
                style: AppTheme.lightTheme.textTheme.labelSmall,
              ),
            );
          } else {
            return Center(
              child: Text(
                "No data found",
                style: AppTheme.lightTheme.textTheme.labelSmall,
              ),
            );
          }
        },
      ),
    );
  }
}
