import 'package:flutter/material.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown_selectionarea.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Text Display',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimatedTextScreen(),
    );
  }
}

class AnimatedTextScreen extends StatefulWidget {
  const AnimatedTextScreen({super.key});

  @override
  State createState() => _AnimatedTextScreenState();
}

class _AnimatedTextScreenState extends State<AnimatedTextScreen> {
  String _currentText = "## Problem\nThis is"; // Initial text
  final ScrollController _scrollController = ScrollController();
  final List<String> _incomingTexts = [
    "## Problem\nThis is the main issue with what",
    "## Problem\nThis is the main issue with what we're trying to solve.",
    "## Problem\nThis is the main issue with what we're trying to solve. The current solution is insufficient for handling edge cases.",
    "## Problem\nThis is the main issue with what we're trying to solve. The current solution is insufficient for handling edge cases, and it leads to frequent breakdowns in production.",
    "## Problem\nThis is the main issue with what we're trying to solve. The current solution is insufficient for handling edge cases, and it leads to frequent breakdowns in production. As a result, customer satisfaction has dropped significantly.",
    "## Problem\nThis is the main issue with what we're trying to solve. The current solution is insufficient for handling edge cases, and it leads to frequent breakdowns in production. As a result, customer satisfaction has dropped significantly. Several team members have reported difficulties in maintaining the current codebase.",
    "## Problem\nThis is the main issue with what we're trying to solve. The current solution is insufficient for handling edge cases, and it leads to frequent breakdowns in production. As a result, customer satisfaction has dropped significantly. Several team members have reported difficulties in maintaining the current codebase, and urgent hotfixes are often required.",
    "## Problem\nThis is the main issue with what we're trying to solve. The current solution is insufficient for handling edge cases, and it leads to frequent breakdowns in production. As a result, customer satisfaction has dropped significantly. Several team members have reported difficulties in maintaining the current codebase, and urgent hotfixes are often required. The development cycle has slowed down due to these issues.",
    "## Problem\nThis is the main issue with what we're trying to solve. The current solution is insufficient for handling edge cases, and it leads to frequent breakdowns in production. As a result, customer satisfaction has dropped significantly. Several team members have reported difficulties in maintaining the current codebase, and urgent hotfixes are often required. The development cycle has slowed down due to these issues, resulting in missed deadlines.",
    "## Problem\nThis is the main issue with what we're trying to solve. The current solution is insufficient for handling edge cases, and it leads to frequent breakdowns in production. As a result, customer satisfaction has dropped significantly. Several team members have reported difficulties in maintaining the current codebase, and urgent hotfixes are often required. The development cycle has slowed down due to these issues, resulting in missed deadlines and higher costs."
  ];

  int _textIndex = 0;

  // Function to append new text
  void _addText() {
    if (_textIndex < _incomingTexts.length) {
      setState(() {
        _currentText = _incomingTexts[_textIndex]; // Simulate backend response
        _textIndex++;
      });
      _scrollToBottom();
    }
  }

  // Function to scroll to the bottom
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Markdown  Display'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Attach scroll controller
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          // Modify layout builder to handle transitions
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          // Smooth transition for the Markdown
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          // Display current Markdown text with a unique key
          child: MarkdownBody(
            data: _currentText,
            key: ValueKey<String>(
                _currentText), // Use ValueKey to trigger animation
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addText,
        tooltip: 'Add Text',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
