const express = require('express');
const router = express.Router({ mergeParams: true });
const catch_async = require('../utils/catch_async');
const request = require('../controllers/request')



router.route('/new').post(catch_async(request.makeRequest))
router.route('/').get(catch_async(request.getRequests))
router.route('/:id/:status').get(request.updateProduct)



module.exports = router

