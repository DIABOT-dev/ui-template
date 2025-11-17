import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';

class MoodScanner extends StatefulWidget {
  const MoodScanner({super.key});

  @override
  MoodScannerState createState() => MoodScannerState();
}

class MoodScannerState extends State<MoodScanner> {
  File? _selectedImage;
  bool _isAnalyzing = false;
  String _analysisResult = '';
  List<String> _wellnessSuggestions = [];
  final ImagePicker _picker = ImagePicker();

  // Gemini API configuration
  static const String geminiApiKey = 'AIzaSyBb3zlhns69XVf0rIkRV1_nbwSU-C4WiEk';
  static const String apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiApiKey';

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _analysisResult = '';
          _wellnessSuggestions = [];
        });
        _analyzeMood();
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  Future<void> _analyzeMood() async {
    if (_selectedImage == null) return;

    setState(() {
      _isAnalyzing = true;
      _analysisResult = '';
      _wellnessSuggestions = [];
    });

    try {
      // Read image bytes
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "contents": [
            {
              "parts": [
                {
                  "text": "Analyze this facial expression and detect the emotional state. Look for signs of happiness, sadness, anger, fear, surprise, disgust, or neutral state. Consider facial features like eyes, eyebrows, mouth, and overall expression. Provide a brief analysis of the detected emotion and its intensity."
                },
                {
                  "inline_data": {
                    "mime_type": "image/jpeg",
                    "data": base64Image
                  }
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final analysis = data['candidates'][0]['content']['parts'][0]['text'];

        // Get wellness suggestions based on the analysis
        await _getWellnessSuggestions(analysis);
      } else {
        throw Exception('Failed to analyze image');
      }
    } catch (e) {
      _showError('Analysis failed: $e');
    } finally {
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  Future<void> _getWellnessSuggestions(String moodAnalysis) async {
    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "contents": [
            {
              "parts": [
                {
                  "text": "Based on this mood analysis: \"$moodAnalysis\" - Provide 5 personalized wellness suggestions. Format each suggestion with a title and brief description. Make them practical, actionable, and supportive for mental health. Focus on immediate relief and long-term wellbeing. Return in this exact format:\n\n**Title 1**\nDescription 1\n\n**Title 2**\nDescription 2\n\n**Title 3**\nDescription 3\n\n**Title 4**\nDescription 4\n\n**Title 5**\nDescription 5"
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final suggestionsText = data['candidates'][0]['content']['parts'][0]['text'];

        setState(() {
          _analysisResult = moodAnalysis;
          _wellnessSuggestions = _parseSuggestions(suggestionsText);
        });
      } else {
        throw Exception('Failed to get suggestions');
      }
    } catch (e) {
      _showError('Failed to get wellness suggestions: $e');
    }
  }

  List<String> _parseSuggestions(String text) {
    List<String> suggestions = [];
    List<String> lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      if (lines[i].trim().isNotEmpty) {
        suggestions.add(lines[i].trim());
      }
    }

    return suggestions;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _resetScanner() {
    setState(() {
      _selectedImage = null;
      _analysisResult = '';
      _wellnessSuggestions = [];
      _isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Mood Scanner',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: BackButton(),
        centerTitle: true,
        actions: [
          if (_selectedImage != null)
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.blue[800]),
              onPressed: _resetScanner,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Selection Section
            _buildImageSection(),

            SizedBox(height: 24),

            // Analysis Results
            if (_analysisResult.isNotEmpty) _buildAnalysisSection(),

            // Wellness Suggestions
            if (_wellnessSuggestions.isNotEmpty) _buildSuggestionsSection(),

            // Loading Indicator
            if (_isAnalyzing) _buildLoadingSection(),
          ],
        ),
      ),
      floatingActionButton: _selectedImage == null ? _buildImageSelectionButtons() : null,
    );
  }

  Widget _buildImageSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: _selectedImage == null
          ? SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.face_retouching_natural,
              size: 64,
              color: Colors.blue[300],
            ),
            SizedBox(height: 16),
            Text(
              'Select an image to analyze your mood',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      )
          : Stack(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: FileImage(_selectedImage!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_isAnalyzing)
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageSelectionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'camera',
          onPressed: () => _pickImage(ImageSource.camera),
          backgroundColor: Colors.blue[800],
          mini: true,
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
        SizedBox(width: 20),
        FloatingActionButton(
          heroTag: 'gallery',
          onPressed: () => _pickImage(ImageSource.gallery),
          backgroundColor: Colors.blue[800],
          mini: true,
          child: Icon(Icons.photo_library, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildAnalysisSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: Colors.blue[800]),
              SizedBox(width: 8),
              Text(
                'Mood Analysis',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          MarkdownBody(
            data: _analysisResult,
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
    );
  }

  Widget _buildSuggestionsSection() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.health_and_safety, color: Colors.green[800]),
              SizedBox(width: 8),
              Text(
                'Personalized Wellness Suggestions',
                style: TextStyle(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ..._wellnessSuggestions.asMap().entries.map((entry) {
            int _ = entry.key;
            String suggestion = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: MarkdownBody(
                data: suggestion,
                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  strong: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!),
          ),
          SizedBox(height: 16),
          Text(
            'Analyzing your mood...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'This may take a few moments',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}