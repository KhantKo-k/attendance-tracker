import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("mock") {
            dimension = "flavor-type"
            applicationId = "com.onenex.app_starter_kit_bloc.mock"
            resValue(type = "string", name = "app_name", value = "App Starter Kit (Mock)")
        }
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.onenex.app_starter_kit_bloc.dev"
            resValue(type = "string", name = "app_name", value = "App Starter Kit (Dev)")
        }
        create("uat") {
            dimension = "flavor-type"
            applicationId = "com.onenex.app_starter_kit_bloc.uat"
            resValue(type = "string", name = "app_name", value = "App Starter Kit (UAT)")
        }
        create("preprod") {
            dimension = "flavor-type"
            applicationId = "com.onenex.app_starter_kit_bloc.preprod"
            resValue(type = "string", name = "app_name", value = "App Starter Kit (Preprod)")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.onenex.app_starter_kit_bloc"
            resValue(type = "string", name = "app_name", value = "App Starter Kit (Prod)")
        }
    }
}