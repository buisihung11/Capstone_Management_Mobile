import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/blocs/Capstone/Capstone_details.dart';
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

  void _navigateToPhaseScore(Map<String, dynamic> message) {
    var data = message['data'] ?? message;
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CapstonesDetails(
          capstoneId: int.parse(data['capstoneId'].toString()),
          currentPhase: int.parse(data['phaseId'].toString()),
        ),
      ),
    );
  }

  Future<void> _handleNotification(Map<dynamic, dynamic> message) async {
    var data = message['data'] ?? message;
    print(data.toString());
  }

  @override
  void initState() {
    super.initState();
    _saveDeviceToken();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessagea: $message");
        _showItemDialog(message);
        _handleNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToPhaseScore(message);
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToPhaseScore(message);
        // TODO optional
      },
    );
  }

  Widget _buildDialog(BuildContext context, String msg) {
    return AlertDialog(
      content: Text(
        "Do you want to navigate to that?",
        style: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      title: Text(msg),
      actions: <Widget>[
        FlatButton(
          child: const Text(
            'No',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) async {
    print('Showing Dialog');
    bool isConfirmToNavigate = await showDialog<bool>(
        context: context,
        builder: (context) =>
            _buildDialog(context, message['notification']['title']));
    if (isConfirmToNavigate) _navigateToPhaseScore(message);
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
    // Get the token for this device
    String fcmToken = await _fcm.getToken();
    print("FCMTOKEN: $fcmToken");
    // Save it to local
    if (fcmToken != null) {
      setFCMToken(fcmToken);
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
