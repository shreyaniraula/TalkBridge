import { User } from "../models/user.model.js";

const generateAccessAndRefreshToken = async (userId) => {
    const user = await User.findById(userId);
    const accessToken = user.generateAccessToken();
    const refreshToken = user.generateRefreshToken();

    user.refreshToken = refreshToken
    await user.save({ validateBeforeSave: false });

    return { accessToken, refreshToken }
}

const registerUser = async (req, res) => {
    console.log("here");
    try {
        const { username, password } = req.body;

        if ([username, password].some((field) => field?.trim() === "")) {
            return res.status(400).json({ error: "All fields are required" });
        }

        const existedUser = await User.findOne({ username });

        if (existedUser) {
            return res.status(409).json({ error: "User with this username already exists." })
        }

        const user = await User.create({
            password,
            username: username
        });

        const createdUser = await User.findById(user._id).select("-password -refreshToken");

        if (!createdUser) {
            return res.status(500).json({ error: "Something went wrong while registering user" })

        }

        return res.status(200).json({ user: createdUser, message: "User registered successfully" });
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
}

const logInUser = async (req, res) => {
    try {
        const { username, password } = req.body;

        if ([username, password].some((field) => field?.trim() === "")) {
            return res.status(400).json({ error: "All fields are required" });
        }

        const userExists = await User.findOne({ username });

        if (!userExists) {
            return res.status(404).json({ error: "User does not exist" });
        }

        const isPasswordValid = await userExists.isPasswordCorrect(password);

        if (!isPasswordValid) {
            return res.status(401).json({ error: "Invalid Password" });
        }

        const { accessToken, refreshToken } = await generateAccessAndRefreshToken(userExists._id);

        const user = await User.findById(userExists._id).select("-password -refreshToken")

        const options = {
            httpOnly: true,
            secure: true
        }

        return res
            .status(200)
            .cookie("accessToken", accessToken, options)
            .cookie("refreshToken", refreshToken, options)
            .json({ token: accessToken, ...user._doc, message: "User logged in successfully" });
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
}

const logOutUser = async (req, res) => {
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
            .json({ message: "User logged out successfully" });
    } catch (e) {
        return res.status(500).json({ error: e.message });

    }
}

export { registerUser, logInUser, logOutUser };