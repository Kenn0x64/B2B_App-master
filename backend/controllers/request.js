const product = require("../models/product")
const request = require("../models/request")
const RESPONSE = require("../utils/express_api_res")


module.exports.makeRequest = async (req, res) => {
    let x
    try {
        x = await new request({
            ...req.body
        }).save()
    } catch (error) {
        res.error = error.message
        res.statusCode = 400
        console.log(error.message);
    }
    res.send(RESPONSE({ res, result: x }))
}

module.exports.updateProduct = async (req, res) => {
    let data=await request.findByIdAndUpdate(req.params.id, { 'status': req.params.status })
}

module.exports.getRequests = async (req, res) => {
    let x
    try {
        x = await request.find({}).populate('product')
    } catch (error) {
        res.error = error.message
        res.statusCode = 400
        console.log(error.message);
    }
    res.send(x)
} 
