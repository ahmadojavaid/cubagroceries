# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }

# Gson / JSON serialization
-keepattributes Signature
-keepattributes *Annotation*

# Hive
-keep class ** extends com.google.protobuf.GeneratedMessageLite { *; }

# Keep play core library
-keep class com.google.android.play.core.** { *; }
