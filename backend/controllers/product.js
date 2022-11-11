const product = require("../models/product")
const request = require("../models/request")
const RESPONSE = require("../utils/express_api_res")


module.exports.createProduct = async (req, res) => {
    console.log(req.body);

    let x
    try {
        x = await new product({
            ...req.body
        }).save()
    } catch (error) {
        res.error=error.message
        res.statusCode=400
        console.log(error.message);
    }
    res.send(RESPONSE({res,result: [x]}));
}


module.exports.deleteProduct = async (req, res) => {
   try {
       await product.findByIdAndDelete(req.params.id)
       await request.deleteMany({product:req.params.id})
       res.statusCode=200
       res.statusMessage="DELETED"
   } catch (error) {
    res.statusCode=400
    res.statusMessage="Error"
    res.error=error.message
    console.log(error.message);
   }
}


module.exports.getProducts = async (req, res) => {
    let x
    try {
        x = await product.find({})
    } catch (error) {
        res.error=error.message
        res.statusCode=400
        console.log(error.message);
    }
    res.send(x)
} 
