import 'dart:async';

import 'package:add_card/card/add_card_screen/add_card_screen.dart';
import 'package:add_card/data_base/data_base.dart';
import 'package:add_card/data_base/locator.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<CardModel> cardModel;
  CardBloc() : super(CardInitial()) {
    on<CardEvent>((event, emit) async{
      if(event is CardGetEvent){
        await getCard(event, emit);
      }
    });
  }
  Future<void> getCard(CardGetEvent event,Emitter<CardState> emit) async{
    cardModel=await databaseHelper.getBasketProducts();
    emit(CardGetState(cardModel: cardModel));
  }
}
