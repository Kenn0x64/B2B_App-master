const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
    productName: {
        type: String,
        lowercase: true,
        unique: [true, 'ProductName Must Be Unique'],
        require: [true, 'Invaild Product Name']
    },
    capacity: {
        type: Number,
        require: [true, 'Invaild Product Name']
    },
    price: {
        type: Number,
        require: [true, 'Invaild Price']
    }

})

module.exports = mongoose.model("products", productSchema);  