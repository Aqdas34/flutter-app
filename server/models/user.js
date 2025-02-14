const mongoose = require("mongoose");
const userSchema = new mongoose.Schema({
    name : {
        require : true,
        type : String,
        trim : true,
    }
    ,
    email: {
        required: true, // Ensure correct spelling
        type: String,
        trim: true,
        validate: {
          validator: function (v) {
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i;
            return re.test(v); // Correctly validate email using test()
          },
          message: "Invalid Email",
        },
      },
    password : {
        require : true,
        type : String,
    },
    address : {
        type : String,
        default : "",
    },
    type :{
        type : String,
        default : "user",
    },
   

});
const User  = mongoose.model("User",userSchema);
module.exports = User;