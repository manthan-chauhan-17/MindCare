import 'package:flutter/material.dart';
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
      body: Container(
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
                      onTap: () {},
                      label: "Happy",
                      image: "assets/images/happy.png",
                      color: DefaultColors.pink),
                  FeelingButton(
                      onTap: () {},
                      label: "Calm",
                      image: "assets/images/calm.png",
                      color: DefaultColors.purple),
                  FeelingButton(
                      onTap: () {},
                      label: "Relax",
                      image: "assets/images/relax.png",
                      color: DefaultColors.orange),
                  FeelingButton(
                      onTap: () {},
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
                description:
                    "Let's open up to the thing that matters among people",
                color: DefaultColors.task1,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TaskCard(
                title: "Noon",
                description:
                    "Let's open up to the thing that matters among people",
                color: DefaultColors.task2,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TaskCard(
                title: "Evening",
                description:
                    "Let's open up to the thing that matters among people",
                color: DefaultColors.task3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
