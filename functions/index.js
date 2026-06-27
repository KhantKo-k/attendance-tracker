const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
const {getMessaging} = require("firebase-admin/messaging");

initializeApp();

const ADMIN_TOPIC = "admins";
const ATTENDANCE_CHANNEL = "attendance_channel";

exports.notifyAdminOnCheckIn = onDocumentCreated(
    "attendance_logs/{logId}",
    async (event) => {
      const data = event.data?.data();
      if (!data || data.type !== "check_in") {
        return;
      }

      const userName = data.userName || "A user";
      const userId = data.userId || "";
      const logId = event.params.logId;

      await getMessaging().send({
        topic: ADMIN_TOPIC,
        notification: {
          title: "New check-in",
          body: `${userName} checked in`,
        },
        data: {
          type: "check_in",
          userId,
          logId,
        },
        android: {
          priority: "high",
          notification: {
            channelId: ATTENDANCE_CHANNEL,
          },
        },
        apns: {
          payload: {
            aps: {
              sound: "default",
            },
          },
        },
      });
    },
);
