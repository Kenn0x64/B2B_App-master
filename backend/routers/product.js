const express = require('express');
const router = express.Router({ mergeParams: true });
const product = require('../controllers/product')
const catch_async = require('../utils/catch_async');



router.route('/new').post(catch_async(product.createProduct))
router.route('/delete/:id').get(catch_async(product.deleteProduct))
router.route('/').get(catch_async(product.getProducts))




module.exports = router

