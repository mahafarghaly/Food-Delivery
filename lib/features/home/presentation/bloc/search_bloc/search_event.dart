import 'package:equatable/equatable.dart';

sealed class SearchEvent  extends Equatable{
  const SearchEvent();
  @override
  List<Object?> get props => [];
}
class SearchRestaurantsEvent extends SearchEvent {
  final String query;
  final String? selectedChip;

  const SearchRestaurantsEvent(this.query, {this.selectedChip});
}