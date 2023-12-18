/*import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quill Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  QuillController _controller = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            QuillToolbar.basic(
              controller: _controller,
              toolbarIconSize: 25,
              iconTheme: QuillIconTheme(
                borderRadius: 14,
                iconSelectedFillColor: Colors.orange,
              ),
            ),
            QuillEditor.basic(
                controller: _controller,
                readOnly: false
            )
          ],
        ));
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

void main() {
  runApp(MaterialApp(
    home: EditableRichTextApp(),
  ));
}

class EditableRichTextApp extends StatefulWidget {
  @override
  _EditableRichTextAppState createState() => _EditableRichTextAppState();
}

class _EditableRichTextAppState extends State<EditableRichTextApp> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: 'This is editable rich text.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editable Rich Text Example'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Edit the text',
              ),
            ),
            SizedBox(height: 20),

            // Include the TeXView widget here
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20
              ),
              child: KaTeX(
                laTeXCode: Text(
                    r"This is a question $x=3^2+3^2$",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "CustomFont-Bold"
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  */
import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:math_parser/math_parser.dart';
import 'package:math_keyboard/math_keyboard.dart';

void main() {
  runApp(MaterialApp(
    home: QuillHtmlEditorApp(),
  ));
}

class QuillHtmlEditorApp extends StatefulWidget {
  @override
  _QuillHtmlEditorAppState createState() => _QuillHtmlEditorAppState();
}

class _QuillHtmlEditorAppState extends State<QuillHtmlEditorApp> {
  final QuillEditorController controller = QuillEditorController();
  final MathFieldEditingController mathFieldController = MathFieldEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Type your text'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 300, // Adjust the height as needed
                  child: QuillHtmlEditor(
                    text: "write your Text Here !",
                    hintText: 'Hint text goes here',
                    controller: controller,
                    isEnabled: true,
                    minHeight: 300,
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                    hintTextStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintTextAlign: TextAlign.start,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    hintTextPadding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
                    onTextChanged: (text) => debugPrint('widget text change $text'),
                    onEditorCreated: () => debugPrint('Editor has been loaded'),
                    onEditingComplete: (s) => debugPrint('Editing completed $s'),
                    onEditorResized: (height) => debugPrint('Editor resized $height'),
                    onSelectionChanged: (sel) => debugPrint('${sel.index},${sel.length}'),
                    loadingBuilder: (context) {
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 0.4,
                        ),
                      );
                    },
                  ),
                ),
                MathField(
                  controller: mathFieldController,
                  onChanged: (value) {
                    // Handle the mathematical equation input.
                    String expression;
                    try {
                      expression = '${TeXParser(value).parse()}';
                    } catch (_) {
                      expression = 'invalid input';
                    }
                    print('Math input expression: $value\n'
                        'Converted expression: $expression');
                  },
                ),
              ],
            ),
          ),
          ToolBar(
            toolBarColor: Colors.cyan.shade50,
            activeIconColor: Colors.green,
            padding: const EdgeInsets.all(8),
            iconSize: 20,
            controller: controller,
            customButtons: [
              InkWell(
                onTap: () {
                  // Custom button 1 action
                  // You can implement your own functionality here.
                  debugPrint('Custom button 1 tapped');
                },
                child: Icon(Icons.favorite),
              ),
              InkWell(
                onTap: () {
                  // Custom button 2 action
                  // You can implement your own functionality here.
                  debugPrint('Custom button 2 tapped');
                },
                child: Icon(Icons.add_circle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

