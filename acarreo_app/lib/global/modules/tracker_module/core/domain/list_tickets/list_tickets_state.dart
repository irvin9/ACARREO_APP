part of 'list_tickets_cubit.dart';

abstract class ListTicketsState extends Equatable {
  const ListTicketsState();
}

class InitListTicket extends ListTicketsState {
  const InitListTicket();
  @override
  List<Object?> get props => [];
}

class LoadTickets extends ListTicketsState {
  const LoadTickets();

  @override
  List<Object?> get props => [];
}

class LoadTicketsSuccess extends ListTicketsState {
  final List<AcarreoTicket> tickets;

  const LoadTicketsSuccess(this.tickets);

  @override
  List<Object?> get props => [tickets];
}

class LoadTicketsError extends ListTicketsState {
  final String? message;

  const LoadTicketsError({this.message});

  @override
  List<Object?> get props => [message];
}

class ShowModalTicketPrint extends ListTicketsState {
  const ShowModalTicketPrint();
  @override
  List<Object?> get props => [];
}
