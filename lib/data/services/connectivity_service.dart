import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectionStatus {
  online,
  offline,
}

class ConnectivityService {
  ConnectivityService() {
    _init();
  }
  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectionStatus> _connectionController =
      StreamController<ConnectionStatus>.broadcast();

  Stream<ConnectionStatus> get connectionStream => _connectionController.stream;

  ConnectionStatus _currentStatus = ConnectionStatus.offline;
  ConnectionStatus get currentStatus => _currentStatus;

  bool get isOnline => _currentStatus == ConnectionStatus.online;
  bool get isOffline => _currentStatus == ConnectionStatus.offline;

  void _init() {
    // Check initial connectivity
    _connectivity
        .checkConnectivity()
        .then((results) => _updateConnectionStatus(results));

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged
        .listen((results) => _updateConnectionStatus(results));
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final hasConnection = results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);

    final newStatus =
        hasConnection ? ConnectionStatus.online : ConnectionStatus.offline;

    if (newStatus != _currentStatus) {
      _currentStatus = newStatus;
      _connectionController.add(_currentStatus);
    }
  }

  Future<bool> hasInternetConnection() async {
    final connectivityResults = await _connectivity.checkConnectivity();
    return connectivityResults.isNotEmpty &&
        connectivityResults.any((result) => result != ConnectivityResult.none);
  }

  void dispose() {
    _connectionController.close();
  }
}

// Riverpod providers
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(service.dispose);
  return service;
});

final connectionStatusProvider = StreamProvider<ConnectionStatus>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.connectionStream;
});

final isOnlineProvider = Provider<bool>((ref) {
  final connectionStatus = ref.watch(connectionStatusProvider);
  return connectionStatus.when(
    data: (status) => status == ConnectionStatus.online,
    loading: () => false,
    error: (_, __) => false,
  );
});
