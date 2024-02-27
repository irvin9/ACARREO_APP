part of 'home_cubit.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadData extends HomeState {
  HomeLoadData();

  @override
  List<Object?> get props => [];
}

class HomeDataSuccess extends HomeState {
  final List<MenuData> menu;

  HomeDataSuccess({required this.menu});

  @override
  List<Object?> get props => [menu];
}
