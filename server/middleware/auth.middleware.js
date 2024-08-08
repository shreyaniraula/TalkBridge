import jwt from "jsonwebtoken";
import ACCESS_TOKEN_SECRET from '../constant.js'
import { User } from "../models/user.model.js";

export const verifyJWT = async(req, res, next)=>{
    try {
        const token = req.cookies?.accessToken || req.header("Authorization")?.replace("Bearer ", "");

        if(!token){
            res.status(401).json({error: "Unauthorized request"});
        }

        const decodedToken = jwt.verify(token, ACCESS_TOKEN_SECRET);

        const user = User.findById(decodedToken?._id).select("-password -refreshToken");

        if(!user){
            res.status(401).json({error: "Invalid access token"});
        }

        req.user = user;
        next();
    } catch (e) {
        res.status(500).json({error: e.message});
        
    }
}