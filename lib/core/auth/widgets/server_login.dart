import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:jellybean/core/auth/auth.controller.dart';
import 'package:jellybean/core/auth/auth.providers.dart';
import 'package:jellybean/services/web_service.dart';
import 'package:jellybean/utils/app.constants.dart';

class ServerPage extends ConsumerWidget {
  const ServerPage({required this.controller, super.key});

  final AuthController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final addressPreview = ref.watch(urlPreviewProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Welcome to Jellybean, yet another Jellyfin client',
          style: TextStyle(fontSize: 30),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        if (hasValidCertificate)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning),
              const SizedBox(width: 10),
              const Text(
                'https:// Jellyfin server URL only.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => launchUrl(Uri.parse(httpsModeUrl)),
                child: const Text('More info'),
              ),
            ],
          ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        SizedBox(
          width: 460,
          child: AddressInput(
            addressBox: controller.addressBox,
            portBox: controller.portBox,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
        const AddressPreview(),
        const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
        ValueListenableBuilder(
          valueListenable: controller.loadingState,
          builder: (context, isLoading, child) => ElevatedButton(
            onPressed: () => controller.checkAddress(addressPreview),
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Test'),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        ValueListenableBuilder(
          valueListenable: controller.nextPageButton,
          builder: (context, allowed, child) => ElevatedButton(
            onPressed:
                allowed ? () => controller.saveServerAndGotoNext(ref) : null,
            child: const Text('Next'),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        ValueListenableBuilder(
          valueListenable: controller.infoText,
          builder: (context, value, child) =>
              value.isNotEmpty ? ErrorWidget(text: value) : Container(),
        ),
      ],
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class AddressInput extends ConsumerWidget {
  const AddressInput({
    required this.addressBox,
    required this.portBox,
    super.key,
  });

  final TextEditingController addressBox;
  final TextEditingController portBox;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final protocol = ref.watch(protocolProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: protocol,
          onChanged: (String? newValue) =>
              ref.read(protocolProvider.notifier).state = newValue!,
          items: protocolList
              .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
        Expanded(
          flex: 3,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Server Address',
              hintText: '127.0.0.1 or jellyserver.com',
            ),
            controller: addressBox,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Port',
              hintText: '8096',
            ),
            controller: portBox,
          ),
        ),
      ],
    );
  }
}

class AddressPreview extends ConsumerWidget {
  const AddressPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressPreview = ref.watch(urlPreviewProvider);
    return addressPreview.isNotEmpty
        ? Text(
            'URL Preview: $addressPreview',
            style: const TextStyle(fontSize: 16),
          )
        : Container();
  }
}
