import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class MenuData extends Equatable {
  const MenuData(this.icon, this.title, this.uri);
  final IconData icon;
  final String title;
  final String uri;

  @override
  List<Object?> get props => [icon, title, uri];
}
