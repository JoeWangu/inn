plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.joey.inn"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.joey.inn"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        // We create a specific config for release (or debug if you prefer)
        release {
            // Look for the keystore file path from an environment variable
            // We will create this file in the GitHub workflow in the next step
            def keystorePath = System.getenv("KEYSTORE_PATH")
            
            // Look for passwords in environment variables
            def keystorePassword = System.getenv("STORE_PASSWORD")
            def keyAlias = "upload" // The alias you used when creating the keystore
            def keyPassword = System.getenv("KEY_PASSWORD")

            // Logic: If the file exists (GitHub), use it. 
            // If not (Local computer), use your local file if you have one, or fail gracefully.
            if (keystorePath != null && keystorePassword != null) {
                storeFile file(keystorePath)
                storePassword keystorePassword
                keyAlias keyAlias
                keyPassword keyPassword
            } else {
                // Optional: Fallback for local builds if you want
                // println "No CI keys found, strictly using local defaults"
            }
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            // Apply the signing config from above
            signingConfig = signingConfigs.getByName("release")
            minifyEnabled = true
            shrinkResources = true
            proguardFiles.add(file("proguard-rules.pro"))
        }
    }
}

flutter {
    source = "../.."
}
