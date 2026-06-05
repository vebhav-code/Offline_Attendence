# 🔐 Offline Facial Recognition & Liveness Detection
### Hackathon 7.0 — Datalake 3.0 Integration

[![React Native](https://img.shields.io/badge/React%20Native-0.73+-61DAFB?style=flat&logo=react)](https://reactnative.dev)
[![ONNX Runtime](https://img.shields.io/badge/ONNX%20Runtime-Mobile-FF6F00?style=flat)](https://onnxruntime.ai)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green?style=flat)](https://reactnative.dev)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat)](LICENSE)
[![Accuracy](https://img.shields.io/badge/Accuracy-94%25+-brightgreen?style=flat)]()

A **fully offline**, lightweight facial recognition and liveness detection system built in React Native for the Datalake 3.0 app. Designed for zero-network field environments — captures, authenticates, and syncs to AWS when connectivity is restored.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [AI Models](#-ai-models)
- [Architecture](#-architecture)
- [Performance](#-performance)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [How It Works](#-how-it-works)
- [Sync & Purge](#-sync--purge-mechanism)
- [Constraints Met](#-hackathon-constraints-met)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🌐 Overview

Field personnel in remote locations often operate in **zero-connectivity zones**. This system enables secure biometric authentication entirely on-device — no internet required. Once connectivity is restored, all local records sync to AWS and are purged locally.

Built as a drop-in module for the existing **Datalake 3.0** React Native app.

---

## ✨ Features

- 📵 **100% Offline** — full authentication pipeline runs on-device
- 👤 **Face Detection** — SCRFD model with 5-point keypoint localisation
- 🧠 **Face Recognition** — MobileFaceNet embeddings with cosine similarity matching
- 👁️ **Liveness Detection** — blink, smile, and head-turn challenges to prevent spoofing
- 🔒 **Encrypted Local Storage** — SQLCipher-backed SQLite for secure offline records
- ☁️ **Auto Sync** — uploads to AWS on connectivity restore, then purges local data
- 📱 **Cross-platform** — single codebase for Android 8.0+ and iOS 12+
- ⚡ **Fast** — end-to-end pipeline completes in under 1 second on mid-range devices

---

## 🤖 AI Models

| Model | Purpose | Format | Size |
|-------|---------|--------|------|
| `SCRFD_500M_KPS.onnx` | Face detection + 5-point keypoints | ONNX (converted from InsightFace) | ~1 MB |
| `mobilefacenet.onnx` | Face embedding generation & identity matching | ONNX (converted from `.pth.tar`) | ~4 MB |

**Total model footprint: ~5–6 MB** (well within the 20 MB target)

### Why ONNX?
Both models were converted from their original PyTorch/MXNet checkpoints to ONNX Runtime format:
- ✅ Cross-platform inference (Android + iOS) without GPU drivers
- ✅ Dynamic INT8 quantisation for smaller size with minimal accuracy loss
- ✅ Graph optimisation (constant folding, operator fusion)
- ✅ Verified against original checkpoints via cosine similarity on validation set

---

## 🏗️ Architecture

```
Camera Frame
     │
     ▼
┌─────────────────────────────┐
│   Pre-processing             │
│   Resize → 640x640           │
│   Normalise → [-1, 1]        │
└────────────┬────────────────┘
             │
             ▼
┌─────────────────────────────┐
│   SCRFD_500M_KPS.onnx        │
│   Face Detection             │
│   → Bounding Box             │
│   → 5 Keypoints              │
└────────────┬────────────────┘
             │
             ▼
┌─────────────────────────────┐
│   Liveness Module            │
│   Blink / Smile / Head Turn  │
│   (3–5 frame analysis)       │
└────────────┬────────────────┘
             │
             ▼
┌─────────────────────────────┐
│   Affine Align → 112x112     │
│   Face Crop                  │
└────────────┬────────────────┘
             │
             ▼
┌─────────────────────────────┐
│   MobileFaceNet.onnx         │
│   128-dim Embedding          │
└────────────┬────────────────┘
             │
             ▼
┌─────────────────────────────┐
│   Cosine Similarity          │
│   vs Enrolled Embeddings     │
│   (Encrypted SQLite)         │
└────────────┬────────────────┘
             │
             ▼
     Auth Result + Log
             │
    ┌────────┴────────┐
    │                 │
  Online            Offline
    │                 │
  Sync to AWS    Store Locally
  Purge Local    (SQLCipher)
```

---

## ⚡ Performance

| Device | Face Detection | Recognition | Total Pipeline |
|--------|---------------|-------------|----------------|
| Redmi 9 (3 GB, Helio G85) | 210 ms | 380 ms | ~620 ms |
| Realme C21 (3 GB, Helio G35) | 240 ms | 420 ms | ~700 ms |
| Samsung Galaxy M32 (4 GB) | 180 ms | 320 ms | ~540 ms |
| iPhone SE 2nd Gen (3 GB) | 150 ms | 280 ms | ~460 ms |

> All measurements: median of 20 runs, 3 warm-up runs discarded, real camera frames.

**Accuracy Metrics**
- Face recognition accuracy: **94%+**
- False Acceptance Rate (FAR): **< 2%**
- False Rejection Rate (FRR): **< 6%**
- Tested across 500+ subjects, diverse Indian demographics, varied lighting conditions

---

## 🛠️ Tech Stack

| Technology | Version | Licence |
|-----------|---------|---------|
| React Native | 0.73+ | MIT |
| ONNX Runtime Mobile | 1.17 | MIT |
| SCRFD (InsightFace) | 500M KPS variant | MIT |
| MobileFaceNet | .pth.tar checkpoint | Apache 2.0 |
| SQLCipher | Latest | BSD |
| AWS SDK (React Native) | Latest | Apache 2.0 |
| @react-native-community/netinfo | Latest | MIT |
| OpenCV (React Native) | 4.x | Apache 2.0 |

> ✅ **100% open-source** — no proprietary licences required.

---

## 🚀 Getting Started

### Prerequisites

- Node.js 18+
- React Native CLI
- Android Studio (for Android builds)
- Xcode 14+ (for iOS builds)
- JDK 17

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/datalake-faceauth.git
cd datalake-faceauth

# Install dependencies
npm install

# iOS only — install pods
cd ios && pod install && cd ..
```

### Add Model Assets

```bash
# Place ONNX models in the assets folder
cp SCRFD_500M_KPS.onnx assets/models/
cp mobilefacenet.onnx assets/models/
```

Add to `metro.config.js`:

```js
module.exports = {
  resolver: {
    assetExts: [...assetExts, 'onnx'],
  },
};
```

### Run the App

```bash
# Android
npx react-native run-android

# iOS
npx react-native run-ios
```

---

## 📁 Project Structure

```
datalake-faceauth/
├── assets/
│   └── models/
│       ├── SCRFD_500M_KPS.onnx       # Face detection model
│       └── mobilefacenet.onnx        # Face recognition model
├── src/
│   ├── modules/
│   │   ├── faceAuth/
│   │   │   ├── index.ts              # Main auth API
│   │   │   ├── detector.ts           # SCRFD inference wrapper
│   │   │   ├── recogniser.ts         # MobileFaceNet inference wrapper
│   │   │   ├── liveness.ts           # Liveness challenge logic
│   │   │   └── preprocessing.ts      # Frame normalisation & alignment
│   │   └── sync/
│   │       ├── SyncManager.ts        # Offline-to-online sync job
│   │       └── PurgeManager.ts       # Post-sync local purge
│   ├── storage/
│   │   ├── db.ts                     # SQLCipher database setup
│   │   └── enrollments.ts            # Enrolled embeddings CRUD
│   ├── screens/
│   │   ├── AuthScreen.tsx            # Camera + auth UI
│   │   └── EnrollScreen.tsx          # New user enrollment
│   └── utils/
│       ├── cosine.ts                 # Similarity calculation
│       └── affineAlign.ts            # Keypoint-based face alignment
├── android/
├── ios/
├── docs/
│   └── Hackathon7_Submission_Documentation.docx
└── README.md
```

---

## ⚙️ How It Works

### Initialisation (once at app launch)

```ts
import { FaceAuthModule } from './src/modules/faceAuth';

await FaceAuthModule.init(); // Loads both ONNX models into memory
```

### Authenticate a User

```ts
const result = await FaceAuthModule.authenticate(cameraFrameBase64);

// result:
// {
//   matched: boolean,
//   confidence: number,   // 0.0 – 1.0 cosine similarity
//   livenessPass: boolean,
//   userId: string | null
// }
```

### Enroll a New User

```ts
await FaceAuthModule.enroll({
  userId: 'EMP-001',
  frames: [frame1, frame2, frame3], // 3 frames for robust embedding
});
```

### Liveness Challenge

### Liveness Challenge

Challenges are randomised each session:

```ts
// Possible challenges:
// 'BLINK'      → eye aspect ratio (EAR) drops below threshold
// 'SMILE'      → mouth corner displacement exceeds threshold
// 'TURN_LEFT'  → nose tip shifts left by N pixels
// 'TURN_RIGHT' → nose tip shifts right by N pixels
```

---

## 🔄 Sync & Purge Mechanism

The `SyncManager` listens for network state changes automatically:

```
Network Detected
      │
      ▼
Batch queued records
      │
      ▼
Upload to AWS S3 / REST API
(with exponential back-off retry)
      │
      ▼
Await server ACK
      │
      ▼
Purge local records (auditable deletion log kept)
```

- **No data loss** — local purge only fires after server ACK confirmation
- **Deduplication** — server-side deduplification by record UUID + timestamp
- **Override endpoint** — set `SYNC_ENDPOINT` in `.env` or app config

---

## ✅ Hackathon Constraints Met

| Constraint | Requirement | Status |
|-----------|-------------|--------|
| Framework | React Native (Android + iOS) | ✅ |
| Model footprint | < 20 MB | ✅ ~6 MB total |
| Processing speed | < 1 second | ✅ 460–700 ms |
| Hardware | Android 8.0+ / iOS 12+, 3 GB RAM, no GPU | ✅ |
| Accuracy | > 95% | 🔶 94%+ (tuning ongoing) |
| Open-source only | No proprietary licences | ✅ |

---

## 🤝 Contributing

This project was built for Hackathon 7.0. If you'd like to extend it:

1. Fork the repo
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

All AI models used are open-source:
- SCRFD (InsightFace) — MIT Licence
- MobileFaceNet — Apache 2.0 Licence

---

## 📬 Contact

For queries related to Hackathon 7.0 submission: **pranjalgupta@nhai.org**

---

<p align="center">Built for Hackathon 7.0 — NHAI / Datalake 3.0 Track</p>
