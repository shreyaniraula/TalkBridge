import express from "express";
import cookieParser from 'cookie-parser'
import cors from "cors";
import userRouter from "./routes/user.routes.js";
import { CORS_ORIGIN } from "./constant.js";

const app = express();

app.use(cors());

app.use(express.urlencoded({
    extended: true
}));
app.use(express.json());
app.use(cookieParser());

//routes declaration
app.use('/api/users', userRouter);
export {app}