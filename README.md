# QR Form App (Prototype)

This is a Flutter-based prototype that demonstrates how QR code generation and scanning can be used to digitize workflows in inventory management and store accounting. It provides an offline-first approach using local data storage with SQLite, making it suitable for environments with limited internet access.

## Overview

The application enables users to:
- Enter form data (Name, Role, Company)
- Generate a QR code from the entered data
- Scan QR codes from other devices to retrieve and display stored information
- Store data locally using SQLite

This prototype serves as a foundation for building a production-grade mobile solution to improve traceability, efficiency, and data integrity in operational processes.

## Key Use Cases

Inventory Management:
- Tag inventory items with QR codes
- Quickly scan and retrieve item details during stock audits
- Reduce manual logging and paperwork

Store Accounting:
- Record goods issuance and receipt with QR-tagged entries
- Simplify item verification at checkpoints
- Maintain a digital log of transactions

## Technologies Used

- Flutter – Cross-platform mobile development
- SQLite – Local data storage
- qr_flutter – QR code generation
- flutter_barcode_scanner – QR scanning

## Getting Started

### Prerequisites

- Flutter SDK (version 3.22 or compatible)
- Android Studio or VS Code with Flutter and Dart plugins
- Android device or emulator

### Installation
git clone https://github.com/Divya196/qr_form_app.git
cd qr_form_app
flutter pub get
flutter run


## Planned Enhancements

- Add cloud sync (Firebase or REST API)
- Build admin dashboard for transaction history
- Integrate user authentication and access roles
- Implement export to Excel or PDF
- Add error logging and analytics

## License

This project is a prototype intended for demonstration and educational purposes only.  
All rights reserved © 2025 Divya Ramesh.

Feel free to fork or extend this project with proper attribution.
