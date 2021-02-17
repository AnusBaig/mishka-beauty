const express = require("express");
const router = express.Router();
const db = require("../../../db/utils/database");
const { clear } = require("winston");
const  unique_objects  = require('../utils/generalFunctions')


router.get("/categories", (req, res) => {
    db.query("select * from category_table", (err, result) => {

        if (err) {
            res.send({ message: err.message })
        } else {
            clear
            db.query("select * from subcategory_table", (err1, res1) => {
                if (err1) {
                    res.send({ message: err1.message })
                } else {
                    res.send({ categories: result, subCat: res1 })
                }
            })

        }
    })
})

router.get("/search", async(req, res) => {
        db.query("call searchProducts('%', '%', '%', '%', 'Face', '%', -1, 0, 1000);", (err, result) => {
                let attribute_list = []
                let unique_products = []
                if (err) throw err
                dirty_prodcuts = result[0]
                let uniqueArr = [...new Set(dirty_prodcuts.map(data => data.product_id))]
                uniqueArr.forEach(id => {
                    let product_attribute = []
                    let product_images = []
                    let filterr = dirty_prodcuts.filter(pro => pro.product_id === id)
                    let uniquee = filterr[0]
                    filterr.map(attr => {
                        temp = {}
                        const attribute_key = attr.attributr_key

                        var attribute_value = attr.attribute_value
                        var pics = attr.product_pictures
                        temp[attribute_key] = attribute_value
                        product_attribute.push(temp)
                        product_images.push(attr.product_pictures)


                    })
                    let uniquePics = [...new Set(product_images)];
                    //console.log(product_attribute);
                    //console.log("%%%%%%%%%");
                    product_attribute = unique_objects.uniqueObject(product_attribute)
                    uniquee['attributes'] = product_attribute
                    uniquee["pictures"] = uniquePics
                    unique_products.push(uniquee)
                })
                res.send(unique_products)

            })
            //localhost:5000/api/add/category
    }

)
router.get("/id", async(req, res) => {
    console.log(req.query['category']);
    var pName=req.query['pName']
    var cat=req.query["cat"]
    db.query(`call searchProducts('%', '%',?, '%',?, '%', -1, 0, 1000);`, [pName?pName:'%',cat?cat:'%'], (err, result) => {
        if (err) throw err
        let unique_products = []
        //console.log();
        dirty_prodcuts = result[0]
        let uniqueArr = [...new Set(dirty_prodcuts.map(data => data.product_id))]
        uniqueArr.forEach(id => {
            let product_attribute = []
            let product_images = []
            let product_varients = []
            let filterr = dirty_prodcuts.filter(pro => pro.product_id === id)
            let uniquee = filterr[0]
            filterr.map(attr => {
                temp = {}
                const attribute_key = attr.attributr_key

                var attribute_value = attr.attribute_value
                var pics = attr.product_pictures
                temp[attribute_key] = attribute_value
                product_attribute.push(temp)
                product_images.push(attr.product_pictures)
                product_varients.push(attr.variation_id)



            })
            let uniquePics = [...new Set(product_images)];
            let varients = [...new Set(product_varients)];
            product_attribute = unique_objects.uniqueObject(product_attribute)
            uniquee['attributes'] = product_attribute
            uniquee["pictures"] = uniquePics
            uniquee["varients"] = varients
            unique_products.push(uniquee)
        })

        res.send(unique_products)
    })

})


module.exports = router;