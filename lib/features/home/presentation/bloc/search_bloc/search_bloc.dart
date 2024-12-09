import 'package:bloc/bloc.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_event.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc():super( const SearchState()){}


}