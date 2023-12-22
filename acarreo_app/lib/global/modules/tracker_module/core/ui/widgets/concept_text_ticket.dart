import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/widgets.dart';

class ConceptTextTicket extends StatelessWidget {
  final String conceptText;
  final String valueText;
  final bool show;

  const ConceptTextTicket({
    super.key,
    required this.conceptText,
    required this.valueText,
    this.show = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            conceptText,
            overflow: TextOverflow.fade,
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              valueText,
              overflow: TextOverflow.fade,
              style: GoogleFonts.poppins(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    ).withPaddingSymmetric(vertical: 7.0, horizontal: 7.0);
  }
}
