//
//  AddEquipViewController.swift
//  GoGreen
//
//  Created by Gustavo Colaco on 14/10/18.
//  Copyright © 2018 Gustavo Colaco. All rights reserved.
//

import UIKit
import CoreData

class AddEquipViewController: EquipmentsListViewController {
    
    @IBOutlet weak var equipNameTf: UITextField!
    @IBOutlet weak var equipPowerTf: UITextField!
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func addEquip(_ sender: Any) {
        
        dismiss(animated: true) {
            self.addElement(withNameFrom: self.equipNameTf, withPowerFrom: self.equipPowerTf)
        }
        
    }
    
    func addElement(withNameFrom textField: UITextField, withPowerFrom textFieldPower: UITextField) {
        let newEquip = Equipments(context: self.context)
        newEquip.name = equipNameTf.text
        newEquip.power = Double(equipPowerTf.text!)!
        
        self.sections.append(Section(type: "Outros", equips: [newEquip], expanded: false))
        
        do{
            try self.context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
