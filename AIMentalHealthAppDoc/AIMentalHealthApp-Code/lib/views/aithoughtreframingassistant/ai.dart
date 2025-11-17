import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';

class ThoughtReframingAssistant extends StatefulWidget {
  const ThoughtReframingAssistant({super.key});

  @override
  ThoughtReframingAssistantState createState() => ThoughtReframingAssistantState();
}

class ThoughtReframingAssistantState extends State<ThoughtReframingAssistant> {
  final TextEditingController _thoughtController = TextEditingController();
  final List<ThoughtSession> _sessions = [];
  bool _isAnalyzing = false;
  final ScrollController _scrollController = ScrollController();

  // Gemini API configuration
  static const String geminiApiKey = 'AIzaSyBb3zlhns69XVf0rIkRV1_nbwSU-C4WiEk';
  static const String apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiApiKey';

  // Common cognitive distortions for detection
  final List<String> _cognitiveDistortions = [
    'All-or-nothing thinking',
    'Overgeneralization',
    'Mental filter',
    'Disqualifying the positive',
    'Jumping to conclusions',
    'Magnification or minimization',
    'Emotional reasoning',
    'Should statements',
    'Labeling',
    'Personalization'
  ];

  @override
  void initState() {
    super.initState();
    _loadExampleSessions();
  }

  void _loadExampleSessions() {
    setState(() {
      _sessions.addAll([
        ThoughtSession(
          originalThought: "I made a mistake at work today. I'm such a failure.",
          reframedThought: "I made one mistake today, but that doesn't define my overall competence. Everyone makes mistakes sometimes, and I can learn from this experience.",
          distortions: ['Labeling', 'All-or-nothing thinking'],
          techniques: ['Evidence-based thinking', 'Perspective shifting'],
          timestamp: DateTime.now().subtract(Duration(hours: 2)),
        ),
        ThoughtSession(
          originalThought: "Nobody reached out to me today. They must not care about me.",
          reframedThought: "People have busy lives and their own priorities. Their lack of contact today doesn't reflect their care for me. I can reach out if I want connection.",
          distortions: ['Mind reading', 'Overgeneralization'],
          techniques: ['Alternative explanations', 'Reality testing'],
          timestamp: DateTime.now().subtract(Duration(days: 1)),
        ),
      ]);
    });
  }

  Future<void> _reframeThought() async {
    final thought = _thoughtController.text.trim();
    if (thought.isEmpty) return;

    setState(() {
      _isAnalyzing = true;
    });

    _thoughtController.clear();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "contents": [
            {
              "parts": [
                {
                  "text": "Analyze this thought for cognitive distortions and provide a balanced reframing. Follow this exact structure:\n\nOriginal Thought: \"$thought\"\n\n**DISTORTIONS**\n[List 1-3 specific cognitive distortions from: All-or-nothing thinking, Overgeneralization, Mental filter, Disqualifying the positive, Jumping to conclusions, Magnification or minimization, Emotional reasoning, Should statements, Labeling, Personalization]\n\n**REFRAIMED_THOUGHT**\n[Provide a balanced, evidence-based alternative thought that is compassionate and realistic]\n\n**TECHNIQUES**\n[List 2-3 cognitive behavioral techniques used in the reframing like: Evidence collection, Perspective shifting, Alternative explanations, Reality testing, Compassionate self-talk, Graded thinking]"
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseText = data['candidates'][0]['content']['parts'][0]['text'];
        final session = _parseReframingResponse(thought, responseText);

        setState(() {
          _sessions.insert(0, session);
          _isAnalyzing = false;
        });

        _scrollToTop();
      } else {
        throw Exception('Failed to analyze thought');
      }
    } catch (e) {
      _showError('Analysis failed. Please try again.');
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  ThoughtSession _parseReframingResponse(String originalThought, String response) {
    List<String> distortions = [];
    String reframedThought = '';
    List<String> techniques = [];

    try {
      List<String> lines = response.split('\n');
      bool inDistortions = false;
      bool inReframed = false;
      bool inTechniques = false;

      for (String line in lines) {
        line = line.trim();

        if (line.contains('**DISTORTIONS**')) {
          inDistortions = true;
          inReframed = false;
          inTechniques = false;
          continue;
        } else if (line.contains('**REFRAIMED_THOUGHT**')) {
          inDistortions = false;
          inReframed = true;
          inTechniques = false;
          continue;
        } else if (line.contains('**TECHNIQUES**')) {
          inDistortions = false;
          inReframed = false;
          inTechniques = true;
          continue;
        }

        if (inDistortions && line.isNotEmpty && !line.startsWith('**')) {
          // Clean the line and check if it matches known distortions
          String cleanLine = line.replaceAll('-', '').replaceAll('*', '').trim();
          for (String distortion in _cognitiveDistortions) {
            if (cleanLine.toLowerCase().contains(distortion.toLowerCase())) {
              distortions.add(distortion);
            }
          }
        } else if (inReframed && line.isNotEmpty && !line.startsWith('**')) {
          reframedThought = line;
        } else if (inTechniques && line.isNotEmpty && !line.startsWith('**')) {
          techniques.add(line.replaceAll('-', '').replaceAll('*', '').trim());
        }
      }

      // Fallback if parsing fails
      if (reframedThought.isEmpty) {
        reframedThought = "Let's look at this thought from a balanced perspective. What evidence supports or challenges this thought?";
      }
      if (distortions.isEmpty) {
        distortions = ['Thinking pattern to explore'];
      }
      if (techniques.isEmpty) {
        techniques = ['Balanced perspective', 'Evidence collection'];
      }
    } catch (e) {
      // Default response if parsing completely fails
      reframedThought = "This thought might benefit from a more balanced perspective. Consider what evidence supports this thought and what alternative explanations might exist.";
      distortions = ['Pattern recognition'];
      techniques = ['Cognitive restructuring'];
    }

    return ThoughtSession(
      originalThought: originalThought,
      reframedThought: reframedThought,
      distortions: distortions,
      techniques: techniques,
      timestamp: DateTime.now(),
    );
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _saveSession(int index) {
    setState(() {
      _sessions[index].isSaved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thought session saved!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _getDistortionEmoji(String distortion) {
    switch (distortion.toLowerCase()) {
      case 'all-or-nothing thinking': return '⚫';
      case 'overgeneralization': return '🔄';
      case 'mental filter': return '🔍';
      case 'disqualifying the positive': return '🚫';
      case 'jumping to conclusions': return '🎯';
      case 'magnification or minimization': return '⚖️';
      case 'emotional reasoning': return '💭';
      case 'should statements': return '📋';
      case 'labeling': return '🏷️';
      case 'personalization': return '👤';
      default: return '💡';
    }
  }

  Color _getDistortionColor(String distortion) {
    switch (distortion.toLowerCase()) {
      case 'all-or-nothing thinking': return Colors.red;
      case 'overgeneralization': return Colors.orange;
      case 'mental filter': return Colors.amber;
      case 'disqualifying the positive': return Colors.purple;
      case 'jumping to conclusions': return Colors.blue;
      case 'magnification or minimization': return Colors.teal;
      case 'emotional reasoning': return Colors.pink;
      case 'should statements': return Colors.indigo;
      case 'labeling': return Colors.brown;
      case 'personalization': return Colors.cyan;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Thought Reframing',
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
          PopupMenuButton<String>(
            icon: Icon(Icons.help_outline, color: Colors.blue[800]),
            onSelected: (value) => _showHelpDialog(value),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'distortions', child: Text('Cognitive Distortions')),
              PopupMenuItem(value: 'techniques', child: Text('Reframing Techniques')),
              PopupMenuItem(value: 'examples', child: Text('Examples')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Input Section
          _buildInputSection(),

          // Sessions List
          Expanded(
            child: _sessions.isEmpty ? _buildEmptyState() : _buildSessionsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Identify and reframe negative thoughts',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              controller: _thoughtController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe your thought or worry...\nExample: "I\'ll never be good enough at this"',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: _isAnalyzing ? null : _reframeThought,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isAnalyzing
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 12),
                Text('Analyzing Thought...'),
              ],
            )
                : Text('Reframe Thought'),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsList() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(16),
      itemCount: _sessions.length,
      itemBuilder: (context, index) {
        return _buildSessionCard(_sessions[index], index);
      },
    );
  }

  Widget _buildSessionCard(ThoughtSession session, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.psychology, color: Colors.red[800], size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Original Thought',
                      style: TextStyle(
                        color: Colors.red[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    if (session.isSaved)
                      Icon(Icons.bookmark, color: Colors.blue[800], size: 16),
                    Text(
                      _formatTime(session.timestamp),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  session.originalThought,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Distortions
          if (session.distortions.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.grey[100]!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange[800], size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Cognitive Distortions Detected',
                        style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: session.distortions.map((distortion) => Chip(
                      backgroundColor: _getDistortionColor(distortion).withValues(alpha: 0.1),
                      label: Text(
                        distortion,
                        style: TextStyle(
                          color: _getDistortionColor(distortion),
                          fontSize: 12,
                        ),
                      ),
                      avatar: Text(_getDistortionEmoji(distortion)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )).toList(),
                  ),
                ],
              ),
            ),

          // Reframed Thought
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.green[800], size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Balanced Perspective',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                MarkdownBody(
                  data: session.reframedThought,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Techniques
          if (session.techniques.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.construction, color: Colors.blue[800], size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Techniques Used',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: session.techniques.map((technique) => Chip(
                      backgroundColor: Colors.blue[100],
                      label: Text(
                        technique,
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 12,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

          // Actions
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _saveSession(index),
                    icon: Icon(
                      session.isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: 18,
                    ),
                    label: Text(session.isSaved ? 'Saved' : 'Save'),
                    style: TextButton.styleFrom(
                      foregroundColor: session.isSaved ? Colors.blue[800] : Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _shareSession(session),
                    icon: Icon(Icons.share, size: 18),
                    label: Text('Share'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.psychology_outlined,
            size: 64,
            color: Colors.blue[300],
          ),
          SizedBox(height: 16),
          Text(
            'Start reframing your thoughts',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Write down a negative or worried thought to get a balanced, evidence-based perspective',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(String type) {
    String title = '';
    String content = '';

    switch (type) {
      case 'distortions':
        title = 'Cognitive Distortions';
        content = '''
• All-or-nothing thinking: Seeing things in black-or-white categories
• Overgeneralization: Viewing a single event as a never-ending pattern
• Mental filter: Focusing exclusively on negative details
• Disqualifying the positive: Rejecting positive experiences
• Jumping to conclusions: Mind reading or fortune telling
• Magnification/minimization: Exaggerating or minimizing importance
• Emotional reasoning: "I feel it, therefore it must be true"
• Should statements: Using "should", "must", or "ought" statements
• Labeling: Identifying with your shortcomings
• Personalization: Taking responsibility for events outside your control
        ''';
        break;
      case 'techniques':
        title = 'Reframing Techniques';
        content = '''
• Evidence collection: What facts support or challenge this thought?
• Perspective shifting: How would others see this situation?
• Alternative explanations: What other interpretations are possible?
• Reality testing: Testing thoughts against actual evidence
• Compassionate self-talk: Speaking to yourself as a good friend
• Graded thinking: Moving from extreme to moderate perspectives
        ''';
        break;
      case 'examples':
        title = 'Example Thoughts';
        content = '''
• "I failed this test → I'm a total failure"
• "They didn't text back → They must hate me"
• "I made a mistake → I can't do anything right"
• "This is taking too long → I'll never finish"
• "One person criticized me → Everyone thinks I'm incompetent"
        ''';
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: MarkdownBody(data: content),
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

  void _shareSession(ThoughtSession session) {
    // In a real app, this would use the share package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share functionality would open here'),
        backgroundColor: Colors.blue,
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

  @override
  void dispose() {
    _thoughtController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ThoughtSession {
  final String originalThought;
  final String reframedThought;
  final List<String> distortions;
  final List<String> techniques;
  final DateTime timestamp;
  bool isSaved;

  ThoughtSession({
    required this.originalThought,
    required this.reframedThought,
    required this.distortions,
    required this.techniques,
    required this.timestamp,
    this.isSaved = false,
  });
}