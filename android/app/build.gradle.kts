plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

val keystorePropertiesFile: File = rootProject.file("android/key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}

android {
    namespace = "com.onlinegrocery"
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
        applicationId = "com.onlinegrocery"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // 1️⃣ signingConfigs phải đặt trước khi gọi
    signingConfigs {
        create("dev") {
            storeFile = file(rootProject.file(keystoreProperties["DEV_STORE_FILE"] as String))
            storePassword = keystoreProperties["DEV_STORE_PASSWORD"] as String
            keyAlias = keystoreProperties["DEV_KEY_ALIAS"] as String
            keyPassword = keystoreProperties["DEV_KEY_PASSWORD"] as String
        }
        create("staging") {
            storeFile = file(rootProject.file(keystoreProperties["STG_STORE_FILE"] as String))
            storePassword = keystoreProperties["STG_STORE_PASSWORD"] as String
            keyAlias = keystoreProperties["STG_KEY_ALIAS"] as String
            keyPassword = keystoreProperties["STG_KEY_PASSWORD"] as String
        }
        create("prod") {
            storeFile = file(rootProject.file(keystoreProperties["PROD_STORE_FILE"] as String))
            storePassword = keystoreProperties["PROD_STORE_PASSWORD"] as String
            keyAlias = keystoreProperties["PROD_KEY_ALIAS"] as String
            keyPassword = keystoreProperties["PROD_KEY_PASSWORD"] as String
        }
    }

    // 2️⃣ Flavors
    flavorDimensions += "app"

    productFlavors {
        create("dev") {
            dimension = "app"
            applicationId = "com.onlinegrocery.dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "Online Grocery Dev")
            signingConfig = signingConfigs.getByName("dev")
        }

        create("staging") {
            dimension = "app"
            applicationId = "com.onlinegrocery.stg"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "Online Grocery Staging")
            signingConfig = signingConfigs.getByName("staging")
        }

        create("prod") {
            dimension = "app"
            applicationId = "com.onlinegrocery"
            resValue("string", "app_name", "Online Grocery")
            signingConfig = signingConfigs.getByName("prod")
        }
    }

    // 3️⃣ Build types
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            signingConfig = null // sẽ override bởi flavor
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        getByName("debug") {
            isDebuggable = true
        }
    }
}

flutter {
    source = "../.."
}
