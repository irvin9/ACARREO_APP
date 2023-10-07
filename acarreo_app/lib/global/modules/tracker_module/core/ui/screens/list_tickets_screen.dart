import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/list_tickets/list_tickets_cubit.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTicketsScreen extends StatelessWidget {
  static final _listTicketsCubit = Modular.get<ListTicketsCubit>();
  const ListTicketsScreen({super.key});

  _buildLoadView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Cargando listado de tickets',
          textAlign: TextAlign.center,
          style:
              GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.w700),
        ),
        Container(
          padding: const EdgeInsets.all(12.0),
          child: const Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: FittedBox(
                child: CircularProgressIndicator(
                  color: Color(0xFF384596),
                  strokeWidth: 5,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildListView(List<AcarreoTicket> tickets) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider();
      },
      shrinkWrap: true,
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          leading: const Icon(Icons.article_outlined,
              size: 24, color: Colors.black87),
          title: Text(
            tickets[index].folioTicket,
            style: GoogleFonts.poppins(
                fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            DateFormat('dd/MM/yy hh:mm a').format((tickets[index].date)),
            style: GoogleFonts.poppins(
              fontSize: 12.0,
            ),
          ),
          trailing: const Icon(Icons.remove_red_eye_outlined,
              size: 24, color: Colors.black87),
        );
      },
    );
  }

  _buildEmptyListView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          child: const Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: FittedBox(
                child: Icon(Icons.article_outlined,
                    size: 24, color: Colors.black87),
              ),
            ),
          ),
        ),
        Text(
          '¡No tiene Tickets pendientes!',
          textAlign: TextAlign.center,
          style:
              GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.w500),
        ).withPaddingSymmetric(horizontal: 0.0, vertical: 24.0),
        GeneralButton(
          buttonText: 'Refrescar',
          buttonElevation: 1.0,
          textColor: const Color(0xFF384596),
          onPressed: () => _listTicketsCubit.getTickets(),
        ),
      ],
    );
  }

  _buildLoadErrorView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          child: const Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: FittedBox(
                child: Icon(
                  Icons.error_outline,
                  size: 24,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Text(
          '¡Ha ocurrido un error al intentar cargar los tickets!',
          textAlign: TextAlign.center,
          style:
              GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.w500),
        ).withPaddingSymmetric(horizontal: 0.0, vertical: 24.0),
        GeneralButton(
          buttonText: 'Refrescar',
          buttonElevation: 1.0,
          textColor: const Color(0xFF384596),
          onPressed: () => _listTicketsCubit.getTickets(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _listTicketsCubit.getTickets();
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      padding:
          const EdgeInsets.only(top: 24.0, bottom: 12.0, right: 24, left: 24.0),
      child: BlocBuilder<ListTicketsCubit, ListTicketsState>(
        builder: (context, state) {
          if (state is LoadTicketsSuccess) {
            if (state.tickets.isNotEmpty) {
              return _buildListView(state.tickets);
            }
            return _buildEmptyListView();
          }

          if (state is LoadTicketsError) {
            _buildLoadErrorView();
          }

          return _buildLoadView();
        },
      ),
    ).setScaffoldWithAppBar();
  }
}
