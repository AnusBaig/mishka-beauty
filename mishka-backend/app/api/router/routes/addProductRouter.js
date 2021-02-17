const express = require("express");
const router = express.Router();
const db = require("../../../db/utils/database");
var _ = require("underscore");
const { filter, unique } = require("underscore");
//______________________________________________________________________
// add new brand

router.post("/addBrands",async(req,res)=>{
    brandName=req.body.brandName
    db.query("call addBrand(?)", [brandName],(err,result)=>{
   if(err){
    return res.status(500).send({message:"Error in Creating Product"})
   }
   else{
    return res.status(201).send({message:"New Product Created",data:result})
   }

    })
   
})
// ____________________________________________________________________________________________
// add new category
router.post("/addCategory",async(req,res)=>{
    categoryName=req.body.categoryName
    db.query("call addCategory(?)", [categoryName],(err,result)=>{
   if(err){
    return res.status(500).send({message:"Error in Creating Product"})
   }
   else{
    return res.status(201).send({message:"New Product Created",data:result})
   }

    })
   
})
//_____________________________________________
// add New sub category
router.post("/addSubCategory",async(req,res)=>{
    subCategoryName=req.body.subCategoryName
    categoryName=req.body.categoryName
    db.query("call addSubCategory(?,?);",[subCategoryName,categoryName],(err,result)=>{
   if(err){
    return res.status(500).send({message:err})
   }
   else{
    return res.status(201).send({message:"New Product Created",data:result})
   }

    })
   
})
//_____________________________________________
// add New sub category

router.post("/addGroupCategory",async(req,res)=>{
    subCategoryName=req.body.subCategoryName
    groupCategoryName=req.body.groupCategoryName
    db.query("call addGroupCategory(?,?);",[groupCategoryName,subCategoryName],(err,result)=>{
   if(err){
    return res.status(500).send({message:err})
   }
   else{
    return res.status(201).send({message:"New Product Created",data:result})
   }

    })
   
})

//__________________________________________
// get all categories
router.get("/category",async (req,res)=>{
  db.query("select * from  category_table",(err,result)=>{
      if(err) throw err
      res.send(result)
  })
//localhost:5000/api/add/category
}
)
//__________________________________________
// get all sub categories

router.get("/subCategory",async (req,res)=>{
    db.query("select * from  subcategory_table",(err,result)=>{
        if(err) throw err
        res.send(result)
    })
  //localhost:5000/api/add/category
  }
  )
 // get all  
 router.get("/",async (req,res)=>{

    db.query("select * from  brand_table",(err,result)=>{
        if(err) throw err
        
        brand=result
        
    })
    db.query("select * from  groupcategory_table",(err,result)=>{
        if(err) throw err
        
        grpcategory=result
        
    })
    res.send({brand:brand,grpcategory:grpcategory})
  //localhost:5000/api/add/category
  }
  )
 
module.exports = router; 