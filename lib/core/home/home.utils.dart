import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [dataFunc] - widget builder for data state
///
///
/// [errorFunc] - If not provided Defaults: (error, stack) => const Text('Oops, something unexpected happened')
///
///
/// [loadingFunc] - If not provided Defaults: CircularProgressIndicator.new
Widget handleAsyncValue<T>(
  AsyncValue<T> item,
  Widget Function(T) dataFunc, {
  Widget Function(Object, StackTrace)? errorFunc,
  Widget Function()? loadingFunc,
}) {
  return item.when(
    loading: loadingFunc ?? CircularProgressIndicator.new,
    error: errorFunc ??
        (error, stack) => const Text('Oops, something unexpected happened'),
    data: dataFunc,
  );
}
