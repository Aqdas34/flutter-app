const express = require('express');
const Chef = require('../models/chef'); // Assuming you have a Chef model
const auth = require('../middleware/auth');
const Cuisine = require('../models/cuisine');
const User = require('../models/user');
const mongoose = require('mongoose');
const router = express.Router();

// Route to list all chefs with respect to their specialities
router.get('/api/listBySpeciality', auth, async (req, res) => {
    try {
        const { speciality } = req.query;
        if (!speciality) {
            return res.status(400).json({ message: 'Speciality is required' });
        }
        const cuisines = await Cuisine.find({ CuisineType: speciality });
     
        if (!cuisines.length) {
            return res.status(404).json({ message: 'No cuisines found for this speciality' });
        }
        const chefIds = cuisines.map(cuisine => cuisine.ChefId);
    
        const chefs = await Chef.find({ ChefID: { $in: chefIds.map(id => id.toString()) } });
        if (!chefs.length) {
            return res.status(404).json({ message: 'No chefs found for this speciality' });
        }
          const combinedData = await Promise.all(chefs.map(async chef => {
            const user = await User.findById(chef.ChefID);
            return {
                ...chef.toObject(),
                ...user.toObject()
            };
        }));
        
        res.status(200).json(combinedData);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});




router.get('/api/listChefCuisines', auth, async (req, res) => {
    const { chefId } = req.query;
    try {
        if (!chefId) {
            return res.status(400).json({ message: 'Chef ID is required' });
        }
        // Properly construct ObjectId using "new"
        const objectId = new mongoose.Types.ObjectId(chefId);
        const cuisines = await Cuisine.find({ ChefId: objectId });
        const user = await User.findById(objectId);
        if (!cuisines.length) {
            return res.status(404).json({ message: user.name + ' has no cuisines' });
        }
        res.status(200).json(cuisines);
    } catch (error) {
        console.error(`Error fetching cuisines for chefId ${chefId}:`, error);
        res.status(500).json({ message: 'Server error', error });
    }
});


router.get("/test", (req, res) => {
    res.send("Chef route works");
});



module.exports = router;