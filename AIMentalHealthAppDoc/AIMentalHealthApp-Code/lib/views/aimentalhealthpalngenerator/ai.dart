import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MentalHealthPlanGenerator extends StatefulWidget {
  const MentalHealthPlanGenerator({super.key});

  @override
  MentalHealthPlanGeneratorState createState() => MentalHealthPlanGeneratorState();
}

class MentalHealthPlanGeneratorState extends State<MentalHealthPlanGenerator> {
  final String geminiApiKey = "AIzaSyBb3zlhns69XVf0rIkRV1_nbwSU-C4WiEk";
  final TextEditingController _moodController = TextEditingController();
  String _aiResponse = "";
  bool _isLoading = false;
  List<Map<String, dynamic>> _moodHistory = [];
  Map<String, dynamic> _currentPlan = {};

  // Dummy data for mental health
  final List<Map<String, dynamic>> _dummyMoodData = [
    {
      'date': '2024-01-15',
      'mood': 'anxious',
      'sleepHours': 6,
      'stressLevel': 8,
      'activities': ['work', 'meeting']
    },
    {
      'date': '2024-01-14',
      'mood': 'calm',
      'sleepHours': 7,
      'stressLevel': 4,
      'activities': ['yoga', 'reading']
    },
    {
      'date': '2024-01-13',
      'mood': 'happy',
      'sleepHours': 8,
      'stressLevel': 2,
      'activities': ['walk', 'social']
    },
    {
      'date': '2024-01-12',
      'mood': 'sad',
      'sleepHours': 5,
      'stressLevel': 7,
      'activities': ['work', 'alone']
    },
    {
      'date': '2024-01-11',
      'mood': 'stressed',
      'sleepHours': 6,
      'stressLevel': 9,
      'activities': ['deadline', 'overtime']
    },
  ];

  final List<Map<String, dynamic>> _dummyExercises = [
    {
      'name': 'Box Breathing',
      'duration': '5 minutes',
      'description': 'Inhale 4s, hold 4s, exhale 4s, hold 4s',
      'type': 'breathing'
    },
    {
      'name': '4-7-8 Breathing',
      'duration': '3 minutes',
      'description': 'Inhale 4s, hold 7s, exhale 8s',
      'type': 'breathing'
    },
    {
      'name': 'Mindful Walking',
      'duration': '10 minutes',
      'description': 'Walk while focusing on each step and breath',
      'type': 'mindfulness'
    },
  ];

  final List<String> _dummyAffirmations = [
    "I am capable of handling whatever comes my way",
    "My mental health is a priority and I honor it",
    "I choose peace over perfection",
    "I am worthy of self-care and compassion",
    "Each breath I take calms my mind and body",
  ];

  @override
  void initState() {
    super.initState();
    _initializeDummyData();
  }

  void _initializeDummyData() {
    _moodHistory = List.from(_dummyMoodData);
    _generateInitialPlan();
  }

  void _generateInitialPlan() {
    setState(() {
      _currentPlan = {
        'dailyRoutine': [
          {'time': 'Morning', 'activity': '5-minute meditation and journaling'},
          {'time': 'Afternoon', 'activity': '10-minute walk and hydration break'},
          {'time': 'Evening', 'activity': 'Gratitude practice and digital detox'},
        ],
        'breathingExercises': _dummyExercises.take(2).toList(),
        'affirmations': _dummyAffirmations.take(3).toList(),
        'moodTips': ['Practice deep breathing when stressed', 'Take regular breaks during work']
      };
    });
  }

  Future<void> _generateAIPlan() async {
    if (_moodController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please describe your current mood')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _aiResponse = "";
    });

    try {
      // Add current mood to history
      final newMoodEntry = {
        'date': DateTime.now().toString().split(' ')[0],
        'mood': _moodController.text.toLowerCase(),
        'sleepHours': 7, // Default value
        'stressLevel': 5, // Default value
        'activities': ['current_session']
      };

      _moodHistory.insert(0, newMoodEntry);

      // Prepare prompt with mood history and current mood
      String moodContext = _moodHistory.take(3).map((mood) =>
      "On ${mood['date']}: felt ${mood['mood']} (stress: ${mood['stressLevel']}/10)"
      ).join(", ");

      String prompt = """
        Based on user's mood history: $moodContext.
        Current mood: ${_moodController.text}
        
        Create a personalized mental health plan including:
        1. A daily routine with 3-4 time-based activities
        2. 2-3 breathing exercises with descriptions
        3. 3-5 positive affirmations
        4. 2-3 mood management tips
        
        Format the response in clear sections without using markdown symbols like ** or *. 
        Use clear headings and bullet points with proper spacing.
      """;

      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiApiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String generatedText = data['candidates'][0]['content']['parts'][0]['text'];

        setState(() {
          _aiResponse = _cleanResponse(generatedText);
          _updatePlanFromAIResponse(_aiResponse);
        });
      } else {
        throw Exception('Failed to generate plan');
      }
    } catch (e) {
      setState(() {
        _aiResponse = "Error generating plan. Using default plan instead.\n\n${_getFallbackPlan()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _cleanResponse(String response) {
    // Remove markdown symbols and clean up formatting
    return response
        .replaceAll('**', '')
        .replaceAll('*', '•')
        .replaceAll('#', '')
        .replaceAll(RegExp(r'\[.*?\]'), '')
        .replaceAll(RegExp(r'\(.*?\)'), '')
        .trim();
  }

  String _getFallbackPlan() {
    return """
Daily Routine:
• Morning: Meditation and light stretching
• Afternoon: Walk outside and hydrate
• Evening: Digital detox and reading

Breathing Exercises:
• Box Breathing: 4s inhale, 4s hold, 4s exhale, 4s hold
• Deep Belly Breathing: Focus on diaphragm breathing

Affirmations:
• I am resilient and strong
• My feelings are valid and important
• I choose peace in this moment

Tips:
• Take deep breaths when feeling overwhelmed
• Practice gratitude daily
    """;
  }

  void _updatePlanFromAIResponse(String response) {
    setState(() {
      _currentPlan = {
        'aiGenerated': true,
        'response': response,
        'timestamp': DateTime.now(),
      };
    });
  }

  void _addDummyMoodEntry() {
    final randomMoods = ['happy', 'calm', 'anxious', 'energetic', 'tired'];
    final randomMood = randomMoods[DateTime.now().millisecond % randomMoods.length];

    setState(() {
      _moodHistory.insert(0, {
        'date': DateTime.now().toString().split(' ')[0],
        'mood': randomMood,
        'sleepHours': 6 + (DateTime.now().millisecond % 4),
        'stressLevel': 1 + (DateTime.now().millisecond % 10),
        'activities': ['auto_generated']
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added dummy mood: $randomMood')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Mental Health Plan Generator'),
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _addDummyMoodEntry,
            tooltip: 'Add dummy mood data',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mood Input Section
              Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How are you feeling today?',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _moodController,
                        decoration: InputDecoration(
                          hintText: 'e.g., anxious, happy, stressed, calm...',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.mood),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _generateAIPlan,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: _isLoading
                              ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Text('Generate Personalized Plan'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 7),

              // Current Plan Section
              if (_currentPlan.isNotEmpty && !_currentPlan.containsKey('aiGenerated'))
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Current Plan',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        ..._buildCurrentPlanWidgets(),
                      ],
                    ),
                  ),
                ),

              SizedBox(height: 8),

              // AI Response Section
              if (_aiResponse.isNotEmpty)
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.auto_awesome, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'AI Generated Plan',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: MarkdownBody(
                            data: _aiResponse,
                            styleSheet: MarkdownStyleSheet(
                              p: TextStyle(fontSize: 16, height: 1.4),
                              listBullet: TextStyle(fontSize: 16, height: 1.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              SizedBox(height: 3),

              // Mood History Section
              Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Mood History',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      ..._moodHistory.take(3).map((mood) => ListTile(
                        leading: Icon(_getMoodIcon(mood['mood']), color: _getMoodColor(mood['mood'])),
                        title: Text('${mood['mood']}'.toUpperCase()),
                        subtitle: Text('Date: ${mood['date']} • Stress: ${mood['stressLevel']}/10'),
                        trailing: Text('${mood['sleepHours']}h sleep'),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCurrentPlanWidgets() {
    return [
      if (_currentPlan['dailyRoutine'] != null)
        ..._buildSection('Daily Routine', _currentPlan['dailyRoutine']!),

      if (_currentPlan['breathingExercises'] != null)
        ..._buildSection('Breathing Exercises', _currentPlan['breathingExercises']!),

      if (_currentPlan['affirmations'] != null)
        _buildAffirmationsSection(),

      if (_currentPlan['moodTips'] != null)
        ..._buildSection('Tips', _currentPlan['moodTips']!),
    ];
  }

  List<Widget> _buildSection(String title, List<dynamic> items) {
    return [
      Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue.shade700),
      ),
      SizedBox(height: 8),
      ...items.map((item) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• ', style: TextStyle(fontSize: 16)),
            Expanded(
              child: Text(
                _formatItem(item),
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ),
          ],
        ),
      )),
      SizedBox(height: 16),
    ];
  }

  String _formatItem(dynamic item) {
    if (item is Map<String, dynamic>) {
      if (item.containsKey('time') && item.containsKey('activity')) {
        return '${item['time']}: ${item['activity']}';
      } else if (item.containsKey('name') && item.containsKey('description')) {
        return '${item['name']}: ${item['description']}';
      }
    }
    return item.toString();
  }

  Widget _buildAffirmationsSection() {
    final affirmations = _currentPlan['affirmations'] as List<dynamic>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Affirmations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue.shade700),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: affirmations.map((affirmation) => Chip(
            label: Text(affirmation.toString()),
            backgroundColor: Colors.blue.shade50,
          )).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  IconData _getMoodIcon(String mood) {
    switch (mood) {
      case 'happy': return Icons.sentiment_very_satisfied;
      case 'calm': return Icons.sentiment_satisfied;
      case 'anxious': return Icons.sentiment_very_dissatisfied;
      case 'stressed': return Icons.sentiment_dissatisfied;
      case 'sad': return Icons.sentiment_very_dissatisfied;
      default: return Icons.sentiment_neutral;
    }
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'happy': return Colors.green;
      case 'calm': return Colors.blue;
      case 'anxious': return Colors.orange;
      case 'stressed': return Colors.red;
      case 'sad': return Colors.purple;
      default: return Colors.grey;
    }
  }

  @override
  void dispose() {
    _moodController.dispose();
    super.dispose();
  }
}