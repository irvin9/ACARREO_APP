import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/widgets.dart';

class ReadNFC extends StatelessWidget {
  const ReadNFC({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(0.0),
            height: 200,
            width: 200,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(WidgetAssets.nfcReader),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: const Text(
            'Por favor de acercar el dispositivo al NFC.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF575E6E),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              // height: 0.09,
            ),
          ).withPaddingSymmetric(horizontal: 40.0),
        ),
      ],
    );
  }
}
