import 'package:flutter/material.dart';

class TitleForm extends StatelessWidget {
  final String title;
  final String description;
  final double titleTextSize;
  final double descriptionTextSize;
  final TextAlign align;
  final double spacing;

  const TitleForm({
    super.key,
    this.title = 'Título de Formulario',
    this.description = 'Descripcion',
    this.titleTextSize = 32.0,
    this.descriptionTextSize = 16,
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
              color: const Color(0xFF242630),
              fontSize: titleTextSize,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: spacing),
        SizedBox(
          width: double.infinity,
          child: Text(
            description,
            textAlign: align,
            style: TextStyle(
              color: const Color(0xFF575E6E),
              fontSize: descriptionTextSize,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              // height: 0.09,
            ),
          ),
        ),
      ],
    );
  }
}
