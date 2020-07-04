const {
    handleSevereErrorResponse,
    handleLog
} = require('../api/router/utils/handleLog');
const db = require('../db/utils/database');

async function connect() {
    try {
        db.connect(err => {
            if (err) {
                console.log('DB not connected');
                throw err;
            }
        });
        // handleLog(`Connected to mysql server...`);
    } catch (ex) {
        handleSevereErrorResponse(`Cannot connect to db...`);
    }
}

function createModel(collectionName, schema) {
    if (!collectionName || !schema)
        return handleLog(new Error(`${collectionName} model coudn't be created`));

    const dbSchema = new mongoose.Schema(schema);
    return mongoose.model(collectionName, dbSchema);
}

module.exports = {
    connect,
    createModel
};