import 'dart:io';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/ticket_repository.dart';

class AcarreoTicketRepository extends BaseRepository<AcarreoTicket>
    implements TicketRepository<AcarreoTicket> {
  static const String _subCategoryPathOrigin = '/tickets';
  static const String _subCategoryPathDestination = '/ticketsrecepcion';

  AcarreoTicketRepository();

  @override
  Future<AcarreoTicket> createTicket(AcarreoTicket ticket) async {
    final String hostUrl = environment.apiHostUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPathOrigin';

    final response = await http.request(
        url: url, httpMethod: HttpMethods.POST, data: ticket.toApiJson());
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }
    final data = AcarreoTicket.fromRawJson(response.body);
    return data;
  }

  @override
  Future<List<AcarreoTicket>> getTicketsByUser(String id) async {
    throw UnimplementedError();
    //   final String hostUrl = environment.apiHostUrl;
    //   final String apiVersion = environment.apiAuthVersion;
    //   final String url = '$hostUrl$apiVersion$_subCategoryPath';

    //   final Map<String, String> params = {
    //     'id_tracker': id,
    //   };
    //   final response = await http.request(
    //       url: url, httpMethod: HttpMethods.GET, params: params);
    //   if (response.statusCode != HttpStatus.ok) {
    //     throw ApiRestException.fromResponse(response);
    //   }

    //   final body = ApiRestPaginated<AcarreoTicket>.fromJson(
    //       response.body, AcarreoTicket.fromJson);
    //   return body.data;
    // }
  }
}
