import express from "express";
import cookieParser from 'cookie-parser'
import cors from "cors";
import userRouter from "./routes/user.routes.js";

const app = express();

app.use(cors({
    origin: process.env.CORS_ORIGIN,
    credentials: true
}));

app.use(express.json());
app.use(cookieParser());

//routes declaration
app.use('/api/users', userRouter)
export {app}