//
//  EquipmentsListViewController.swift
//  GoGreen
//
//  Created by Gustavo Colaco on 13/10/18.
//  Copyright © 2018 Gustavo Colaco. All rights reserved.
//

import UIKit

class EquipmentsListViewController: UIViewController {
    
    var equipmentsList:[Equipments] = []
    
    var selectedEnvironment: Environments? {
        didSet{
            //load itens
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    


}
