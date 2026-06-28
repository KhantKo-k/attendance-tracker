import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("local") {
            dimension = "flavor-type"
            applicationId = "com.kkz.attendance_tracker.local"
            resValue(type = "string", name = "app_name", value = "Attendance Tracker (Local)")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.kkz.attendance_tracker.staging"
            resValue(type = "string", name = "app_name", value = "Attendance Tracker (Staging)")
        }
        create("production") {
            dimension = "flavor-type"
            applicationId = "com.kkz.attendance_tracker.production"
            resValue(type = "string", name = "app_name", value = "Attendance Tracker (Production)")
        }
    }
}
