import 'package:flutter/material.dart';

const routeHome = '/';
const routeSettings = '/settings';
const routeFriendMatch = '/match';
const routeFriendMatchPage = 'match_friend';
const routeFriendSelectPage = 'select_friend';
const routeFriendConnectingPage = 'connecting';
const routeFriendFinishedPage = 'finished';

void main() {
  runApp(
    MaterialApp(
      onGenerateRoute: (settings) {
        late Widget page;
        print('settings.name1:${settings.name}');
        if (settings.name == routeHome) {
          page = const HomePage();
        } else if (settings.name == routeSettings) {
          page = const SettingsPage();
        } else if (settings.name == routeFriendMatch) {
          page = const FriendMatchFlow(
            setupPageRoute: routeFriendMatchPage,
          );
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: settings,
        );
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

@immutable
class FriendMatchFlow extends StatefulWidget {
  const FriendMatchFlow({
    super.key,
    required this.setupPageRoute,
  });

  final String setupPageRoute;

  @override
  FriendMatchFlowState createState() => FriendMatchFlowState();
}

class FriendMatchFlowState extends State<FriendMatchFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  void _onDiscoveryComplete() {
    _navigatorKey.currentState!.pushNamed(routeFriendSelectPage);
  }

  void _onFriendSelected(String deviceId) {
    _navigatorKey.currentState!.pushNamed(routeFriendConnectingPage);
  }

  void _onConnectionEstablished() {
    _navigatorKey.currentState!.pushNamed(routeFriendFinishedPage);
  }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('确定要退出吗?'),
            content: const Text(
                '如果现在退出，那么匹配过程将会被终止。'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('是'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('否'),
              ),
            ],
          );
        }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: Scaffold(
        appBar: _buildFlowAppBar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.setupPageRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    print('settings.name2:${settings.name}');
    switch (settings.name) {
      case routeFriendMatchPage:
        page = WaitingPage(
          message: '匹配附近的好友...',
          onWaitComplete: _onDiscoveryComplete,
        );
        break;
      case routeFriendSelectPage:
        page = SelectFriendPage(
          onFriendSelected: _onFriendSelected,
        );
        break;
      case routeFriendConnectingPage:
        page = WaitingPage(
          message: '匹配中...',
          onWaitComplete: _onConnectionEstablished,
        );
        break;
      case routeFriendFinishedPage:
        page = FinishedPage(
          onFinishPressed: _exitSetup,
        );
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _onExitPressed,
        icon: const Icon(Icons.chevron_left),
      ),
      title: const Text('匹配好友'),
    );
  }
}

class SelectFriendPage extends StatelessWidget {
  const SelectFriendPage({
    super.key,
    required this.onFriendSelected,
  });

  final void Function(String deviceId) onFriendSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '选择一个好友:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    onFriendSelected('张学友');
                  },
                  child: const Text(
                    '好友:张学友',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaitingPage extends StatefulWidget {
  const WaitingPage({
    super.key,
    required this.message,
    required this.onWaitComplete,
  });

  final String message;
  final VoidCallback onWaitComplete;

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    _startWaiting();
  }

  Future<void> _startWaiting() async {
    await Future<dynamic>.delayed(const Duration(seconds: 2));

    if (mounted) {
      widget.onWaitComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 32),
              Text(widget.message),
            ],
          ),
        ),
      ),
    );
  }
}

class FinishedPage extends StatelessWidget {
  const FinishedPage({
    super.key,
    required this.onFinishPressed,
  });

  final VoidCallback onFinishPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 250,
                height: 250,
                child: Center(
                  child: Icon(
                    Icons.done,
                    size: 175,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                '添加完毕!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onFinishPressed,
                child: const Text(
                  '完成',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 250,
                height: 250,
                child: Center(
                  child: Icon(
                    Icons.home,
                    size: 175,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                '跳转到好友匹配页面',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(routeFriendMatch);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('这是首页'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, routeSettings);
          },
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(8, (index) {
            return  ListTile(
              title: Text('设置项$index'),
            );
          }),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('设置'),
    );
  }
}