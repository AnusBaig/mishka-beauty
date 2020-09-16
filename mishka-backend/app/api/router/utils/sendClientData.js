const {
    generateAuthToken
} = require("./transformClientData");

module.exports.sendAuthorizedToken = (res, user) => {
    if (user['password']) delete user['password'];
    if(!user['isAdmin']) user['isAdmin']=false; 

    const token = generateAuthToken(user);
    console.log(`Token: ${token}`);

    const login = {
        loginMessage: `${user.username} Logged In ${token}`,
        loggedIn: 1
    }

    res.set("x-auth-token", token).send(login);
};