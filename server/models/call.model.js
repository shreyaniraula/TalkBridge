import mongoose, {Schema} from 'mongoose';

const callSchema = new Schema(
    {
        caller: {
            type: Schema.Types.ObjectId,
            ref: "User"
        },
        receiver: {
            type: Schema.Types.ObjectId,
            ref: "User"
        },
        duration:{
            type: Number,
            required: true
        }
    },
    {timestamps: true,},
);

export const Call = mongoose.model('Call', callSchema);