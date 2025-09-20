plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

val keystorePropertiesFile: File = rootProject.file("key.properties")
val keystoreProperties = Properties()

// Load keystore properties with validation
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
} else {
    throw GradleException("Keystore properties file not found at: ${keystorePropertiesFile.absolutePath}")
}

// Helper function to get required property with validation
fun getRequiredProperty(key: String): String {
    val value = keystoreProperties[key] as String?
    return value ?: throw GradleException("Required property '$key' not found in keystore properties file")
}

// Helper function to get optional property with default
fun getOptionalProperty(key: String, defaultValue: String): String {
    return keystoreProperties[key] as String? ?: defaultValue
}

// Helper function to validate keystore file exists
fun validateKeystoreFile(storeFile: String): File {
    val file = rootProject.file(storeFile)
    if (!file.exists()) {
        throw GradleException("Keystore file not found: ${file.absolutePath}. Please ensure the keystore file exists at the specified path.")
    }
    return file
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
            storeFile = validateKeystoreFile(getRequiredProperty("DEV_STORE_FILE"))
            storePassword = getRequiredProperty("DEV_STORE_PASSWORD")
            keyAlias = getRequiredProperty("DEV_KEY_ALIAS")
            keyPassword = getRequiredProperty("DEV_KEY_PASSWORD")
        }
        create("staging") {
            storeFile = validateKeystoreFile(getRequiredProperty("STG_STORE_FILE"))
            storePassword = getRequiredProperty("STG_STORE_PASSWORD")
            keyAlias = getRequiredProperty("STG_KEY_ALIAS")
            keyPassword = getRequiredProperty("STG_KEY_PASSWORD")
        }
        create("prod") {
            storeFile = validateKeystoreFile(getRequiredProperty("PROD_STORE_FILE"))
            storePassword = getRequiredProperty("PROD_STORE_PASSWORD")
            keyAlias = getRequiredProperty("PROD_KEY_ALIAS")
            keyPassword = getRequiredProperty("PROD_KEY_PASSWORD")
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
            isShrinkResources = false // Resource shrinking requires code shrinking to be enabled
            signingConfig = null // sẽ override bởi flavor
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        getByName("debug") {
            isDebuggable = true
            isMinifyEnabled = false
            isShrinkResources = false // Explicitly disable resource shrinking for debug builds
        }
    }
}

flutter {
    source = "../.."
}
