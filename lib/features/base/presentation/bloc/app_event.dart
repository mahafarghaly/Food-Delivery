sealed class AppEvent {}

class ChangeBottomNavIndexEvent extends AppEvent {
  final int newIndex;

  ChangeBottomNavIndexEvent(this.newIndex);

}
class FetchLocationEvent extends AppEvent {}


