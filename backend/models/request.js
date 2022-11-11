const { number } = require("joi");
const mongoose = require("mongoose");

const RequetsSchema = new mongoose.Schema({
   product: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'products'
   },
   status: {
      //[1:'Accepted',0:'Rejected',2:'Pending']
      type: Number,
   },
   requestedCapacity: {
      type: Number
   },
   siteName: {
      type: String,
      lowercase :true,
   }
})

module.exports = mongoose.model("requests", RequetsSchema);