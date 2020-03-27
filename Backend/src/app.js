// app.js
import express from 'express';
import path from 'path';
import cookieParser from 'cookie-parser';
import logger from 'morgan';
import indexRouter from './routes/index';
const app = express();
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, '../public')));
app.use('/api', indexRouter);
app.use((req, res, next) => {
    const error = new Error("Route not found")
    error.status = 404
    next(error)
})
app.use((err, req, res, next) => {
    console.error(err)
    res.status(err.status || 500).json({
        error: {
            message: err.message
        }
    })
})
export default app;
