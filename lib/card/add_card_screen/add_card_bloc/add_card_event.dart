part of 'add_card_bloc.dart';

@immutable
abstract class AddCardEvent {}
class ImageAddEvent extends AddCardEvent{
  final CardModel cardModel;
  ImageAddEvent({required this.cardModel});
}
class AddCardFirstEvent extends AddCardEvent{
  final CardModel cardModel;
  AddCardFirstEvent({required this.cardModel});
}
class AddDataSqlEvent extends AddCardEvent{
  final CardModel cardModel;
  AddDataSqlEvent({required this.cardModel});
}