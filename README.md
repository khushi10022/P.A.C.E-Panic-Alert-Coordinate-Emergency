# P.A.C.E. (Panic Alert & Coordinate Emergency)

**AI-Enabled Smart Women's Safety Wearable System**

A comprehensive safety ecosystem combining an ESP32-based smart wearable band (with MPU6050 fall/distress detection, NEO-6M GPS module, and manual SOS trigger) with a Flutter mobile application, backed by Firebase cloud services and local Hive offline storage.

## Features & Architecture

- **Wearable Band**: ESP32 microcontroller with MPU6050 motion sensing for automatic fall detection & manual SOS button interrupt.
- **BLE Transmission**: Low-latency Bluetooth Low Energy (BLE) communication with emergency packet retry/ack mechanism.
- **Companion App**: Built in Flutter with Riverpod state management, Geolocator & Google Maps integration for live guardian location tracking.
- **Cloud Infrastructure**: Firebase Auth, Firestore real-time storage, and Firebase Cloud Messaging (FCM) to instantly alert pre-registered emergency contacts.

