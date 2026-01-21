exports.onMessageCreate = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snap, context) => {
    const msg = snap.data();
    const chatId = context.params.chatId;

    const chatDoc = await admin.firestore()
      .collection("chats")
      .doc(chatId)
      .get();

    const members = chatDoc.data().members;

    for (const uid of members) {
      if (uid === msg.senderId) continue;

      const userDoc = await admin.firestore()
        .collection("users")
        .doc(uid)
        .get();

      const tokens = userDoc.data()?.fcmTokens || [];

      if (tokens.length === 0) continue;

      const payload = {
        data: {
          chatId,
          messageId: context.params.messageId,
          type: msg.type,
          senderId: msg.senderId,
        },
        notification: {
          title: "New Message",
          body: msg.text || "Media message",
        },
        android: {
          priority: "high",
        },
      };

      await admin.messaging().sendToDevice(tokens, payload);
    }
  });
