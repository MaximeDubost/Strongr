const express = require('express');
const app = express();

const userRoute = require('./api/routes/user');
const userMachine = require('./api/routes/machine');
const loginUser = require('./api/routes/login');

app.use(express.json({'limit' : '200mb'}));
app.use('/user', userRoute);
app.use('/machine', userMachine);
app.use('/login', loginUser);

module.exports = app;