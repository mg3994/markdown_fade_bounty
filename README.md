**Title:** Fade in newly added Markdown Text

**Prize:** $150

Hello Flutter bounty hunters 🚀 Let’s dive straight into it

### Problem

We’re building an LLM based tool for one of our FilledStacks clients. 

As with ChatGPT, the response from the LLM is streamed back to us. 

The text comes back as it is being completed. 

Here’s an example of how paragraph would be returned:

**The full paragraph**

“I need every new word being added to the text to animate in using a fade functionality. This an example of this can be seen when using Gemini chat.”

**How it’s returned**

“I need”

“I need every new word”

“I need every new word being added to”

“I need every new word being added to the text”

“I need every new word being added to the text to animate in”

“I need every new word being added to the text to animate in using a fade functionality.”

… etc

Similar to ChatGPT, the words just pop in. We’d like it to actually fade in. Similar to how Gemini chat does it.

This must all happen with text rendered through [the Markdown renderer](https://pub.dev/packages/flutter_markdown_selectionarea)

### Expected Solution

Here is a Flutter repo. 

When you tap the FAB it will add more markdown into the screen.

All that I need for the solution is for the newly added text to be faded in slowly instead of just being added immediately.

### Acceptable solutions

- The text must be rendered using the markdown renderer
- Either each word has to gradually fade in separately on a delay
- OR, Each new chuck of text that is added has to gradually be faded in
- You can modify the markdown renderer if you need to (I’ll submit a PR to the repo after)

### Submission details

- Submit your solution as a PR
- PR’s will be reviewed once a day
- The first solution that works will be accepted
- Timestamps of the commits of the working code will be checked before final payment