const Express = require('express');

const customerWebPages = require('./express-routers/customerWebPages');
const adminWebPages = require('./express-routers/adminWebPages');
const customerApis = require('./express-routers/customerApis');
const adminApis = require('./express-routers/adminApis');

const app = Express();

app.use('/customer', customerWebPages);
app.use('/api/customer', customerApis);

app.use('/admin', adminWebPages);
app.use('/api/admin', adminApis);

app.get('/', (req, res) => {
    res.send('Request on no router');
})

app.listen(3000, () => {
    console.log('Server running on port 3000!!');
})