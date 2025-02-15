

const express = require("express");
const User = require("../models/user");
const Chef = require("../models/chef");
const bcrypt = require("bcryptjs");
const jwt = require('jsonwebtoken');
const auth = require("../middleware/auth");
const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
    try {
      const { name, email, password } = req.body;
      const existingUser = await User.findOne({ email });
      if (existingUser) {
        return res.status(400).json({ message: "User already exists" });
      }
  
      const hashedPassword = await bcrypt.hash(password, 10);
      let user = new User({
        email,
        password: hashedPassword,
        name,
      });
  
      // Save the user and handle any validation errors
      await user.save();
      res.json(user);
    } catch (e) {
      if (e.name === "ValidationError") {
        // Send a 400 status with the validation error message
        return res.status(400).json({ error: e.message });
      }
      // Generic server error
      res.status(500).json({ error: e.message });
    }
  });
  


authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;
        const userExist = await User.findOne({ email });
        if (!userExist) {
            return res.status(500).json({ error: "User Doesn't  exists " });
        }
        const isMatch = await bcrypt.compare(password, userExist.password);
        if (!isMatch) {
            return res.status(500).json({ error: "Incorrect Password " });
        }
        const token = jwt.sign({ id: userExist._id }, "passwordKey");
        res.json({ token, ...userExist._doc });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


authRouter.post("/tokenIsValid", async (req, res) => {
    try {
      const token = req.header("x-auth-token");
      if (!token) return res.json(false);
      const verified = jwt.verify(token, "passwordKey");
      if (!verified) return res.json(false);
  
      const user = await User.findById(verified.id);
      if (!user) return res.json(false);
      res.json(true);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });



authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });

});

authRouter.post('/api/becomeChef', auth,async (req, res) => {
  try {
      const { ChefID } = req.body;
      console.log("ChefID",  req.user._id);


      // Step 1: Find the user by ID
      const user = await User.findById(req.user);
      console.log("user", user);
      if (!user) {
          return res.status(404).json({ message: 'User not found' });
      }

      // Step 3: Check if the user is already a chef
      const existingChef = await Chef.findOne({ChefId: user._id });
      if (existingChef) {
          return res.status(400).json({ message: 'User is already a chef' });
      }
      // Step 2: Check if the user is verified
      if (!user.isVerified) {
          return res.status(403).json({ message: 'User is not verified' });
      }
      user.type = 'chef';
      await user.save();

      // Step 4: Create a new Chef entry
      const newChef = new Chef({ChefID: user._id
        ,...req.body});
      const savedChef = await newChef.save();

      // Step 5: Return the saved chef
      res.status(201).json(savedChef);
  } catch (error) {
      console.error('Error adding chef:', error);
      res.status(500).json({ message: error.message });
  }
});







// authRouter.get("/api/users", async (req, res) => {
//     try {
//         res.json({ "data ": "users" });
//     } catch (e) {
//         res.status(500).json({ error: e.message });
//     }
// });
module.exports = authRouter;
