import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/blocs/Capstone/Capstone_details.dart';
import 'package:flutter_login_demo/blocs/Capstone/index.dart';
import 'package:flutter_login_demo/models/capstone.dart';
import 'package:intl/intl.dart';

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
  Completer<void> _refreshCompleter;
  GlobalKey<RefreshIndicatorState> _refreshKey;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _refreshKey = new GlobalKey<RefreshIndicatorState>();
    _load();
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CapstonesDetails(),
          ),
        );
      },
    );
  }

  Future<void> _refreshCapstoneList() async {
    BlocProvider.of<CapstoneBloc>(context).add(CapstoneRefreshRequest());
    return _refreshCompleter.future;
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
        if (currentState is CapstoneInitialState ||
            currentState is CapstoneLoadInProgressState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
        }
        if (currentState is CapstoneLoadSuccess) {
          print(currentState);
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Your enrolled capstones: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: _refreshCapstoneList,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _getItem(currentState.result[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 16);
                      },
                      itemCount: currentState.result.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _load() {
    BlocProvider.of<CapstoneBloc>(context).add(CapstoneRequest());
  }
}
