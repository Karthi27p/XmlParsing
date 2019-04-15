//
//  ViewController.swift
//  XmlParser
//
//  Created by TRINGAPPS on 24/02/19.
//  Copyright © 2019 TRINGAPPS. All rights reserved.
//

import UIKit

struct Food {
    var name: String
    var price: String
    var description: String
    var calories: String
}


class ViewController: UIViewController, XMLParserDelegate {

    var foodName = String()
    var foodPrice = String()
    var foodDescription = String()
    var foodCalories = String()
    var foods: [Food] = []
    var elementName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.w3schools.com/xml/simple.xml")
        let requestUrl = URLRequest(url: url!)
        Service.ApiRequest(requestUrl: requestUrl) { (data, error) in
            if((data) != nil)
            {
                let parser = XMLParser(data: data as! Data)
                parser.delegate = self
                parser.parse()
            } else {
                NSLog(error as! String)
            }
        }
    }
    func parser(_: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "food" {
             foodName = String()
             foodPrice = String()
             foodDescription = String()
             foodCalories = String()
        }
        print(attributeDict["name"] as Any)
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "food" {
            let foodItem = Food(name: foodName, price: foodPrice, description: foodDescription, calories: foodCalories)
            self.foods.append(foodItem)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if(!data.isEmpty) {
            if self.elementName == "name" {
                foodName += data
            } else if self.elementName == "price" {
                foodPrice += data
            } else if self.elementName == "description" {
                foodDescription += data
            } else if self.elementName == "calories" {
                foodCalories += data
            }
        }
    }



}

