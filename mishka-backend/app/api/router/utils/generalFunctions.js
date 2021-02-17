function uniqueObject(arr) {
    //To store the unique sub arrays
    let uniques = [];

    //To keep track of the sub arrays
    let itemsFound = {};

    for (let val of arr) {
        //convert the sub array to the string
        let stringified = JSON.stringify(val);

        //If it is already added then skip to next element
        if (itemsFound[stringified]) {
            continue;
        }

        //Else add the value to the unique list
        uniques.push(val);

        //Mark it as true so that it can tracked
        itemsFound[stringified] = true;
    }

    //Return the unique list
    return uniques;
}
module.exports = {
    uniqueObject
};