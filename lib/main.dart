import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/authentication/authentication_bloc.dart';
import 'package:flutter_login_demo/authentication/authentication_event.dart';
import 'package:flutter_login_demo/login/index.dart';
import 'package:flutter_login_demo/screens/index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication/authentication_state.dart';
import 'repositories/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();

  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: App(
        userRepository: userRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is InAuthenticationState) {
            return SplashScreen();
          }
          if (state is AuthenticatedState) {
            return HomeScreen(name: state.displayName);
          }
          if (state is UnAuthenticationState) {
            return LoginScreen(userRepository: _userRepository);
          }
        },
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  GoogleSignIn _googleSignIn = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        body: Container(
            color: Colors.orange[300],
            child: Center(
              child: _isLoggedIn
                  ? Stack(
                      children: <Widget>[
                        Scaffold(
                          // backgroundColor: Colors.red[100],
                          appBar: AppBar(
                            title: Text("FPT Capstone Management"),
                          ),
                          drawer: Drawer(
                            child: ListView(
                              children: <Widget>[
                                DrawerHeader(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Image.network(
                                          _googleSignIn.currentUser.photoUrl,
                                          height: 100.0,
                                          width: 100.0,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          _googleSignIn.currentUser.displayName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Text("Logout"),
                                  onTap: () {
                                    gooleSignout();
                                  },
                                )
                              ],
                            ),
                          ),
                          body: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Capstone 1"),
                                  subtitle: Text("Thanh Tam"),
                                  trailing: Text("Available"),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(height: 16);
                              },
                              itemCount: 2),
                        ),
                      ],
                    )
                  : Stack(
                      children: <Widget>[
                        Image.asset('assets/FPT.png'),
                        Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SignInButton(
                                  Buttons.Google,
                                  onPressed: () {
                                    handleSignIn();
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
            )),
      ),
    );
  }

  bool _isLoggedIn = false;

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    setState(() {
      _isLoggedIn = true;
    });
  }

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        _isLoggedIn = false;
      });
    });
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
