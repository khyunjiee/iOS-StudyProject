//
//  SwiftyJSON+Helper.swift
//  SharePosts
//
//  Created by hyunji on 2020/11/27.
//

import UIKit
import SwiftyJSON

infix operator =>
infix operator =|
infix operator =<

typealias OptionalJSON = [String : JSON]?

func =>(key : String, json : OptionalJSON) -> String?{
    return json?[key]?.stringValue
}

func =<(key : String, json : OptionalJSON) -> [String : JSON]?{
    return json?[key]?.dictionaryValue
}

func =|(key : String, json : OptionalJSON) -> [JSON]?{
    return json?[key]?.arrayValue
}

prefix operator /

prefix func /(value: Int?) -> Int {
    return value ?? 0
}

prefix func /(value: [JSON]?) -> [JSON] {
    return value ?? []
}

prefix func /(value: [String]?) -> [String] {
    return value ?? []
}

prefix func /(value : String?) -> String {
    return value ?? ""
}

