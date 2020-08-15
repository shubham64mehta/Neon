const functions = require('firebase-functions');
const admin =require('firebase-admin');
admin.initializeApp();
exports.myfunction = functions.firestore.document('Comments/{message1}/{message2}/{message3}').onCreate((snap,context)=>{
    console.log(snap.data());
    return admin.messaging().sendToTopic('Comments',{
        notification:{
            title:"Neon",
            body:snap.data().review+
                snap.data().name+":"+"Commented",
            clickAction:'FLUTTER_NOTIFICATION_CLICK'
        }
    });
});
exports.myfunction2 = functions.firestore.document('Reply/{message1}/{message2}/{message3}').onCreate((snap,context)=>{
    console.log(snap.data());
    return admin.messaging().sendToTopic('Comments',{
        notification:{
            title:"Neon",
            body:snap.data().review+
                snap.data().name1+":"+"replied",
            clickAction:'FLUTTER_NOTIFICATION_CLICK'
        }
    });
});
