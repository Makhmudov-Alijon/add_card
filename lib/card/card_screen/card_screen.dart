import 'package:add_card/card/add_card_screen/add_card_screen.dart';
import 'package:add_card/card/card_screen/bloc/card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPage extends StatefulWidget {
  static Widget screen() =>
      BlocProvider(create: (context) => CardBloc(), child: CardPage());

  CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late CardBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CardBloc>(context);

    bloc.add(CardGetEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<CardBloc, CardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is CardGetState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.cardModel.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(state.cardModel[index].image),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                              child: Text(
                                state.cardModel[index].cardNumber,
                                style: TextStyle(color: Colors.white, fontSize: 28),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                              child: Text(
                                state.cardModel[index].expiresDate,
                                style: TextStyle(color: Colors.white, fontSize: 28),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                              child: Text(
                                state.cardModel[index].name,
                                style: TextStyle(color: Colors.white, fontSize: 28),
                              ),
                            ),

                          ],
                        ));
                  }),
            );
          }
          return ListView(
            children: [],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCardPage.screen()))
              .then((value) {
            bloc.add(CardGetEvent());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
