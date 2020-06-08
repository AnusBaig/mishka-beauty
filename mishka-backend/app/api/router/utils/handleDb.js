const {
    handleErrorResponse,
    handleLog
} = require('./handleLog');

async function save(Model, document) {
    try {
        let model = new Model(document);
        return await model.save();
    } catch (ex) {
        for (let field in ex.errors)
            handleLog('-- ' + ex.errors[field].message);
    }
}

async function docsCount(Model) {
    try {
        return await Model.countDocuments();
    } catch (ex) {
        handleLog(`${Model.name} Count cannot be fetched`);
    }
}

module.exports = {
    save,
    docsCount
};