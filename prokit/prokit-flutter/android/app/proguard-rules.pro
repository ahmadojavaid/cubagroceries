#---------------------------
# Flutter and Dart Specific
#---------------------------
-keep class io.flutter.embedding.** { *; }
-keep public class * extends io.flutter.embedding.android.FlutterActivity
-keep public class * extends io.flutter.embedding.android.FlutterFragmentActivity
-keep public class * extends io.flutter.embedding.engine.FlutterEngine

# Preserve classes with native methods
-keepclasseswithmembernames class * { native <methods>; }

#--------------------------------
# Firebase and gRPC (General Rules)
#--------------------------------
-keepnames class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.firebase.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod

# Firebase Messaging
-keep public class com.google.android.gms.** { *; }

# Firebase Auth
-keep public class com.google.firebase.auth.** { *; }

# Firestore
-keep public class com.google.firestore.** { *; }

# Firebase Remote Config
-keep public class com.google.firebase.remoteconfig.** { *; }

# Firebase Cloud Messaging
-keep public class com.google.firebase.messaging.** { *; }

#---------------------------
# Networking Libraries (HTTP, Retrofit)
#---------------------------
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn retrofit2.**
-keepattributes Signature
-keepattributes *Annotation*
-keep public class okhttp3.** { *; }

#---------------------------
# JSON Parsing (Gson)
#---------------------------
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes EnclosingMethod

#---------------------------
# Image and Media Libraries
#---------------------------
# Glide (if using)
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.AppGlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
    **[] $VALUES;
    public *;
}

# Cached Network Image (using flutter_cache_manager)
-keep public class com.baseflow.flutter.plugin.cachemanager.** { *; }
-dontwarn com.baseflow.flutter.plugin.cachemanager.**

# Video Player
-keep class io.flutter.plugins.videoplayer.** { *; }
-dontwarn io.flutter.plugins.videoplayer.**

#---------------------------
# Map Libraries
#---------------------------
# Google Maps
-keep public class com.google.android.gms.maps.** { *; }
-keep public class com.google.maps.android.** { *; }
-dontwarn com.google.android.gms.**

# Geolocator and Geocoding
-keep class com.baseflow.geolocator.** { *; }
-keep class com.baseflow.geocoding.** { *; }

#---------------------------
# Social Media Sign-In
#---------------------------
# Google Sign-In
-keep public class com.google.android.gms.auth.api.signin.** { *; }

# Apple Sign-In
-keep public class com.aboutyou.dart_packages.** { *; }
-dontwarn com.aboutyou.dart_packages.**

#---------------------------
# GetX State Management
#---------------------------
-keep class get.** { *; }
-dontwarn get.**

#---------------------------
# Notifications (Local and Push)
#---------------------------
-keep public class com.dexterous.flutterlocalnotifications.** { *; }
-keep public class com.onesignal.** { *; }
-dontwarn com.onesignal.**

#---------------------------
# UI and Animations
#---------------------------
-keep class io.flutter.plugins.flutter_lottie.** { *; }
-dontwarn io.flutter.plugins.flutter_lottie.**

#---------------------------
# QR Code and Scanners
#---------------------------
-keep public class com.github.davemorrissey.labs.subscaleview.** { *; }
-keep public class com.journeyapps.barcodescanner.** { *; }

#---------------------------
# Payment Integrations
#---------------------------
# Razorpay
-keep public class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Paystack
-keep public class co.paystack.flutter.** { *; }
-dontwarn co.paystack.flutter.**

#---------------------------
# Audio and TTS
#---------------------------
-keep public class com.ryanheise.just_audio.** { *; }
-keep public class com.tundralabs.fluttertts.** { *; }

#---------------------------
# Miscellaneous
#---------------------------
# Parcelables
-keep public class * implements android.os.Parcelable
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Annotations
-keepattributes *Annotation*
-keepattributes EnclosingMethod

# Enums
-keepclassmembers enum * { *; }

# Avoid warnings related to annotations
-dontwarn javax.annotation.**

# Prevent warnings from generated code
-dontwarn io.flutter.plugins.**
-dontwarn com.google.protobuf.**

# Retain all classes that are used as entry points by Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }

-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
