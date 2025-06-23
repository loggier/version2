buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.4.0") // Reemplaza con la versión más reciente si es necesario
        classpath("com.google.gms:google-services:4.4.1") // Agrega esta línea: dependencia del plugin de Google Services
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22") // Reemplaza con tu versión de Kotlin
        // ... otras dependencias de plugins si las tienes
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}