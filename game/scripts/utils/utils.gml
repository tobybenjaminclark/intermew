
/// @function getLargestNumber(arr)
/// @param {array} arr - The array of numbers
/// @return {real} - The largest number in the array

function max_in_arr(arr) {
    // Check if the array is empty
    if (array_length(arr) == 0) {
        return undefined; // or return a suitable value or error code
    }

    // Initialize the largest number with the first element
    var largest = arr[0];

    // Iterate through the array to find the largest number
    for (var i = 1; i < array_length(arr); i++) {
        if (arr[i] > largest) {
            largest = arr[i];
        }
    }

    return largest;
}