import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellydart/jellydart.dart';

class PublicUsersList extends StatelessWidget {
  const PublicUsersList({required this.users, super.key});

  final AsyncValue<List<UserDto>?> users;

  @override
  Widget build(BuildContext context) {
    return switch (users) {
      AsyncData(:final value) => (value != null || value!.isNotEmpty)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: value.map((e) => PublicUserDisplay(user: e)).toList(),
            )
          : Container(), // show users list only if public users are available
      AsyncError(:final error) => Text('Error: $error'),
      _ => const CircularProgressIndicator(),
    };
  }
}

class PublicUserDisplay extends StatelessWidget {
  const PublicUserDisplay({
    required this.user,
    super.key,
  });

  final UserDto user;

  @override
  Widget build(BuildContext context) {
    return Text(user.name ?? 'No username');
  }
}
