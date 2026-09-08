import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../config/di/injection.dart';
import '../../services/location_service.dart';

/// SheShield – Location Provider
///
/// Manages location state and address resolution.
final locationProvider =
    StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<LocationState> {
  final LocationService _locationService = getIt<LocationService>();

  LocationNotifier() : super(const LocationState());

  /// Fetch current location and resolve address
  Future<void> fetchCurrentLocation() async {
    state = state.copyWith(isLoading: true);

    final position = await _locationService.getCurrentPosition();
    if (position != null) {
      final address = await _locationService.getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );
      state = state.copyWith(
        position: position,
        address: address,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        address: 'Location Unavailable',
      );
    }
  }
}

class LocationState {
  final Position? position;
  final String address;
  final bool isLoading;

  const LocationState({
    this.position,
    this.address = 'Fetching location...',
    this.isLoading = false,
  });

  LocationState copyWith({
    Position? position,
    String? address,
    bool? isLoading,
  }) {
    return LocationState(
      position: position ?? this.position,
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
