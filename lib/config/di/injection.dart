import 'package:get_it/get_it.dart';
import '../../services/location_service.dart';
import '../../services/notification_service.dart';
import '../../services/storage_service.dart';
import '../../services/bluetooth_service.dart';

/// SheShield – Dependency Injection
///
/// GetIt service locator setup for clean dependency management.
final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // ──────────────────────────────────────────────
  // Services (Singletons)
  // ──────────────────────────────────────────────
  
  // Storage Service (Hive)
  final storageService = StorageService();
  await storageService.init();
  getIt.registerSingleton<StorageService>(storageService);

  // Location Service
  getIt.registerLazySingleton<LocationService>(() => LocationService());

  // Bluetooth Service
  getIt.registerLazySingleton<BluetoothService>(() => BluetoothService());

  // Notification Service
  final notificationService = NotificationService();
  await notificationService.init();
  getIt.registerSingleton<NotificationService>(notificationService);
}
