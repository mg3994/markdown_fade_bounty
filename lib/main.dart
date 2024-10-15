
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
  final List<String> _textList = [
    '''
### Problem

We’re building an LLM based tool for one of our FilledStacks clients. 
  ''',
    '''
As with ChatGPT, the response from the LLM is streamed back to us.
  ''',
    '''
The text comes back as it 
  ''',
    '''
is being completed. 
  ''',
    '''
Here’s an example of how
  ''',
    '''
paragraph would be returned:
  ''',
    '''
**The full paragraph**

“I need every new
  ''',
    '''
word being added to the text to animate i
  ''',
    '''
n using a fade functionality. This an
  ''',
    '''
example of this can be seen when using Gemini chat.”
  ''',
    '''
**How it’s returned**

“I need”
  ''',
    '''
“I need every new word”
  ''',
    '''
“I need every new word
  ''',
    '''
being added to”
  ''',
    '''
“I need every new word being
  ''',
    '''
added to the text”
  ''',
    '''
“I need every new word being added to the text to animate in”
  ''',
  ];

  String _currentText = "";
  int _index = 0;
  final ScrollController _scrollController = ScrollController();

  // Function to append new text from the list
  void _addText() {
    if (_index < _textList.length) {
      setState(() {
        _currentText += _textList[_index];
        _index++;
      });

      // After the text has been added, scroll to the bottom  (only if content is larger)
      _scrollToBottom();
    }
  }

  final _defaultMessage = 'Tap FAB to add markdown';
  // Function to scroll the content to the bottom
  void _scrollToBottom() {
    // just an improvement to scroll to bottom
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
        title: const Text('Animated Text Display'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            controller: _scrollController, // Attach scroll controller
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              // TODO:
              // try modifying this by using layoutBuilder parm (not to by default) to something else where layout related stuff is minimum

              // by default there but you can modify it => it is must to modify
              // layoutBuilder: (currentChild, previousChildren) {
              //   return Stack(
              //     alignment: Alignment.center,
              //     children: <Widget>[
              //       ...previousChildren,
              //       if (currentChild != null) currentChild,
              //     ],
              //   );
              // },

              /// By default there but you can modify it
              // transitionBuilder: (Widget child, Animation<double> animation) {
              //   return FadeTransition(
              //     opacity: animation,
              //     child: child,
              //   );
              // },
              child: (_currentText == "")
                  ? Text(_defaultMessage)
                  : MarkdownBody(
                      data: _currentText, // The text we are animating
                      key: ValueKey<String>(
                          // Main thing is that No one is using Keys , and these Keys makes animation Smoother
                          _currentText), // Assign unique key for animation
                    ),
            ),
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
}
