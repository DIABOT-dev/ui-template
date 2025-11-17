import 'package:flutter/material.dart';

import '../views/activities/ac.dart';
import '../views/aichatbot/ai.dart';
import '../views/aimentalhealthpalngenerator/ai.dart';
import '../views/aimoodscanner/ai.dart';
import '../views/aimotivationassistant/a.dart';
import '../views/aithoughtreframingassistant/ai.dart';
import '../views/bllodpressure/b.dart';
import '../views/communitysupport/com.dart';
import '../views/dailyreflection/f.dart';
import '../views/emotionalinteelegencescore/em.dart';
import '../views/freudscore/fr.dart';
import '../views/gratefullness/g.dart';
import '../views/healthjournal/h.dart';
import '../views/heartrate/h.dart';
import '../views/home/home.dart';
import '../views/journals/j.dart';
import '../views/listeners/l.dart';
import '../views/meditations/m.dart';
import '../views/mentalmetrics/m.dart';
import '../views/messages/mesages.dart';
import '../views/mildanxiety/m.dart';
import '../views/mindfullhours/m.dart';
import '../views/mindfullhoursstates/m.dart';
import '../views/monitoring/m.dart';
import '../views/moodhistory/mood.dart';
import '../views/moodtracker/m.dart';
import '../views/notifications/n.dart';
import '../views/schedule/s.dart';
import '../views/services/s.dart';
import '../views/sessionhistory/s.dart';
import '../views/sleep/s.dart';
import '../views/sleepquality/sl.dart';
import '../views/socialwellbeing/s.dart';
import '../views/stepstaken/s.dart';
import '../views/strategies/s.dart';
import '../views/stressmanagement/st.dart';
import '../views/therapsistsshcedule/t.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String selectedMenuItem = ''; // Track the selected menu item

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 60),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 5, top: 10),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                'https://randomuser.me/api/portraits/men/11.jpg',
              ),
            ),
            title: const Text('Hey!', style: TextStyle()),
            subtitle: const Text('James Powell'),
          ),
          const SizedBox(height: 10.0),
          buildMenuItem(title: "Home", icon: Icons.home, onTap: () => navigateTo(HomeScreen())),
          buildMenuItem(title: "Activity", icon: Icons.directions_run, onTap: () => navigateTo(ActivityScreen())),
          buildMenuItem(title: "AI Score", icon: Icons.auto_graph, onTap: () => navigateTo(SuggestionsScreen())),
          buildMenuItem(title: "BP", icon: Icons.favorite_outline, onTap: () => navigateTo(const BloodddddPressureScreen())),
          buildMenuItem(title: "Feed", icon: Icons.rss_feed, onTap: () => navigateTo(const CommunityFeedScreen())),
          buildMenuItem(title: "Reflection", icon: Icons.self_improvement, onTap: () => navigateTo(DailyReflectionScreen())),
          buildMenuItem(title: "Emotion IQ", icon: Icons.psychology, onTap: () => navigateTo(EmotionalIntelligenceScreen())),
          buildMenuItem(title: "Freud", icon: Icons.school, onTap: () => navigateTo(const FreudScoresss())),
          buildMenuItem(title: "Grateful", icon: Icons.sentiment_satisfied_alt, onTap: () => navigateTo(GratefulnessScreen())),
          buildMenuItem(title: "Journal", icon: Icons.book, onTap: () => navigateTo(const HealthJournal())),
          buildMenuItem(title: "Heart", icon: Icons.monitor_heart, onTap: () => navigateTo(HeartRateScreen())),
          buildMenuItem(title: "Journals", icon: Icons.menu_book, onTap: () => navigateTo(const JournalsScreen())),
          buildMenuItem(title: "Listeners", icon: Icons.headset_mic, onTap: () => navigateTo(ListenersScreen())),
          buildMenuItem(title: "Meditate", icon: Icons.spa, onTap: () => navigateTo(const MeditationbbbbScreen())),
          buildMenuItem(title: "AI Chat", icon: Icons.smart_toy, onTap: () => navigateTo(const MentalHealthChatbot())),
          buildMenuItem(title: "AI Plan", icon: Icons.task_alt, onTap: () => navigateTo(MentalHealthPlanGenerator())),
          buildMenuItem(title: "AI Mood", icon: Icons.face_retouching_natural, onTap: () => navigateTo(const MoodScanner())),
          buildMenuItem(title: "AI Motivate", icon: Icons.light_mode, onTap: () => navigateTo(MotivationAssistant())),
          buildMenuItem(title: "AI Reframe", icon: Icons.tips_and_updates, onTap: () => navigateTo(const ThoughtReframingAssistant())),
          buildMenuItem(title: "Alerts", icon: Icons.notifications_active, onTap: () => navigateTo(NotificationsScreenssssss())),
          buildMenuItem(title: "Metrics", icon: Icons.bar_chart_rounded, onTap: () => navigateTo(MentalMetricssssScreen())),
          buildMenuItem(title: "Anxiety", icon: Icons.mood_bad, onTap: () => navigateTo(MildAnxiety())),
          buildMenuItem(title: "Mind Hours", icon: Icons.access_time, onTap: () => navigateTo(MindfulHourses())),
          buildMenuItem(title: "Mind Stats", icon: Icons.analytics, onTap: () => navigateTo(MindfullHoursSatesScreen())),
          buildMenuItem(title: "Monitor", icon: Icons.monitor_heart, onTap: () => navigateTo(const MonitoringScreen())),
          buildMenuItem(title: "Mood Log", icon: Icons.timeline, onTap: () => navigateTo(MoodHistoryScreen())),
          buildMenuItem(title: "Mood Track", icon: Icons.show_chart, onTap: () => navigateTo(const MoodTracker())),
          buildMenuItem(title: "Schedule", icon: Icons.calendar_month, onTap: () => navigateTo(ScheduleScreennnnn())),
          buildMenuItem(title: "Services", icon: Icons.design_services, onTap: () => navigateTo(const ServicesScreen())),
          buildMenuItem(title: "Sessions", icon: Icons.history, onTap: () => navigateTo(SessionHistoryScreen())),
          buildMenuItem(title: "Sleep", icon: Icons.bedtime, onTap: () => navigateTo(SleepModuleScreen())),
          buildMenuItem(title: "Sleep Q", icon: Icons.nightlight_round, onTap: () => navigateTo(SleepQuality())),
          buildMenuItem(title: "Social", icon: Icons.people_alt, onTap: () => navigateTo(const SocialWellbeingScreen())),
          buildMenuItem(title: "Steps", icon: Icons.directions_walk, onTap: () => navigateTo(StepsTaken())),
          buildMenuItem(title: "Strategy", icon: Icons.lightbulb, onTap: () => navigateTo(StrategiesScreen())),
          buildMenuItem(title: "Stress", icon: Icons.health_and_safety, onTap: () => navigateTo(StressLevelScreen())),
          buildMenuItem(title: "Therapist", icon: Icons.calendar_today, onTap: () => navigateTo(const TherapistScheduleScreen())),
          buildMenuItem(title: "Messages", icon: Icons.message, onTap: () => navigateTo(MessagesScreen())),


          const SizedBox(height: 10),
          const Divider(thickness: 1),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.logout,
              color: Colors.redAccent,
              size: 20,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 16,
                color: Colors.redAccent,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    bool isSelected = title == selectedMenuItem;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.only(right: 30, top: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: const Border(),
        color: isSelected ? Colors.green : null, // Highlight selected item
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMenuItem = title;
          });
          onTap();
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.navigate_next,
              size: 20,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
