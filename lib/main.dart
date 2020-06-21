import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/blocs/Capstone/index.dart';
import 'package:flutter_login_demo/blocs/login/index.dart';
import 'package:flutter_login_demo/dataProvider/capstoneProvider.dart';
import 'package:flutter_login_demo/repositories/capstoneRepository.dart';
import 'package:flutter_login_demo/screens/index.dart';
import 'package:flutter_login_demo/utils/index.dart';
import 'blocs/authentication/index.dart';
import 'repositories/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();

  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: App(
          userRepository: userRepository,
        ),
      ),
    ),
  );
}

class App extends StatefulWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  final CapstoneRepository capstoneRepository = new CapstoneRepository(
    capstoneApiClient: new CapstoneApiClient(),
  );

  String msg;

  @override
  void initState() {
    super.initState();
    _saveDeviceToken();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessagea: $message");
        // final snackbar = SnackBar(
        //   content: Text("Receive message"),
        //   action: SnackBarAction(
        //     label: 'Go',
        //     onPressed: () => null,
        //   ),
        // );
        // print("After show");
        // Scaffold.of(context).showSnackBar(snackbar);
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  Widget _buildDialog(BuildContext context, String msg) {
    return AlertDialog(
      content: Text(msg),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    print('Showing Dialog');
    showDialog<bool>(
        context: context,
        builder: (context) =>
            _buildDialog(context, message['notification']['title']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is InAuthenticationState) {
            return SplashScreen();
          } else if (state is AuthenticatedState) {
            return CapstonePage(
              user: state.user,
              capstoneRepository: capstoneRepository,
            );
          } else if (state is UnAuthenticationState ||
              state is ErrorAuthenticationState) {
            return LoginScreen(
                userRepository: widget._userRepository, msg: msg);
          }
          return SplashScreen();
        },
      ),
    );
  }

  _saveDeviceToken() async {
    print('SaveToken');

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to local
    setFCMToken(fcmToken);
    if (fcmToken != null) {
      // var tokens = _db
      //     .collection('users')
      //     .document(uid)
      //     .collection('tokens')
      //     .document(fcmToken);

      // await tokens.setData({
      //   'token': fcmToken,
      //   'createdAt': FieldValue.serverTimestamp(), // optional
      //   'platform': Platform.operatingSystem // optional
      // });

    }
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
