
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../home_dummy_data.dart';
import '../widgets/home_action_button.dart';
import '../widgets/home_dashboard.dart';
import '../widgets/home_jobs_section.dart';
import '../widgets/home_recommendation_card.dart';
import '../widgets/home_roadmap_card.dart';
import '../widgets/home_score_insight_row.dart';
import '../widgets/home_skill_gap_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pathfinder'),
        centerTitle: true,
        actions: [
          IconButton(
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
          icon: const Icon(
            Icons.notifications,
            ),
        ),


        ],
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/search'),
          icon: const Icon(Icons.search,
            color: AppColors.blueNotificationIcons,),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Hello, Ayat + CV Score circle
              HomeHeader(user: HomeDummyData.user),
              SizedBox(height: 16.h),

              // 📄 Analyze CV + Chat with AI buttons
              const HomeActionButtons(),
              SizedBox(height: 20.h),

              // ⭐ Top Recommendation card
              HomeRecommendationCard(
                recommendation: HomeDummyData.recommendation,
              ),
              SizedBox(height: 16.h),

              // 📊 CV Score + AI Career Insight
              HomeScoreInsightRow(cvScore: HomeDummyData.user.cvScore),
              SizedBox(height: 20.h),

              // 🗺️ Roadmap Progress
              HomeRoadmapCard(roadmap: HomeDummyData.roadmap),
              SizedBox(height: 20.h),

              // 🧠 Skill Gap Analysis
              HomeSkillGapSection(skills: HomeDummyData.skillGaps),
              SizedBox(height: 20.h),

              // 💼 Jobs For You
              const HomeJobsSection(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}