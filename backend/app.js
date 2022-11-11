const express = require("express");
const cors=require("cors");
const app = express();
const database=require("./utils/database")
const productRouter=require("./routers/product")
const requestRouter=require("./routers/request")
const request=require("./models/request")
const product=require("./models/product")
// const helmet  = require("helmet");

//Settings
app.set('json spaces',10)

//middleweres
app.use(express.json());
app.use(express.urlencoded({extended:true}))
app.use(cors())
// app.use(helmet())

//Routers
app.use('/products',productRouter)
app.use('/requests',requestRouter)

app.get('/reset', async ()=>{
        await request.deleteMany({})
        await product.deleteMany({})
})

app.get('/test',async (req,res)=>{
    res.send("Server Is Up");
})


const PORT=process.env.PORT || 8000 
app.listen( PORT, () => {
    process.stdout.write('\033c');
    console.log(`\n\u2705 Startred Server! [ http://localhost:${PORT}/ ]`)
})