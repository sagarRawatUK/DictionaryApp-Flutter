import 'dart:ui';

import 'package:dictionaryapp/backend/cubit/dictionary_cubit.dart';
import 'package:dictionaryapp/backend/service/cloud_message.dart';
import 'package:dictionaryapp/components/colors.dart';
import 'package:dictionaryapp/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  // TextEditingController _textEditingController = TextEditingController();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var meaning, definition;
  FirebaseMessage firebaseMessage = FirebaseMessage();

  @override
  void initState() {
    firebaseMessage.initMessaging();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = context.watch<DictionaryCubit>();
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(125),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Dictionary",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      TextSpan(
                        text: "App",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[800]),
                  child: TextFormField(
                      controller: BlocProvider.of<DictionaryCubit>(context)
                          .queryController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search a word",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 15, color: Colors.grey[300]))),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.replay,
                color: Colors.red,
                size: 20,
              )),
          IconButton(
              onPressed: () => Navigator.pushNamed(context, PageRoutes.map),
              icon: Icon(
                Icons.language,
                size: 20,
                color: primaryColor,
              ))
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BlocBuilder<DictionaryCubit, DictionaryState>(
              builder: (context, state) {
                if (state is DictionaryNoInternetState)
                  return Center(
                    child: Text(
                      "No Internet Connection",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  );
                else if (state is DictionarySearchingState)
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                else if (state is ErrorState)
                  return Center(
                    child: Text("An error occured"),
                  );
                else if (state is DictionaryInitialState)
                  return SizedBox.shrink();
                else if (state is DictionarySearchResultState) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 70),
                    // height: MediaQuery.of(context).size.height - 295,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(5)),
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.words.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (state.words[index].meanings![0].definitions!
                            .isNotEmpty) {
                          meaning = state.words[index].meanings![0];
                          definition = meaning.definitions;
                        }
                        return ListTile(
                            title: Text(state.words[index].word!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meaning.partOfSpeech!,
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                state.words[index].meanings![0].definitions!
                                        .isNotEmpty
                                    ? ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            Text(
                                              "Definition : " +
                                                  definition![index]
                                                      .definition!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "Sentence  : ${definition[index].example}",
                                              style: TextStyle(
                                                  color: primaryColor),
                                            ),
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 8,
                                        ),
                                        itemCount: definition!.length,
                                        shrinkWrap: true,
                                      )
                                    : SizedBox.shrink()
                              ],
                            ));
                      },
                    ),
                  );
                }
                return Expanded(
                    child: Center(child: Text("Nothing Searched yet")));
              },
            ),
            GestureDetector(
              onTap: () {
                if (BlocProvider.of<DictionaryCubit>(context)
                    .queryController
                    .text
                    .isNotEmpty)
                  BlocProvider.of<DictionaryCubit>(context).getWordSearched();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor),
                child: Center(
                  child: Text(
                    "Search",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
