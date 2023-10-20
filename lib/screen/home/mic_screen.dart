import 'package:e_commerce_app/provider/mic_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MicScreen extends StatefulWidget {
  const MicScreen({super.key});

  @override
  State<MicScreen> createState() => _MicScreenState();
}

class _MicScreenState extends State<MicScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<MicProvider>(context, listen: false).initSpeech(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<MicProvider>(context, listen: false).initSpeech(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Consumer<MicProvider>(
          builder: (context, value, child) => Column(
            children: [
              Row(
                children: [
                  CloseButton(
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Text(
                value.speechToText.isListening
                    ? "listening..."
                    : "Speech not available",
                style: const TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Lottie.asset(
                "assets/lottie/mic.json",
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Expanded(
                child: Text(
                  value.wordsSpoken.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
