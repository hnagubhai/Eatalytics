//
//  Item.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/22/23.
//

import SwiftUI

struct Item: Identifiable{
    
    var id = UUID().uuidString
    var title: String
    var price: String
    var subTitle: String
    var image: String
    var offset : CGFloat = 0
}

