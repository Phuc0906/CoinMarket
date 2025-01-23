# CoinMarket - iOS Cryptocurrency Trading App

CoinMarket is an iOS application designed to provide a user-friendly experience for browsing, buying, and managing cryptocurrencies. Built with Swift and SwiftUI, the app utilizes the MVVM (Model-View-ViewModel) architectural pattern and leverages Firebase for backend functionalities.

## Key Features

- **User Authentication:** Secure user registration and login handled by Firebase Authentication.
- **Cryptocurrency Browsing:** View a list of available cryptocurrencies (CryptoView).
- **Cryptocurrency Details:** View detailed information about a specific cryptocurrency (CoinDetailView).
- **Buying Cryptocurrencies:** Purchase digital assets (BuyView).
- **Buy History:** Track past cryptocurrency purchases (BuyHistoryView).
- **User Profile:** Manage user information (ProfileView).
- **Transfer Cryptocurrency:** Transfer crypto using QR codes for easy transactions.
- **Dark Mode Support:** Enjoy a seamless experience with dark mode compatibility.
- **Multi-Language Support:** Access the app in multiple languages for a broader audience.

## Architecture

CoinMarket follows the MVVM architectural pattern:

- **View:** SwiftUI views responsible for displaying the user interface (e.g., `CryptoView`, `CoinDetailView`, `BuyView`, `BuyHistoryView`, `ProfileView`).
- **ViewModel:** ViewModels act as an intermediary between the View and the Model, handling UI logic and data preparation (e.g., `CryptoViewModel`, `DetailViewModel`, `BuyViewModel`, `BuyHistoryViewModel`, `AuthViewModel`).
- **Model:** Data models representing the application's data (e.g., `CoinManager`, `UserManager`, `Transaction`).

The app's backend is powered by Firebase, handling user authentication and data persistence.

## Technologies Used

This section details the technologies and tools used in the development of the CoinMarket app.

**Programming Language:**

- **Swift:** The primary programming language for iOS development, known for its efficiency and reliability.

**UI Frameworks:**

- **SwiftUI:** A declarative UI framework for building user interfaces across Apple platforms, streamlining UI development and creating intuitive interfaces.
- **UIKit:** Provides a set of components, classes, and tools that enable more options for creating graphical user interfaces. (Likely used for specific functionalities not yet fully implemented in SwiftUI.)

**Backend and Data Management:**

- **Firebase:** A mobile and web application development platform.
  - **FirebaseAuth:** Provides robust user authentication services.
  - **FirebaseCore:** Facilitates seamless integration of Firebase services.
  - **FirebaseFirestore:** Offers real-time data synchronization and efficient storage management through a NoSQL cloud database.

**Other Frameworks and Libraries:**

- **Foundation:** Provides fundamental data types and essential functionality for data manipulation and system interactions.
- **Combine:** A declarative Swift API for processing values over time, reacting to changes, and handling asynchronous operations.
- **CodeScanner:** Integrates QR code scanning capabilities.

**Development and Collaboration Tools:**

- **GitHub:** A platform for version control, team collaboration, and code sharing.

**Architectural Pattern (Inferred from the diagram):**

- **MVVM (Model-View-ViewModel):** While not explicitly stated in the provided text, the application flow diagram strongly suggests the use of MVVM to separate concerns and manage data flow between the UI and data models.

## Future Improvements

- Bug fixes and performance enhancements.
- Additional user-focused features (e.g., selling cryptocurrencies, setting price alerts, portfolio tracking).
- Enhanced UI/UX.
- Biometric Authentication.
- Reset Password Functionality.
- Filtering Options.
- **Expand Multi-Language Support:** Add more languages based on user feedback.
- **Improve QR Code Functionality:** Enhance the transfer feature for better usability.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Phuc0906/CoinMarket.git
   ```

2. **Open the project in Xcode:**

   Navigate to the cloned directory and open the `CoinMarket.xcodeproj` file in Xcode.

3. **Install CocoaPods dependencies (if applicable):**

   If your project uses CocoaPods for dependency management, run the following command in the terminal from the project directory:

   ```bash
   pod install
   ```

4. **Configure Firebase:**

   - Set up a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Download the `GoogleService-Info.plist` file from your Firebase project settings.
   - Add the `GoogleService-Info.plist` file to your Xcode project by dragging it into the project navigator.

5. **Build and run the app:**

   Select a simulator or a physical device and click the "Run" button in Xcode to build and run the app.
