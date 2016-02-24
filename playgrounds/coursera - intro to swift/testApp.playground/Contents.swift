//: Playground - noun: a place where people can play

import UIKit

var str:String? = "Hello, playground!!"
str = "Hello World!"


var a = 45
var b = 10

var c = a + b

let image = UIImage(named: "image.jpeg")

for i in 0..<5 {
    i
}

let arrayss = [Int]()


//if example
let name = "Noe De La Mora"

if name.characters.count > 16 {
    print("long name son!")
} else if name.characters.count < 16 {
    print("your name is exactly " + String(name.characters.count) + " characters long.")
}

// switch example

switch name.characters.count {
case 5...10:
    print("I need to pee!!!")
case 10..<19:
    print("time to take off son!")
default:
    print("I'm done!")
}

//while loop example

var stars = "*"

while stars.characters.count <= 10 {
    print(stars)
    stars += "*"
}

//for loop example

stars = "*"

for (var i = stars.characters.count; i <= 10; i++ ) {
    print(stars)
    stars += "*"
}


//for-each loop example

stars = "*"

for number in 0..<10 {
    stars += "*"
}

for char in str!.characters {
    print(char)
}


// arrays and dictionaries example

var array = ["a", "b", "c"]
let values = ["alex","Noe","awwwnn"]

var dict = [String: String]()
for (index,r) in array.enumerate() {
    dict[r] = values[index]
}

// functions example

func add (a: Double, b: Double) ->String {
    return "adding " + String(a) + " and " + String(b) + " equals: " + String(a+b)
}

add(12.4, b:23.2)

//2D arrays

var imageArray = [
    [1, 3, 8, 3],
    [5, 7, 2, 8],
    [8, 3, 4, 2]
]

//function passing a variable that is modified inside the function and outside the function scope

func modifyImageValues(inout imageArray:Array<Array<Int>>) {
    for (index, row) in imageArray.enumerate() {
        for (i, col) in row.enumerate() {
            if (col < 5) {
                imageArray[index][i] = col + 5
            }
        }
    }
}

//need to add '&' telling the compiler to pass the exact variable and not a copy of it
modifyImageValues(&imageArray)

// week 3 question: this errors at run time on the second instruction
// let noValue:Int? = nil
// let unwrappedValue = noValue!



/*
Advanced topics: 

- classes
- structures
- protocols: (interface) you can declare functions but not declare them, classes that inherit a protocol need to implement those declared functions.
    + Question: can functions be declared and defined in a protocol? and if so, does a class that inherit a protocol need to define the function? (my guess is probably no)
- enums: enumerators used to define a list of something (cars, fruits, phones, etc.)
*/

enum filterNames {
    case theVintage
    case goGreen
    case colorBlind
    case cartoon
}

var aaa = filterNames.goGreen
