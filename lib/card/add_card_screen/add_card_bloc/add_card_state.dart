part of 'add_card_bloc.dart';

@immutable
abstract class AddCardState {}

class AddCardInitial extends AddCardState {}
class AddCardMainState extends AddCardState{
 final CardModel cardModel;
 AddCardMainState({required this.cardModel});
}
class BackPageState extends AddCardState{}