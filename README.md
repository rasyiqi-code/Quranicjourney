# Quranic Journey

**Quranic Journey** is a modern, feature-rich Islamic application designed to accompany your daily spiritual journey. Built with Flutter, it combines elegant design with powerful features to help you connect with the Quran and Islamic teachings.

## 🌟 Key Features

### 📖 Read Quran
- **Smooth Reading Experience**: Clean and readable Arabic font with adjustable size.
- **Audio Playback**: Listen to verse-by-verse recitations (Mishary Rashid Alafasy) with gapless playback support.
- **Auto-Play**: Continuous playback mode for seamless listening.
- **Translations**: Toggle between Arabic-only and translation view.

### 🧘 Tadabbur Mode (Reflection)
- **30 Life Situations**: Curated verses and reflections for various emotional states (e.g., Sad, Anxious, Happy, Grateful).
- **Deep Insights**: Each situation includes:
    - **Life Connection**: How the verse relates to your feeling.
    - **Reflection**: Practical advice for spiritual growth.
    - **Brief Tafsir**: Concise explanation of the verse.
    - **Key Points**: Actionable takeaways.
- **Localized Content**: Available in both Indonesian and English.

### 💡 Islamic Fun Facts (AI-Powered)
- **Daily Knowledge**: Discover interesting facts about Islam, Quran, Hadith, and History.
- **AI Generation**: Powered by Google Gemini to generate unique and accurate content.
- **Localized**: Generates content based on your selected app language (ID/EN).
- **Offline Access**: Saved facts are stored locally for offline reading.

### 🌍 Multi-Language Support
- **Bilingual**: Full support for **Indonesian** and **English**.
- **Dynamic Switching**: Change language instantly from the Home Screen.
- **Localized Content**: All features, including Tadabbur and Funfacts, adapt to the selected language.

### 🏆 Gamification (Symbolic)
- **Pahala Points**: Earn symbolic rewards for reading verses and exploring features.
- **Milestones**: Track your progress with Islamic-themed milestones.
- **Disclaimer**: Points are for motivation only; true reward is with Allah.

### 🤝 Donation
- Support the continuous development of the application directly from the Home Screen.

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Local Database**: Sqflite (for Funfacts)
- **AI Integration**: Google Generative AI (Gemini)
- **Audio**: Just Audio
- **Localization**: Flutter Localizations

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/rasyiqi-code/quranic_journey.git
   cd quranic_journey
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Gemini API Key**
   - Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey).
   - Add it to `lib/core/services/gemini_service.dart` or configure it via environment variables.

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screenshots

*(Add screenshots here)*

## 📄 License

This project is licensed under the MIT License.

---
*Built with ❤️ for the Ummah.*
