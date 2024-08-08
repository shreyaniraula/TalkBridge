import {User} from "../models/user.model.js";

const generateAccessAndRefreshToken = async(userId)=>{
    try{
        const user = await User.findById(userId);
        const accessToken = user.generateAccessToken();
        const refreshToken = user.generateRefreshToken();

        user.refreshToken = refreshToken
        await user.save({validateBeforeSave: false});

        return {accessToken, refreshToken}
    }catch(e){
        res.status(500).json({error: e.message});
    }
}

const registerUser = async(req, res)=>{
    try {
        const {username, password} = req.body;

        if([username, password].some((field)=>field?.trim() === "")){
            res.status(400).json({error: "All fields are required"});
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

const logInUser = async(req, res)=>{
    try {
        const {username, password} = req.body;

        if([username, password].some((field)=>field?.trim() === "")){
            res.status(400).json({error: "All fields are required"});
        }

        const user = await User.findOne({username});

        if(!user){
            res.status(404).json({error: "User does not exist"});
        }
        
        const isPasswordValid = await user.isPasswordCorrect(password);
        
        if(!isPasswordValid){
            res.status(401).json({error: "Invalid Password"});
        }

        const {accessToken, refreshToken} = await generateAccessAndRefreshToken(user._id);

        const loggedInUser = await User.findById(user._id).select("-password -refreshToken")

        const options = {
            httpOnly: true,
            secure: true
        }

        return res
        .status(200)
        .cookie("accessToken", accessToken, options)
        .cookie("refreshToken", refreshToken, options)
        .json({message: "User logged in successfully"});
    } catch (e) {
        res.status(500).json({error: e.message});
    }
}

const logOutUser = async(req, res)=>{
    try {
        await User.findByIdAndUpdate(
            req.user._id,
            {
                $set: {
                    refreshToken: undefined
                }
            },
            {
                new: true
            }
        )
        const options = {
            httpOnly: true,
            secure: true
        }
        return res
        .status(200)
        .clearCookie("accessToken", options)
        .clearCookie("refreshToken", options)
        .json({message: "User logged out successfully"});
    } catch (e) {
        res.status(500).json({error: e.message});
        
    }
}

export {registerUser, logInUser, logOutUser};