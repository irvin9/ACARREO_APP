import 'dart:io';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket_material_supplier.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/ticket_repository.dart';

class AcarreoTicketMaterialSupplierRepository
    extends BaseRepository<AcarreoTicketMaterialSupplier>
    implements TicketRepository<AcarreoTicketMaterialSupplier> {
  static const String _subPath = '/ticketmaterialsupplier/';
  AcarreoTicketMaterialSupplierRepository();

  @override
  createTicket(AcarreoTicketMaterialSupplier ticket) async {
    final String hostUrl = environment.apiHostUrl;
    final String apiVersion = environment.apiAuthVersion;
    String url = '$hostUrl$apiVersion';
    Map<String, dynamic> data = {};

    url = '$url$_subPath';
    data = ticket.toMap();

    final response = await http.request(
        url: url,
        token: TypeToken.bearerToken,
        httpMethod: HttpMethods.POST,
        data: data);
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }
    return AcarreoTicketMaterialSupplier.fromApiJson(response.body);
  }

  @override
  getTicketsByUser(String id) {
    throw UnimplementedError();
  }
}
