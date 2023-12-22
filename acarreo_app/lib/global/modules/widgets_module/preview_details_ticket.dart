import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/domain/models/preview_ticket_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/concept_text_ticket.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class PreviewDetailsTicket extends StatelessWidget {
  const PreviewDetailsTicket({
    super.key,
    required this.ticketData,
  });

  final PreviewTicketModel ticketData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      child: Column(
        children: [
          ConceptTextTicket(
            conceptText: 'Desarrolladora:',
            valueText: ticketData.enterpriseName,
          ),
          ConceptTextTicket(
            conceptText: 'Proyecto:',
            valueText: ticketData.projectName,
          ),
          ConceptTextTicket(
            conceptText: 'Fecha:',
            valueText: ticketData.date,
          ),
          ConceptTextTicket(
            conceptText: 'Tipo de viaje:',
            valueText: (ticketData.typeLocation ==
                        FormValues.mappingTypeRegister['1'] ||
                    ticketData.typeLocation == '1')
                ? 'Origen'
                : 'Destino',
          ),
          ConceptTextTicket(
            conceptText: 'Ubicación:',
            valueText: ticketData.location,
          ),
          ConceptTextTicket(
            conceptText: 'Material:',
            valueText: ticketData.material,
          ),
          ConceptTextTicket(
            conceptText: 'Placas:',
            valueText: ticketData.plates,
          ),
          ConceptTextTicket(
            conceptText: 'M3:',
            valueText: '${ticketData.capacity} m3',
          ),
          ConceptTextTicket(
            show: ticketData.companyName != null,
            conceptText: 'Empresa de' '\n' 'explotación:',
            valueText: ticketData.companyName ?? '',
          ),
          ConceptTextTicket(
            show: ticketData.customerName != null,
            conceptText: 'Client:',
            valueText: ticketData.customerName ?? '',
          ),
          ConceptTextTicket(
            show: ticketData.barcodeExternal != null,
            conceptText: 'Ticket' '\n' 'Externo:',
            valueText: ticketData.barcodeExternal ?? '',
          ),
          ConceptTextTicket(
            conceptText: 'Nota:',
            valueText: ticketData.description,
          ),
          BarcodeWidget(
            padding: const EdgeInsets.all(10.0),
            barcode: Barcode.code128(),
            data: ticketData.barcode,
          )
        ],
      ).withPaddingSymmetric(vertical: 12.0, horizontal: 12.0),
    );
  }
}
