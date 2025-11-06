✅ Night Reader App — Development Checklist
 Phase 1 — Setup & Base Project

- [x]  Create Flutter project night_reader
- [ ]  Add dependencies:
    - [ ]  audioplayers
    - [ ]  wakelock_plus
    - [ ]  shared_preferences
    - [ ]  provider or riverpod
    - [ ]  flutter_animate or lottie
    - [ ]  share_plus
- [ ]  Setup folder structure:
lib/
  core/
    theme/
    constants/
  features/
    home/
    sound/
    profile/
  widgets/

- [ ]  Configure pubspec.yaml for assets (sounds, icons)
- [ ]  Test initial run on Android & iOS

 Phase 2 — Brightness & Theme

- [ ]  Create Brightness Control UI (gesture)
-- top swipe to increce the brightness
-- swipe botton to descrice brightness
-- swipe left to change the color theme
-- swipe right to change the color theme
- [ ]  Implement gradient backgrounds for:
    - [ ]  Warm theme
    - [ ]  Cool theme
    - [ ]  Normal theme
- [ ]  Add toggle button/swipe for theme switching
- [ ]  Store selected theme in SharedPreferences
- [ ]  Use smooth transition animation on theme change

️ Phase 3 — Control Panel

- [ ]  Add bottom control bar with 4 icons:
    - [ ]  Timer ⏱️
    - [ ]  Theme 
    - [ ]  Sound 
    - [ ]  Profile 
- [ ]  Implement modal bottom sheets for each control
- [ ]  Add long-press to lock/unlock screen brightness
- [ ]  Show lock overlay icon when active
- [ ]  Keep layout responsive in landscape & portrait mode

 Phase 4 — Ambient Sound Player

- [ ]  Add local sound files (rain, river, water, flute)
- [ ]  Implement background sound player using audioplayers
- [ ]  Add play/pause & volume controls
- [ ]  Allow loop playback
- [ ]  Keep playing even when screen is locked
- [ ]  Store last selected sound in SharedPreferences

⏰ Phase 5 — Timer & Auto Sleep

- [ ]  Add preset timers:
    - [ ]  Infinite (no auto-off)
    - [ ]  30 minutes
    - [ ]  1 hour
    - [ ]  Custom option
- [ ]  Implement countdown timer
- [ ]  On timer end:
    - [ ]  Gradually dim screen brightness
    - [ ]  Stop audio playback
    - [ ]  Optionally fade-out animation
- [ ]  Show active timer on control bar

 Phase 6 — Profile & Info

- [ ]  Create Profile screen with options:
    - [ ]  Tutorial
    - [ ]  Rate App
    - [ ]  Share App
    - [ ]  Privacy Policy
    - [ ]  Credits
    - [ ]  Exit App
- [ ]  Implement navigation from control bar → Profile
- [ ]  Link privacy policy HTML page
- [ ]  Add app share functionality (share_plus)
- [ ]  Add confirmation dialog for Exit button

 Phase 7 — Polish & Finishing Touches

- [ ]  Add fade animations for theme & brightness
- [ ]  Add sound fade-in/fade-out transition
- [ ]  Implement onboarding / first-time setup screen
- [ ]  Set app icon & splash screen (flutter_launcher_icons, flutter_native_splash)
- [ ]  Test on both Android & iOS
- [ ]  Optimize battery & performance
- [ ]  Final QA: brightness lock, timer accuracy, background audio check

 Future Add-ons (Optional)

- [ ]  Auto-off when device flipped (motion sensor)
- [ ]  Reading stats dashboard
- [ ]  Custom light color picker
- [ ]  Integration with reading apps (Kindle / Apple Books)
- [ ]  Minimal “lamp-only” widget mode
