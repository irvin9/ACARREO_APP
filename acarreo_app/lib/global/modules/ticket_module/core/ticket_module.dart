import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/ticket_module/core/domain/cubit/list_tickets/list_tickets_cubit.dart';
import 'package:acarreo_app/global/modules/ticket_module/core/routes/module_routes.dart';
import 'package:acarreo_app/global/modules/ticket_module/core/ui/screens/list_tickets_screen.dart';
import 'package:acarreo_app/global/modules/ticket_module/core/ui/screens/review_ticket_travel_screen.dart';

class TicketsModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton(
          (i) => ListTicketsCubit(i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          TicketRoutesModule.listTicketRoute,
          child: (context, args) => MultiBlocProvider(providers: [
            BlocProvider.value(value: Modular.get<AcarreoCubit>()),
            BlocProvider.value(
                value: Modular.get<ListTicketsCubit>()..getTickets()),
          ], child: const ListTicketsScreen()),
        ),
        ChildRoute(
          TicketRoutesModule.reviewTicketRoute,
          child: (context, args) => MultiBlocProvider(providers: [
            BlocProvider.value(value: Modular.get<AcarreoCubit>()),
          ], child: const ReviewTicketTravelScreen()),
        ),
      ];
}
