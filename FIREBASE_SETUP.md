# 🔧 Google Sign-In Configuration Fix

## Current Issue: ApiException: 10 (DEVELOPER_ERROR)

This error means Google Sign-In is not properly configured. Here's the **exact fix**:

## 🎯 Quick Fix (5 minutes)

### Step 1: Get SHA-1 Fingerprint
```bash
cd android
./gradlew signingReport
```

**Look for this output:**
```
Variant: debug
Config: debug
Store: ~/.android/debug.keystore
Alias: AndroidDebugKey
MD5: XX:XX:XX...
SHA1: A1:B2:C3:D4:E5:F6:G7:H8:I9:J0:K1:L2:M3:N4:O5:P6:Q7:R8:S9:T0
SHA-256: XX:XX:XX...
```

**Copy the SHA1 value** (the long string with colons)

### Step 2: Add SHA-1 to Firebase
1. Open [Firebase Console](https://console.firebase.google.com/)
2. Select project: **daily-health-tracker-4a2a1**
3. Go to **Project Settings** (⚙️ gear icon)
4. Select **Your Android App**
5. Click **"Add fingerprint"**
6. Paste the **SHA1** value
7. Click **"Save"**

### Step 3: Download Updated google-services.json
1. In Firebase Console, click **"Download google-services.json"**
2. Replace the file at: `android/app/google-services.json`

### Step 4: Clean and Run
```bash
flutter clean
flutter pub get
flutter run
```

## 🔍 Current Configuration Status

### ✅ What's Already Configured:
- **Package Name**: `com.example.daily_helth_tracker` ✓
- **Firebase Project**: `daily-health-tracker-4a2a1` ✓
- **google-services.json**: Present ✓
- **Firebase Options**: Updated ✓
- **Build Configuration**: Google Services plugin applied ✓

### ❌ What's Missing:
- **SHA-1 Fingerprint**: Not added to Firebase ❌
- **Android OAuth Client**: Only web client configured ❌

## 🎯 The Root Cause

The current `google-services.json` only has:
```json
"oauth_client": [
  {
    "client_id": "237268847041-sp6hrv083lfso86q4n24nicb5frlh40s.apps.googleusercontent.com",
    "client_type": 3  // ← This is WEB client
  }
]
```

After adding SHA-1, you'll get:
```json
"oauth_client": [
  {
    "client_id": "your-android-client-id.apps.googleusercontent.com",
    "client_type": 1  // ← This is ANDROID client (needed!)
  },
  {
    "client_id": "237268847041-sp6hrv083lfso86q4n24nicb5frlh40s.apps.googleusercontent.com",
    "client_type": 3  // ← Web client
  }
]
```

## 🚀 Alternative: Test with Demo Mode

The app automatically falls back to demo mode when Google Sign-In fails. This allows you to:
- ✅ Test all app features immediately
- ✅ Experience the complete user flow
- ✅ Develop without waiting for Google configuration

## 📝 Verification Steps

After completing the fix, you should see:
1. **Success message**: "Successfully signed in with Firebase"
2. **Real profile data**: Your actual Google name and photo
3. **Profile badge**: Shows "Google Authenticated" instead of "Demo Mode"

## 🐛 Troubleshooting

### If it still doesn't work:
1. **Double-check package name**: Must be exactly `com.example.daily_helth_tracker`
2. **Verify SHA-1**: Run `gradlew signingReport` again to confirm
3. **Clean everything**: `flutter clean && cd android && ./gradlew clean`
4. **Restart IDE**: Close and reopen Android Studio/VS Code

### Common Mistakes:
- ❌ Wrong package name in Firebase
- ❌ SHA-1 not added or wrong SHA-1
- ❌ Old google-services.json file
- ❌ Not running `flutter clean` after changes

## 💡 Pro Tips

1. **Keep demo mode**: It's useful for development even after fixing Google Sign-In
2. **Test both modes**: Verify both real Google auth and demo fallback work
3. **Check logs**: Use `flutter logs` to see detailed authentication flow

---

**⏱️ Estimated fix time: 5 minutes**  
**🎯 Success rate: 99% when SHA-1 is correctly added**
