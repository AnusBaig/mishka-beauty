const customerModel = require('../models/customerModel');

module.exports.getAllCustomers = async (req, res) => {
    customerModel.getAllCustomers(res);
};

module.exports.getCustomerDetail = async (req, res) => {
    customerModel.getCustomerDetail(req, res);
};