function RESPONSE({res,result}) {
    return {
        Message: res.statusMessage,
        StatusCode:res.statusCode,
        Error: res.error,
        Result:result
    }
}
module.exports=RESPONSE