# 🎧 Mobile Audiometer – App-Based Digital Hearing Screening

A Flutter-based mobile application designed to conduct preliminary hearing screenings, particularly for school-going children. The application uses pure-tone audio signals to assess hearing responses at different frequencies and presents the results through a digital audiogram.

## 📌 Project Overview

The **Mobile Audiometer** is a software-centric digital hearing screening application developed to make preliminary hearing assessments more accessible and convenient.

The application generates audio tones at selected frequencies and sound levels. Users respond when they hear a tone, and the application records their responses to generate screening results and a visual audiogram.

The project aims to support early identification of potential hearing difficulties and encourage timely referral to qualified hearing-care professionals.

> **Important:** This application is intended for preliminary hearing screening and referral support only. It is not a clinically certified audiometer and must not be used as a replacement for professional hearing evaluation or medical diagnosis.

## ✨ Key Features

- **User Registration:** Enter basic participant details such as name, age, gender, school, and class.
- **Audio Tone Generation:** Generate pure-tone audio signals for hearing screening.
- **Multiple Test Frequencies:** Test at 250 Hz, 500 Hz, 1000 Hz, 2000 Hz, 4000 Hz, and 8000 Hz.
- **Multiple Sound Levels:** Conduct screening using different predefined audio levels.
- **Left and Right Ear Testing:** Record hearing responses separately for each ear.
- **Response Recording:** Capture whether the participant hears the generated tone.
- **Digital Audiogram:** Display recorded hearing responses in a graphical format.
- **Screening Results:** View the recorded results after completing the test.
- **PDF Report Generation:** Generate a PDF report containing screening information and results.
- **Calibration Section:** Provide a dedicated section for audio setup and calibration-related checks.

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform application development |
| Dart | Application programming language |
| Android Studio | Android emulator and development tools |
| VS Code | Code editor |
| audioplayers | Audio playback and tone generation |
| fl_chart | Audiogram visualization |
| pdf | PDF report generation |
| printing | PDF preview and printing |

## 📱 Application Workflow

1. Open the Mobile Audiometer application.
2. Register the participant by entering the required details.
3. Complete the available audio setup and calibration checks.
4. Start the hearing screening.
5. Select the ear, test frequency, and sound level.
6. Play the generated tone.
7. Record the participant's response.
8. Repeat the process for the selected frequencies and both ears.
9. View the screening results and digital audiogram.
10. Generate a PDF report.

## 📊 Test Parameters

| Parameter | Values |
|---|---|
| Test Frequencies | 250, 500, 1000, 2000, 4000, 8000 Hz |
| Ears | Left Ear and Right Ear |
| Audio Levels | 10, 20, 30, 40, 50, 60 |
| Response | Heard / Not Heard |
| Result | Recorded screening responses and audiogram |

**Note:** The audio levels shown in the application are predefined application values. They must not be interpreted as calibrated dB HL measurements unless the complete device and earphone setup has been professionally calibrated and validated.

## ⚙️ Installation and Setup

### Prerequisites

Make sure you have installed:

- Flutter SDK
- Dart SDK
- Android Studio
- Visual Studio Code
- Android emulator or a physical Android device

### 1. Clone the Repository

```bash
git clone https://github.com/aryan29rajpoot-glitch/mobile-audiometer.git
```

### 2. Navigate to the Project

```bash
cd mobile-audiometer
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Check Flutter Setup

```bash
flutter doctor
```

### 5. Run the Application

```bash
flutter run
```

To build a release APK:

```bash
flutter build apk --release
```

The generated APK can be found at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## 📁 Project Structure

```text
mobile-audiometer/
│
├── android/              # Android platform configuration
├── ios/                  # iOS platform configuration
├── lib/                  # Main Flutter application source code
├── linux/                # Linux platform configuration
├── macos/                # macOS platform configuration
├── web/                  # Web platform configuration
├── windows/              # Windows platform configuration
│
├── test/                 # Application tests (if included)
├── pubspec.yaml          # Project dependencies and configuration
├── pubspec.lock          # Locked dependency versions
├── analysis_options.yaml # Dart analysis configuration
├── .gitignore            # Files excluded from Git
└── README.md             # Project documentation
```

## 🎯 Project Objectives

- Make preliminary hearing screening more accessible.
- Support early identification of possible hearing difficulties.
- Provide a simple and child-friendly screening workflow.
- Record hearing responses digitally.
- Visualize screening results using an audiogram.
- Generate reports that can support referral to hearing-care professionals.

## 🔮 Future Enhancements

- Professional calibration and validation against a clinical audiometer.
- Ambient noise monitoring during screening.
- Improved device and earphone compatibility checks.
- More advanced response validation and quality-control mechanisms.
- Secure storage and management of screening records.
- Integration with healthcare professionals for referral and follow-up.
- Improved screening analytics and reporting.

## ⚠️ Limitations and Disclaimer

This project is developed for educational and preliminary screening purposes.

Smartphone hardware, earphones, volume settings, and environmental noise can affect audio output and screening results. Reliable clinical hearing thresholds require validated calibration of the complete audio setup.

The application does not diagnose hearing loss or replace an audiologist, ENT specialist, or clinical audiometric assessment.

## 👨‍💻 Developers

Aryan Rajpoot
Kanak Shevgaonkar
Kritgya Purohit
Prince Salunkhe

B.Tech – Computer Science and Engineering (Data Science)

Shri Vaishnav Vidyapeeth Vishwavidyalaya

GitHub: [@aryan29rajpoot-glitch](https://github.com/aryan29rajpoot-glitch)

---

⭐ If you find this project interesting, feel free to explore the repository and share your feedback.

**Project:** Mobile Audiometer – App-Based Digital Hearing Screening
