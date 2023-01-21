import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'music_page.dart';
import 'provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerList,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Audio Music State with Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Audio Music State with Provider"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MusicPage()));
              },
              child: const Text("Navigate to music page"),
            )
          ],
        ),
      ),
      bottomNavigationBar: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    musicProvider.pausePlayAudio();
                  },
                  icon: Icon(
                    musicProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
