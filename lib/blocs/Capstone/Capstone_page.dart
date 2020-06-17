import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/blocs/Capstone/index.dart';
import 'package:flutter_login_demo/blocs/authentication/index.dart';
import 'package:flutter_login_demo/repositories/capstoneRepository.dart';

class CapstonePage extends StatefulWidget {
  static const String routeName = '/capstone';
  final CapstoneRepository capstoneRepository;
  final FirebaseUser user;

  const CapstonePage({Key key, this.capstoneRepository, this.user})
      : super(key: key);
  @override
  _CapstonePageState createState() => _CapstonePageState();
}

class _CapstonePageState extends State<CapstonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capstone list'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.network(
                      widget.user.photoUrl,
                      height: 100.0,
                      width: 100.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 150,
                      child: Text(
                        widget.user.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Icon(Icons.exit_to_app),
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
            )
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            CapstoneBloc(capstoneRepository: widget.capstoneRepository),
        child: CapstoneScreen(),
      ),
    );
  }
}
