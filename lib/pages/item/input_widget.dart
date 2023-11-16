import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/provider/student_notifier.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class StudentInput extends ConsumerWidget {
  const StudentInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //テキストの入力値を一時的に保持するのための変数
    final sectionText = ref.watch(sectionTextProvider);
    final stutdentNameText = ref.watch(studentNameTextProvider);

    //保持したテキスト情報、削除用のための変数
    final studentsStateSet = ref.read(studentsProvider.notifier);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'クラス名・氏名の入力',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          child: TextFormField(
            controller: sectionText,
            maxLength: 10,
            decoration: const InputDecoration(
                suffixIcon: SpeechButton(),
                filled: true,
                fillColor: Colors.white54,
                hintText: 'クラス名'),
          ),
        ),
        SizedBox(
          child: TextFormField(
            controller: stutdentNameText,
            maxLength: 10,
            decoration: const InputDecoration(
                suffixIcon: SpeechButton(),
                filled: true,
                fillColor: Colors.white54,
                hintText: '氏名'),
          ),
        ),
        SizedBox(
          child: ElevatedButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () => {
              //StateNotifierの各リストにテキスト情報を追加
              studentsStateSet.addStudent(
                  sectionText.text, stutdentNameText.text),
              debugPrint(
                  '登録ボタン押下: 組${sectionText.text}、氏名${stutdentNameText.text}'),
              //登録完了後にテキスト情報を初期化
              sectionText.clear(),
              stutdentNameText.clear(),
              debugPrint(
                  '登録後にtextFormField初期化: 組${sectionText.text}、氏名${stutdentNameText.text}'),
            },
            child: const Text('登録'),
          ),
        ),
      ],
    );
  }
}

//音声入力用ボタン　使いまわすよう
class SpeechButton extends StatelessWidget {
  const SpeechButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SpeechToText()),
        );
      },
      icon: const Icon(Icons.mic),
    );
  }
}

//音声入力用 StatefulWidget TODO:StatlessWEWidgetにできないか？
class SpeechToText extends StatefulWidget {
  const SpeechToText({super.key});

  @override
  State<SpeechToText> createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  String _words = '';
  String micStatus = '';
  String micError = '';
  bool _isSpeeking = false;
  stt.SpeechToText speech = stt.SpeechToText();

  //音声入力開始
  Future<void> _speak() async {
    //初期化の判定
    bool available = await speech.initialize(
      onStatus: (status) => micStatus = status,
      onError: (error) => micError = '${error.errorMsg} - ${error.permanent}',
    );
    if (available) {
      setState(() {
        _isSpeeking = true;
      });
      speech.listen(onResult: (result) {
        setState(() {
          _words = result.recognizedWords;
        });
        debugPrint(result.recognizedWords);
      });
    } else {
      print('The user has denied the use of speech recognition');
      debugPrint('error: $micError, status: $micStatus');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('変換文字:$_words',
                style: Theme.of(context).textTheme.headlineMedium)
          ],
        ),
      ),
      floatingActionButton: AvatarGlow(
        glowColor: Theme.of(context).primaryColor,
        animate: _isSpeeking,
        endRadius: 70,
        duration: const Duration(milliseconds: 500),
        child: GestureDetector(
          onTapDown: (details) async {
            await _speak();
            debugPrint('onTapDown, flas:${_isSpeeking.toString()}');
          },
          onTapUp: (details) {
            setState(() {
              _isSpeeking = false;
            });
            speech.stop();
            debugPrint('onTapUp, flas:${_isSpeeking.toString()}');
          },
          onTapCancel: () {
            setState(() {
              _isSpeeking = false;
            });
            debugPrint('onTapCancel, flag:${_isSpeeking.toString()}');
          },
          child: CircleAvatar(
            child: Icon(
              _isSpeeking ? Icons.mic : Icons.mic_none,
            ),
          ),
        ),
      ),
    );
  }
}
