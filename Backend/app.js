const express = require('express');
const app = express();

const userRoute = require('./api/routes/user');
const userMachine = require('./api/routes/machine');

app.use('/user', userRoute);
app.use('/machine', userMachine);

module.exports = app;