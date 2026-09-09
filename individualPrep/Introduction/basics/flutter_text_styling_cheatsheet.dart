// ================================================================
// STUDY FILE (keep me in Introduction/ - I am pure Dart comments,
// so no Flutter project is needed to read me. Real runnable Flutter
// code MUST live inside the app project (myapplication/lib/).
// ================================================================
//
// HOW TO STYLE TEXT IN FLUTTER - THE WHOLE THING ON ONE PAGE
// ----------------------------------------------------------------
//
// 1) THE SKELETON (learn this by heart)
//    Text('your words here', style: TextStyle(...));
//
// 2) THE 5 KNOBS INSIDE TextStyle
//    fontSize        a number -> letter size (40 is big, 14 is small)
//    fontWeight      FontWeight.bold (thick) or FontWeight.w100..w900
//    color           Colors.black, Colors.white, Colors.red, Colors.blue,
//                    Colors.green, Colors.yellow, Colors.teal ...
//    fontStyle       FontStyle.italic (slanted) / normal
//    letterSpacing   a number -> extra space BETWEEN letters
//
// 3) WHERE THE TEXT SITS ON SCREEN
//    textAlign: TextAlign.center   -> centers each LINE (needed when
//                                      the text wraps onto 2 lines!)
//    Center(child: ...)            -> centers a small widget
//    Column(mainAxisAlignment: MainAxisAlignment.center, children:[...])
//                                  -> stacks widgets vertically, centered
//    SizedBox(height: 20)          -> empty space between widgets
//
// 4) COLORS: NAME vs SHADE vs HEX
//    Colors.teal          -> the base color (medium strength)
//    Colors.teal.shade100 -> very LIGHT tint (100) ... shade900 = very DARK
//                            (100,200 = light; 300-600 = medium;
//                             700,800,900 = dark)
//    Color(0xFF1A237E)    -> the same idea written as a CODE: 0xFF =
//                            fully visible, then RR GG BB in hex.
//                            You do NOT need this yet - names are enough.
//    RULE: light background + dark text (or dark background + light text)
//
// 5) WHY SOME SCREENS LOOK "DESIGNED" AND OTHERS "BASIC"
//    A screen with one big text = basic (it looks like you just
//    replaced a word). A screen looks intentional when it has:
//      - a HIERARCHY: icon (decorative) -> big title -> medium name
//        -> tiny label, sizes going DOWN on purpose
//      - ONE ACCENT COLOR repeated in 2-3 places
//        (e.g. teal AppBar + teal icon + teal name)
//      - some breathing space (SizedBox) between the elements
//
// 6) THE TWO VERSIONS WE MADE - COMPARE THEM
//
//    SIMPLE (myapplication/lib/main.dart - the assignment app):
//      white background, teal AppBar, black bold "Hello World",
//      teal name centered, small grey label at the bottom.
//
//    ADVANCED (see below) - same skeleton, more knobs turned on:
//      gradient background, hex colors, shadows, letterSpacing caps,
//      white text on a dark background. Read it to understand what
//      each knob ADDS. To run it, it must sit in myapplication/lib/.
//
//    ADVANCED VERSION (reference only):
//    ----------------------------------------------------------------
//    import 'package:flutter/material.dart';
//
//    const String myName = 'Robert Tony MITALI Niyonkuru';
//
//    void main() => runApp(const MyApp());
//
//    class MyApp extends StatelessWidget {
//      const MyApp({super.key});
//      @override
//      Widget build(BuildContext context) {
//        return MaterialApp(
//          debugShowCheckedModeBanner: false,
//          home: Scaffold(
//            body: Container(
//              width: double.infinity,            // full screen width
//              decoration: const BoxDecoration(
//                gradient: LinearGradient(        // smooth color blend
//                  begin: Alignment.topLeft,
//                  end: Alignment.bottomRight,
//                  colors: [Color(0xFF1A237E), Color(0xFF6A1B9A)],
//                ),
//              ),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  const Text(
//                    'HELLO WORLD',
//                    style: TextStyle(
//                      fontSize: 40,
//                      fontWeight: FontWeight.w900,
//                      color: Colors.white,
//                      letterSpacing: 6,          // spaced caps = title
//                      shadows: [                 // soft shadow behind text
//                        Shadow(
//                          color: Colors.black45,
//                          blurRadius: 12,
//                          offset: Offset(3, 3),
//                        ),
//                      ],
//                    ),
//                  ),
//                  const SizedBox(height: 20),
//                  Text(
//                    'I am $myName',
//                    style: const TextStyle(
//                      fontSize: 24,
//                      fontStyle: FontStyle.italic,
//                      color: Color(0xFFFFD54F),  // warm yellow hex
//                      letterSpacing: 2,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        );
//      }
//    }
//    ----------------------------------------------------------------
//
// 7) PRACTICE DRILLS (do these in a scratch copy of main.dart)
//    a) Change fontSize 38 -> 50. What happens? (text gets bigger)
//    b) Change fontWeight bold -> w100. (letters get thin)
//    c) Change every Colors.teal -> Colors.blue. (one-word swap =
//       whole new look; that's the accent-color trick)
//    d) Delete textAlign on the name line, make the name very long,
//       and watch the second line jump to the left. Put it back.
//    e) Add fontStyle: FontStyle.italic to the grey label.
//    f) Make a Text with letterSpacing: 10 - what does it look like?
// ================================================================
