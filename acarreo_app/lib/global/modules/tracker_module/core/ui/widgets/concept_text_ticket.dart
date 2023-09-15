import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/widgets.dart';

class ConceptTextTicket extends StatelessWidget {
  final String conceptText;
  final String valueText;

  const ConceptTextTicket({
    super.key,
    required this.conceptText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            conceptText,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            valueText,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    ).withPaddingSymmetric(vertical: 7.0, horizontal: 7.0);
  }
}
