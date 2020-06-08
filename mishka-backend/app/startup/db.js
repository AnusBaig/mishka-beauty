const {
    handleSevereErrorResponse,
    handleLog
} = require('../router/utils/handleLog');
const mongoose = require('mongoose');
const Fawn = require('fawn');

const conString = process.env.db_connection_string;

async function connect() {
    try {
        await mongoose.connect(conString, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            useCreateIndex: true
        });
        Fawn.init(mongoose);
        handleLog(`Connected to mongoDb server at ${conString}...`);
    } catch (ex) {
        handleSevereErrorResponse(`Cannot connect to mongodb at ${conString}...`);
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
    createModel,
    Fawn
};