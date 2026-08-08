// /stalls コレクションへのマスタデータ投入スクリプト（Firebase Admin SDK使用）
// Firestore Security Rules がクライアントからの /stalls 書き込みを禁止しているため、
// サーバー側（Admin SDK）からのみ投入可能。
//
// 実行方法:
//   1. npm install firebase-admin
//   2. Firebase Console > プロジェクト設定 > サービスアカウント からキーをダウンロードし
//      serviceAccountKey.json として同ディレクトリに配置（.gitignore 対象・絶対にコミットしない）
//   3. node seed_stalls.js

const admin = require('firebase-admin');
const stalls = require('./stalls.json');

admin.initializeApp({
  credential: admin.credential.cert(require('./serviceAccountKey.json')),
});

const db = admin.firestore();

async function seedStalls() {
  const batch = db.batch();

  for (const [stallId, data] of Object.entries(stalls)) {
    const ref = db.collection('stalls').doc(stallId);
    batch.set(ref, data);
  }

  await batch.commit();
  console.log(`Seeded ${Object.keys(stalls).length} stalls.`);
}

seedStalls()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
