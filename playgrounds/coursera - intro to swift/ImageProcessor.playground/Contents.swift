//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "blonde.jpg")!

// Process the image!
var rgbImage = RGBAImage.init(image: image)!
let filters = filterProcessor.init(image: rgbImage)!

//Filters can be applied in any order. these are various samples of direct calls to the filters

//filters.lumos()
//filters.moreGreen()
//filters.greyScale()
//filters.lumos(190)
//filters.vintagePrinter()
//filters.richerDarks(100, average: 100, difference: 100)

//there's also preset ones which include a mix of 2 or more filters:
//filters.presetFilters(.iSeeTheLight)
filters.presetFilters(.theVintage)

var newImage: UIImage = rgbImage.toUIImage()!
