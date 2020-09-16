const sgMail = require('@sendgrid/mail');
const config = require('config');
const handleLog = require('../api/router/utils/handleLog');

sgMail.setApiKey(process.env.mishka_mail_api_key);

module.exports = async function (to, subject, text) {
    try {
        await sgMail.send({
            to,
            from: process.env.mishka_mail_from,
            subject,
            text
        });

        return `Successfully sent Email to: ${to}`;
    } catch (e) {
        if (e.response)
            console.log(e.response.body);

        return `Error occurred sending Email to: ${to}`;
    }
}