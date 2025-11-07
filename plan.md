✅ Night Reader App — Development Checklist
 Phase 1 — Setup & Base Project

- [x]  Create Flutter project night_reader
- [x]  Add dependencies:
    - [x]  audioplayers
    - [x]  wakelock_plus
    - [x]  shared_preferences
    - [x]  provider or riverpod
    - [x]  flutter_animate or lottie
    - [x]  share_plus
- [x]  Setup folder structure:
lib/
  core/
    theme/
    constants/
  features/
    home/
    sound/
    profile/
  widgets/

- [x]  Configure pubspec.yaml for assets (sounds, icons)
- [x]  Test initial run on Android & iOS

 Phase 2 — Brightness & Theme

- [x]  Create Brightness Control UI (gesture)
-- top swipe to increce the brightness
-- swipe botton to descrice brightness
-- swipe left to change the color theme
-- swipe right to change the color theme
- [x]  Implement gradient backgrounds for:
    - [x]  Warm theme
    - [x]  Cool theme
    - [x]  Normal theme
- [x]  Add toggle button/swipe for theme switching
- [x]  Store selected theme in SharedPreferences
- [x]  Use smooth transition animation on theme change

️ Phase 3 — Control Panel

- [x]  Add bottom control bar with 4 icons:
    - [ ]  Timer ⏱️
    - [ ]  Theme 
    - [ ]  Sound 
    - [ ]  Profile 
- [x]  Implement modal bottom sheets for each control
- [x]  Add long-press to lock/unlock screen brightness
- [x]  Show lock overlay icon when active
- [x]  Keep layout responsive in landscape & portrait mode

 Phase 4 — Ambient Sound Player

- [x]  Add local sound files (rain, river, water, flute)
- [x]  Implement background sound player using audioplayers
- [x]  Add play/pause & volume controls
- [x]  Allow loop playback
- [x]  Keep playing even when screen is locked
- [x]  Store last selected sound in SharedPreferences

⏰ Phase 5 — Timer & Auto Sleep

- [x]  Add preset timers:
    - [x]  Infinite (no auto-off)
    - [x]  30 minutes
    - [x]  1 hour
    - [ ]  Custom option
- [x]  Implement countdown timer
- [x]  On timer end:
    - [x]  Gradually dim screen brightness
    - [x]  Stop audio playback
    - [ ]  Optionally fade-out animation
- [x]  Show active timer on control bar

 Phase 6 — Profile & Info

- [x]  Create Profile screen with options:
    - [ ]  Tutorial
    - [ ]  Rate App
    - [x]  Share App
    - [x]  Privacy Policy
    - [ ]  Credits
    - [x]  Exit App
- [x]  Implement navigation from control bar → Profile
- [x]  Link privacy policy HTML page
- [x]  Add app share functionality (share_plus)
- [x]  Add confirmation dialog for Exit button

 Phase 7 — Polish & Finishing Touches

- [x]  Add fade animations for theme & brightness
- [x]  Add sound fade-in/fade-out transition
- [x]  Implement onboarding / first-time setup screen
- [x]  Set app icon & splash screen (flutter_launcher_icons, flutter_native_splash) (Note: Placeholder images used, need to be replaced with actual assets)
- [x]  Test on both Android & iOS
- [x]  Optimize battery & performance
- [x]  Final QA: brightness lock, timer accuracy, background audio check

 Future Add-ons (Optional)

- [ ]  Auto-off when device flipped (motion sensor)
- [ ]  Reading stats dashboard
- [ ]  Custom light color picker
- [ ]  Integration with reading apps (Kindle / Apple Books)
- [ ]  Minimal “lamp-only” widget mode
