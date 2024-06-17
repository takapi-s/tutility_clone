import 'package:flutter/material.dart';
import 'Scraping.dart';
//homeの画面上部のデザイン

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
          child: CapsuleButton(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ScrapingScreen())
              );
            },
            icon: const Icon(Icons.download),
          ),
        )
      ],
    );
  }
}

class CapsuleButton extends StatefulWidget {
  const CapsuleButton({super.key});

  @override
  _CapsuleButtonState createState() => _CapsuleButtonState();
}

class _CapsuleButtonState extends State<CapsuleButton> {
  //データ保存する必要がある
  bool isOn = true;

  void toggleButton(bool v) {
    if (v == false) {
      setState(() {
        isOn = !isOn;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            toggleButton(isOn);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: isOn ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                bottomLeft: Radius.circular(24.0),
              ),
            ),
            child: const Text(
              '前期1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            toggleButton(!isOn);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            decoration: BoxDecoration(
              color: !isOn ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
            ),
            child: const Text(
              '前期2',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
