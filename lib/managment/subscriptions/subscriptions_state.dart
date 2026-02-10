part of 'subscriptions_cubit.dart';

@immutable
class SubscriptionsState {
  final bool loading;
  final String? error;
  final List<Subscribe>? subscribe;
  final bool loadingSubscribe;

  const SubscriptionsState({
    this.loading = true,
    this.error,
    this.subscribe,
    this.loadingSubscribe = false,
  });

  SubscriptionsState copyWith({
    bool? loading,
    String? error,
    List<Subscribe>? subscribe,
    bool? loadingSubscribe,
  }) {
    return SubscriptionsState(
      error: error,
      loading: loading ?? this.loading,
      subscribe: subscribe ?? this.subscribe,
      loadingSubscribe: loadingSubscribe ?? this.loadingSubscribe,
    );
  }
}
