import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MotivationAssistant extends StatefulWidget {
  const MotivationAssistant({super.key});

  @override
  MotivationAssistantState createState() => MotivationAssistantState();
}

class MotivationAssistantState extends State<MotivationAssistant> {
  final List<MotivationItem> _motivationHistory = [];
  bool _isLoading = false;
  Timer? _dailyMotivationTimer;
  Timer? _moodCheckTimer;

  // User behavior patterns (simulated)
  final Map<String, dynamic> _userBehavior = {
    'lastMoodCheck': DateTime.now(),
    'motivationFrequency': 3, // times per day
    'preferredCategories': ['mindfulness', 'growth', 'positivity'],
    'stressPatterns': ['morning', 'afternoon'],
    'lastInteraction': DateTime.now(),
  };

  // Gemini API configuration
  static const String geminiApiKey = 'AIzaSyBb3zlhns69XVf0rIkRV1_nbwSU-C4WiEk';
  static const String apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiApiKey';

  @override
  void initState() {
    super.initState();
    _startBehavioralTimers();
    _loadInitialMotivation();
  }

  void _startBehavioralTimers() {
    // Daily motivation at optimal times (morning, afternoon, evening)
    _dailyMotivationTimer = Timer.periodic(Duration(hours: 8), (timer) {
      _sendScheduledMotivation();
    });

    // Mood check every 4 hours
    _moodCheckTimer = Timer.periodic(Duration(hours: 4), (timer) {
      _checkUserMoodPattern();
    });
  }

  Future<void> _loadInitialMotivation() async {
    await _generateMotivationalQuote();
  }

  Future<void> _generateMotivationalQuote() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "contents": [
            {
              "parts": [
                {
                  "text": "Generate a personalized motivational quote and practical reminder based on mental health best practices. Consider these user patterns: ${_userBehavior['preferredCategories']}. The user might need encouragement for ${_userBehavior['stressPatterns'].join(', ')}. Provide response in this exact format:\n\n**QUOTE**\n[The motivational quote here]\n\n**REMINDER**\n[Practical action step here]\n\n**CATEGORY**\n[One of: mindfulness, growth, positivity, resilience, self-care]"
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseText = data['candidates'][0]['content']['parts'][0]['text'];
        final motivationItem = _parseMotivationResponse(responseText);

        setState(() {
          _motivationHistory.insert(0, motivationItem);
          _isLoading = false;
        });

        // Update user behavior
        _updateUserBehavior(motivationItem.category);

        // Show in-app notification for important messages
        if (_shouldShowInAppNotification(motivationItem.category)) {
          _showInAppMotivationAlert(motivationItem);
        }
      } else {
        throw Exception('Failed to generate motivation');
      }
    } catch (e) {
      _showDefaultMotivation();
    }
  }

  MotivationItem _parseMotivationResponse(String response) {
    String quote = '';
    String reminder = '';
    String category = 'positivity';

    try {
      List<String> lines = response.split('\n');
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains('**QUOTE**')) {
          quote = lines[i + 1].trim();
        } else if (lines[i].contains('**REMINDER**')) {
          reminder = lines[i + 1].trim();
        } else if (lines[i].contains('**CATEGORY**')) {
          category = lines[i + 1].trim().toLowerCase();
        }
      }
    } catch (e) {
      // Fallback if parsing fails
      quote = "Your mental health is a priority. Your happiness is essential. Your self-care is necessary.";
      reminder = "Take three deep breaths and acknowledge one thing you're grateful for today.";
    }

    return MotivationItem(
      quote: quote,
      reminder: reminder,
      category: category,
      timestamp: DateTime.now(),
      isAIGenerated: true,
    );
  }

  void _updateUserBehavior(String category) {
    setState(() {
      _userBehavior['lastInteraction'] = DateTime.now();

      // Update preferred categories based on usage
      if (!_userBehavior['preferredCategories'].contains(category)) {
        _userBehavior['preferredCategories'].add(category);
      }
    });
  }

  bool _shouldShowInAppNotification(String category) {
    // Show alerts for high-impact categories or during stress patterns
    final now = DateTime.now();
    final hour = now.hour;

    bool isStressTime = (hour >= 8 && hour <= 10) || (hour >= 15 && hour <= 17);
    bool isImportantCategory = ['resilience', 'self-care'].contains(category);

    return isStressTime || isImportantCategory;
  }

  void _showInAppMotivationAlert(MotivationItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '💫 Mindful Moment',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              item.quote.length > 60 ? '${item.quote.substring(0, 60)}...' : item.quote,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: _getCategoryColor(item.category),
        duration: Duration(seconds: 4),
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.white,
          onPressed: () {
            // Already viewing since it's added to history
          },
        ),
      ),
    );
  }

  void _sendScheduledMotivation() async {
    if (_shouldSendBasedOnBehavior()) {
      await _generateMotivationalQuote();
    }
  }

  void _checkUserMoodPattern() {
    final now = DateTime.now();
    final lastInteraction = _userBehavior['lastInteraction'];
    final hoursSinceInteraction = now.difference(lastInteraction).inHours;

    if (hoursSinceInteraction > 6) {
      // User hasn't interacted in a while - they might need encouragement
      _generateMotivationalQuote();
    }
  }

  bool _shouldSendBasedOnBehavior() {
    final now = DateTime.now();
    final hour = now.hour;

    // Send during typical low-energy or high-stress times
    return (hour >= 7 && hour <= 9) ||    // Morning motivation
        (hour >= 13 && hour <= 14) ||  // Afternoon slump
        (hour >= 19 && hour <= 21);    // Evening reflection
  }

  void _showDefaultMotivation() {
    setState(() {
      _motivationHistory.insert(0, MotivationItem(
        quote: "Even the smallest step forward is progress worth celebrating.",
        reminder: "Take a moment to acknowledge how far you've come, not just how far you have to go.",
        category: "positivity",
        timestamp: DateTime.now(),
        isAIGenerated: false,
      ));
      _isLoading = false;
    });
  }

  void _markAsHelpful(int index) {
    setState(() {
      _motivationHistory[index].isHelpful = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thanks for your feedback!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _saveMotivation(int index) {
    setState(() {
      _motivationHistory[index].isSaved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Motivation saved to favorites!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  String _getCategoryEmoji(String category) {
    switch (category) {
      case 'mindfulness': return '🧘';
      case 'growth': return '🌱';
      case 'positivity': return '✨';
      case 'resilience': return '💪';
      case 'self-care': return '💖';
      default: return '💫';
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'mindfulness': return Colors.purple;
      case 'growth': return Colors.green;
      case 'positivity': return Colors.orange;
      case 'resilience': return Colors.blue;
      case 'self-care': return Colors.pink;
      default: return Colors.blue;
    }
  }

  @override
  void dispose() {
    _dailyMotivationTimer?.cancel();
    _moodCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Motivation Assistant',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue[800]),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.insights, color: Colors.blue[800]),
            onPressed: _showBehaviorInsights,
          ),
        ],
      ),
      body: Column(
        children: [
          // Current Motivation Card
          if (_motivationHistory.isNotEmpty) _buildCurrentMotivation(),

          // History List
          Expanded(
            child: _motivationHistory.isEmpty
                ? _buildEmptyState()
                : _buildMotivationHistory(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _generateMotivationalQuote,
        backgroundColor: Colors.blue[800],
        child: _isLoading
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2,
        )
            : Icon(Icons.auto_awesome, color: Colors.white),
      ),
    );
  }

  Widget _buildCurrentMotivation() {
    final current = _motivationHistory.first;
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getCategoryColor(current.category).withValues(alpha: 0.1),
            _getCategoryColor(current.category).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getCategoryColor(current.category).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _getCategoryEmoji(current.category),
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 8),
              Text(
                current.category.toUpperCase(),
                style: TextStyle(
                  color: _getCategoryColor(current.category),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              Spacer(),
              if (current.isSaved)
                Icon(Icons.bookmark, color: Colors.blue[800], size: 16),
              SizedBox(width: 8),
              if (current.isAIGenerated)
                Icon(Icons.auto_awesome, color: Colors.amber, size: 16),
            ],
          ),
          SizedBox(height: 16),
          Text(
            current.quote,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.tips_and_updates, color: Colors.amber, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    current.reminder,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _markAsHelpful(0),
                  icon: Icon(Icons.thumb_up, size: 18),
                  label: Text('Helpful'),
                  style: TextButton.styleFrom(
                    foregroundColor: current.isHelpful ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _saveMotivation(0),
                  icon: Icon(
                    current.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    size: 18,
                  ),
                  label: Text(current.isSaved ? 'Saved' : 'Save'),
                  style: TextButton.styleFrom(
                    foregroundColor: current.isSaved ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationHistory() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _motivationHistory.length > 1 ? _motivationHistory.length - 1 : 0,
      itemBuilder: (context, index) {
        final item = _motivationHistory[index + 1]; // Skip current (first) item
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(_getCategoryEmoji(item.category)),
                  SizedBox(width: 8),
                  Text(
                    item.category.toUpperCase(),
                    style: TextStyle(
                      color: _getCategoryColor(item.category),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Spacer(),
                  Text(
                    _formatTime(item.timestamp),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                item.quote,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              if (item.isHelpful)
                Row(
                  children: [
                    Icon(Icons.thumb_up, size: 12, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      'Marked helpful',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 64,
            color: Colors.blue[300],
          ),
          SizedBox(height: 16),
          Text(
            'Your personalized motivation\nwill appear here',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the + button to get started',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showBehaviorInsights() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Your Motivation Patterns'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📊 Behavioral Insights', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('• Preferred categories: ${_userBehavior['preferredCategories'].join(', ')}'),
            SizedBox(height: 8),
            Text('• Motivation frequency: ${_userBehavior['motivationFrequency']}x daily'),
            SizedBox(height: 8),
            Text('• Last interaction: ${_formatTime(_userBehavior['lastInteraction'])}'),
            SizedBox(height: 12),
            Text('The AI adapts to your patterns to provide timely encouragement when you need it most.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class MotivationItem {
  final String quote;
  final String reminder;
  final String category;
  final DateTime timestamp;
  final bool isAIGenerated;
  bool isHelpful;
  bool isSaved;

  MotivationItem({
    required this.quote,
    required this.reminder,
    required this.category,
    required this.timestamp,
    required this.isAIGenerated,
    this.isHelpful = false,
    this.isSaved = false,
  });
}