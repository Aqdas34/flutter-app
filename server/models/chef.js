const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const ChefSchema = new Schema({
    ChefID: {
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    Bio: {
        type: String,
        required: true
    },



    Experience: {
        type: Number,
        required: true
    },
    Specialties: {
        type: [String],
        required: true
    },
    Rating: {
        type: Number,
        default: 0
    },
    AvailabilityStatus: {
        type: String,
        enum: ['Available', 'Unavailable'],
        default: 'Unavailable'
    },
    PricingPerHour: {
        type: Number,
        required: true
    },
    ProfileVerificationStatus: {
        type: String,
        enum: ['Pending', 'Verified', 'Rejected'],
        default: 'Pending'
    },
    VerifiedBadge: {
        type: Boolean,
        default: false
    },
    BackgroundImage:{
        type: String,
        required: false,
    },
    GigImage:{
        type: String,
        required: false,
    }



});

module.exports = mongoose.model('Chef', ChefSchema);