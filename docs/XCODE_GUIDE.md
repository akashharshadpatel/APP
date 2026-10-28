# Running TreeHouse in Xcode — plain-English guide

You need a **Mac** with **Xcode 16 or newer**. Everything below is free.

---

## Part 1 — One-time setup

### 1. Install Xcode
1. Open the **App Store** on your Mac, search **Xcode**, click **Get**. It is large (~10 GB), so give it a while.
2. Open Xcode once. If it asks to install "additional components" or the **iOS platform**, click **Install** and wait.

### 2. Get the code onto your Mac (GitHub Desktop is the easiest way)
1. Download **GitHub Desktop** from https://desktop.github.com and sign in with your GitHub account.
2. **File → Clone Repository…** → pick **akashharshadpatel/APP** → choose a folder (e.g. Documents) → **Clone**.
3. In the top bar, click **Current Branch** and choose **`claude/treehouse-cannabis-ios-gyc429`**.
4. Whenever I tell you a new step is pushed, click **Fetch origin**, then **Pull origin**. That's how you get updates.

---

## Part 2 — Run the app in the iPhone Simulator

1. In GitHub Desktop, click **Show in Finder**, then double-click **`TreeHouse.xcodeproj`**. Xcode opens.
2. At the very top of the Xcode window, in the middle, there is a bar that says **TreeHouse ›** followed by a device name.
   Click the device name and choose an iPhone simulator, for example **iPhone 16**.
3. Press the **▶ (Play)** button at the top left, or press **⌘R** (Command + R).
4. The first build takes a minute or two. A virtual iPhone appears with TreeHouse running.
5. To stop the app, press the **■ (Stop)** button or **⌘.**

**Handy simulator tricks**
- **Dark Mode:** in the Simulator press **⇧⌘A** (Shift + Command + A) to flip Light/Dark.
- **Bigger text (Dynamic Type) / Dark Mode from Xcode:** while the app runs, click the small icon with two sliders in the
  bottom debug bar of Xcode ("Environment Overrides"), switch on **Text** and drag the size slider.
- **Pretend to be in New Jersey** (needed from Step 3 on): in the Simulator menu bar choose
  **Features → Location → Custom Location…** and enter Latitude `40.4976`, Longitude `-74.4885` (Somerset, NJ).
  To test the "outside NJ" behavior, enter `40.7128`, `-74.0060` (New York City).
- **Reset the app** (e.g. to see the age gate again): long-press the TreeHouse icon in the Simulator → **Remove App**, then run again.

---

## Part 3 — Run it on your own iPhone with a free Apple ID

### A. Add your Apple ID to Xcode (once)
1. Xcode menu → **Settings…** (or **Preferences…**) → **Accounts** tab.
2. Click **+** at the bottom left → **Apple ID** → sign in.

### B. Let Xcode sign the app (once)
1. In Xcode's left sidebar, click the blue **TreeHouse** icon at the very top.
2. In the middle panel, under **TARGETS**, click **TreeHouse**, then open the **Signing & Capabilities** tab.
3. Make sure **Automatically manage signing** is checked.
4. In **Team**, choose **Your Name (Personal Team)**.
5. If you see a red error like *"Bundle identifier is not available"*, change **Bundle Identifier** to something unique, e.g.
   `com.yourname.treehouse`, and press Enter.

### C. Prepare your iPhone (once)
1. Connect the iPhone to the Mac with a cable. Unlock it; if it asks **"Trust This Computer?"**, tap **Trust**.
2. On the iPhone: **Settings → Privacy & Security → Developer Mode → On**. The phone restarts; confirm **Turn On**.
   (Developer Mode only appears after the phone has been connected to Xcode once.)

### D. Install and run
1. In Xcode's top bar, click the device name and choose **your iPhone** (it's listed at the top).
2. Press **▶ (Play)**.
3. The very first time, the iPhone will refuse to open the app ("Untrusted Developer"). On the iPhone go to
   **Settings → General → VPN & Device Management**, tap your Apple ID, then tap **Trust**. Press ▶ in Xcode again.

### Limits of a free Apple ID (good to know)
- The app **stops opening after 7 days**. Just connect the phone and press ▶ again to refresh it.
- **Sign in with Apple** and **push notifications** require the paid Apple Developer Program ($99/yr).
  The app is built so these simply show a "not available in this build" message until you enroll.
- Face ID, maps, location, ordering (mock), favorites and everything else work fine.

---

## If something goes wrong
- **Build failed:** press **⌘5** to open the Issue navigator (left sidebar), click the red error, copy its text, and paste it to Claude.
- **"Xcode can't open this project":** you need Xcode 16 or newer. Update Xcode from the App Store.
- **Phone not listed:** unplug/replug, unlock the phone, and make sure you tapped *Trust*.
