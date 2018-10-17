//
//  Section.swift
//  GoGreen
//
//  Created by Gustavo Colaco on 13/10/18.
//  Copyright © 2018 Gustavo Colaco. All rights reserved.
//

import UIKit
import CoreData


struct Section {
    
    
    var type: String!
    var equips: [Equipments]!
    var expanded: Bool!
    
    init(type: String, equips: [Equipments], expanded: Bool){
        self.type = type
        self.equips = equips
        self.expanded = expanded
    }
 
    
}




