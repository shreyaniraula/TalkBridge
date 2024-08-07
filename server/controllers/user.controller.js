import {User} from "../models/user.model.js";

const registerUser = async(req, res)=>{
    try {
        const {username, password} = req.body;

        if([username, password].some((field)=>field?.trim() === "")){
            return res.status(400).json({error: "All fields are required"})
        }

        const existedUser = await User.findOne({username});

        if(existedUser){
            res.status(409).json({error: "User with this username already exists."})
        }

        const user = await User.create({
            password,
            username: username
        });

        const createdUser = await User.findById(user._id).select("-password -refreshToken");

        if(!createdUser){
            res.status(500).json({error: "Something went wrong while registering user"})

        }

        return res.status(201).json({message: "User registered successfully"});
    } catch (e) {
        return res.status(500).json({error: e.message});
    }
}

export default registerUser;