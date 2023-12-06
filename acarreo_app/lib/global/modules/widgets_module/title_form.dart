import 'package:flutter/material.dart';

class TitleForm extends StatelessWidget {
  final String title;
  final String? description;
  final double titleTextSize;
  final Color? tittleColor;
  final double descriptionTextSize;
  final Color? descriptionColor;
  final TextAlign align;
  final double spacing;

  const TitleForm({
    super.key,
    this.title = 'Título de Formulario',
    this.description,
    this.titleTextSize = 32.0,
    this.tittleColor = const Color(0xFF242630),
    this.descriptionTextSize = 16,
    this.descriptionColor = const Color(0xFF575E6E),
    this.align = TextAlign.center,
    this.spacing = 16.0,
  });

  factory TitleForm.h2({
    title = 'Título de Formulario h2',
    description = 'Descripcion',
  }) =>
      TitleForm(
        title: title,
        description: description,
        titleTextSize: 18.0,
        descriptionTextSize: 12.0,
        align: TextAlign.start,
        spacing: 0.0,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            textAlign: align,
            style: TextStyle(
              color: tittleColor,
              fontSize: titleTextSize,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: spacing),
        Visibility(
          visible: description != null,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              description ?? '',
              textAlign: align,
              style: TextStyle(
                color: descriptionColor,
                fontSize: descriptionTextSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                // height: 0.09,
              ),
            ),
          ),
        )
      ],
    );
  }
}
