import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:jellybean/core/auth/auth.providers.dart';
import 'package:jellybean/navigation/route_names.dart';
import 'package:jellybean/providers/jellyfin_auth.provider.dart';
import 'package:jellybean/services/jellyfin_auth.dart';
import 'package:jellybean/utils/setup.dart';

class AuthController {
  AuthController({this.ref});

  late final WidgetRef? ref;

  // text controllers
  late final TextEditingController addressBox;
  late final TextEditingController portBox;
  late final PageController pageController;

  // user login page
  late final TextEditingController userBox;
  late final TextEditingController passBox;

  // value listenable
  final loadingState = ValueNotifier(false);
  final infoText = ValueNotifier('');
  final success = ValueNotifier(false);
  final nextPageButton = ValueNotifier(true);

  void init() {
    pageController = PageController();

    addressBox = TextEditingController();
    portBox = TextEditingController();

    userBox = TextEditingController();
    passBox = TextEditingController();

    if (kDebugMode) {
      userBox.text = 'test';
      passBox.text = 'test';
    }

    // use future to delay until widget builds,
    // because provider cannot be modified in initstate
    Future(() {
      addressBox.text = ref!.read(addressProvider);
      portBox.text = ref!.read(portProvider);
      setTextListeners(ref!);
    });
  }

  void dispose() {
    // ref!.invalidate(hostListProvider);
    userBox.dispose();
    passBox.dispose();
    addressBox.dispose();
    portBox.dispose();
    loadingState.dispose();
    infoText.dispose();
  }

  Future<String?> checkAddress(String address) async {
    if (infoText.value.isNotEmpty) {
      // remove error message form previous attempt
      infoText.value = '';
    }

    // disable next button until check is complete
    nextPageButton.value = false;

    loadingState.value = true;
    final res = await testConnection(address);
    loadingState.value = false;

    nextPageButton.value = true;

    if (res != null) {
      infoText.value = res;
      return null;
    }

    infoText.value = 'Server Connected';
    return address;
  }

  Future<void> saveServerAndGotoNext(WidgetRef ref) async {
    final address = await checkAddress(ref.watch(urlPreviewProvider));
    if (address != null) {
      // update the client with the new base path
      // overrideDefaultClient(ApiClient(basePath: address));
      ref.read(hostListProvider.notifier).update((state) {
        state.add(address);
        return state;
      });
      await goToPage(1);
    }
  }

  Future<void> goToPage(int index) async {
    if (pageController.hasClients) {
      await pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> loginUser(
    String host,
    BuildContext ctx,
    WidgetRef ref,
  ) async {
    try {
      final accessToken = await loginToJellyFin(
        host,
        userBox.text,
        passBox.text,
        settings.deviceData,
      );

      if (accessToken == null) {
        logDebug('Login Failed: Access token is null');
        return;
      }

      // TODO get server nick name from user
      await saveServerAddressToSharedPrefs(
        host,
        accessToken,
        'hermes',
      );

      // refresh api provider
      ref.invalidate(apiClientProvider);
      if (!ctx.mounted) return;
      ctx.goNamed(homeRouteName);
      return;
    } catch (e) {
      logError('Login Failed', error: e);
    }
    return;
  }

  void setTextListeners(WidgetRef ref) {
    addressBox.addListener(
      () => ref.read(addressProvider.notifier).state = addressBox.text,
    );
    portBox.addListener(
      () => ref.read(portProvider.notifier).state = portBox.text,
    );
  }
}
