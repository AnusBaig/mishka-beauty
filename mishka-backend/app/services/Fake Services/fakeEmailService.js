const nodemailer = require("nodemailer");

module.exports = async function (to, subject, text) {
    const transporter = nodemailer.createTransport({
        host: process.env.fakemail_host,
        port: process.env.fakemail_port,
        secure: true,
        auth: {
            user: process.env.fakemail_user,
            pass: process.env.fakemail_password
        }
    });

    let info = '';
    try {
        info = await transporter.sendMail({
            from: process.env.fakemail_user,
            to,
            subject,
            text
        });

        return `Preview Fake email at URL: ${nodemailer.getTestMessageUrl(info)}`;
    } catch (e) {
        console.log('Error sending mail');
        return `Error occured while sending email at URL: " ${nodemailer.getTestMessageUrl(info)}`;
    }
}