import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/blocs/Capstone/Capstone_details.dart';
import 'package:flutter_login_demo/blocs/Capstone/index.dart';
import 'package:flutter_login_demo/models/capstone.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';

class CapstoneScreen extends StatefulWidget {
  const CapstoneScreen({
    Key key,
  }) : super(key: key);

  @override
  CapstoneScreenState createState() {
    return CapstoneScreenState();
  }
}

class CapstoneScreenState extends State<CapstoneScreen> {
  int page = 0;
  Completer<void> _refreshCompleter;
  GlobalKey<RefreshIndicatorState> _refreshKey;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  // final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _refreshKey = new GlobalKey<RefreshIndicatorState>();
    _load();
  }

  void _onTap(Capstone item) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => TestScreeb(),
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CapstonesDetails(
          capstoneId: item.id,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getItem(Capstone capstone) {
    return ListTile(
      title: Text(capstone.name ?? capstone.name ?? "DEfault name"),
      subtitle: Text(capstone.mentorName ?? "DEfault mentorname"),
      trailing: Text(dateFormat.format(dateFormat.parse(capstone.dateCreate))),
      onTap: () => _onTap(capstone),
    );
  }

  Future<void> _refreshCapstoneList() async {
    setState(() => page = 0);
    BlocProvider.of<CapstoneBloc>(context).add(CapstoneRefreshRequest());
    return _refreshCompleter.future;
  }

  Future<void> _loadMore() {
    BlocProvider.of<CapstoneBloc>(context)
        .add(CapstoneLoadMoreRequest(page + 1));
    setState(() {
      page += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CapstoneBloc, CapstoneState>(
      listener: (BuildContext context, CapstoneState state) {
        if (state is CapstoneLoadSuccess) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      builder: (
        BuildContext context,
        CapstoneState currentState,
      ) {
        if (currentState is CapstoneFailureState) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(currentState.errorMessage ?? 'Error'),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('reload'),
                  onPressed: _load,
                ),
              ),
            ],
          ));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Your enrolled capstones: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: myController,
                          decoration: const InputDecoration(
                            labelText: 'Search by Name',
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // print(myController.text);
                            BlocProvider.of<CapstoneBloc>(context).add(
                                CapstoneRequestFilter(name: myController.text));
                          }),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      "Loaded ${(currentState as CapstoneLoadSuccess)?.result?.length ?? '1'}"),
                ),
                Divider(),
                (currentState is CapstoneInitialState ||
                        currentState is CapstoneLoadInProgressState)
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        height: 500,
                        child: (currentState as CapstoneLoadSuccess)
                                    .result
                                    .length ==
                                0
                            ? Center(
                                child: Text("No capstone with that name"),
                              )
                            : RefreshIndicator(
                                key: _refreshKey,
                                onRefresh: _refreshCapstoneList,
                                child: LoadMore(
                                  textBuilder: (LoadMoreStatus status) {
                                    if (status == LoadMoreStatus.loading)
                                      return "Loading..";
                                    else
                                      return "You got the end";
                                  },
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return _getItem(
                                          (currentState as CapstoneLoadSuccess)
                                              .result[index]);
                                    },
                                    itemCount:
                                        (currentState as CapstoneLoadSuccess)
                                            .result
                                            .length,
                                  ),
                                  isFinish:
                                      (currentState as CapstoneLoadSuccess)
                                              .totalPage ==
                                          page,
                                  onLoadMore: () async {
                                    await Future.delayed(Duration(seconds: 2));
                                    _loadMore();
                                    return true;
                                  },
                                ),
                              ),
                      ),
              ],
            ),
          );
        }
      },
    );
  }

  void _load() {
    setState(() {
      page = 0;
    });
    BlocProvider.of<CapstoneBloc>(context).add(CapstoneRequest());
  }
}
