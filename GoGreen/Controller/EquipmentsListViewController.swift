//
//  EquipmentsListViewController.swift
//  GoGreen
//
//  Created by Gustavo Colaco on 13/10/18.
//  Copyright © 2018 Gustavo Colaco. All rights reserved.
//

import UIKit
import CoreData

class EquipmentsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    

    
    var sections: [Section]  = []
    var userEquips: [Equipments] = []
    var tvArray: [Equipments] = []
    
    var selectedEnvironment: Environments? {
        didSet{
            //load itens
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Televisão
        let tvPortatil = Equipments(context: context)
        tvPortatil.name = "TV Portatil"
        tvPortatil.power = 227.5
        
        let tvCores55 = Equipments(context: context)
        tvCores55.name = "TV Cores 55\" LED"
        tvCores55.power = 165

        let tvCores32 = Equipments(context: context)
        tvCores32.name = "TV Cores 32\" LED"
        tvCores32.power = 95
        
//        tvArray.append(tvCores55)
//        tvArray.append(tvPortatil)
        
        
        sections.append(Section(type: "Televisão", equips: [tvPortatil], expanded: false))
        
        sections.append(Section(type: "Ar Condicionado", equips: [tvPortatil], expanded: false))
        sections.append(Section(type: "Computador", equips: [tvPortatil], expanded: false))
        sections.append(Section(type: "Lampadas", equips: [tvPortatil], expanded: false))
        sections.append(Section(type: "Cozinha", equips: [tvPortatil], expanded: false))
        sections.append(Section(type: "Outros", equips: [tvPortatil], expanded: false))
        
        

    }
    
    @IBAction func addEquipment(_ sender: Any) {
        let addEquip = storyboard?.instantiateViewController(withIdentifier: "addEquipVC") as! AddEquipViewController
        addEquip.modalPresentationStyle = .overCurrentContext
        present(addEquip, animated: true, completion: nil)

        var textFieldName = UITextField()
        var textFieldPower = UITextField()

        let alert = UIAlertController(title: "Adicionar Equipamento", message: "", preferredStyle: .alert)

        let add = UIAlertAction(title: "Adicionar", style: .default) { (action) in
            let newEquip = Equipments(context: self.context)
            newEquip.name = textFieldName.text!
            newEquip.power = Double(textFieldPower.text!)!

            self.sections.append(Section(type: "Outros", equips: [newEquip], expanded: false))
            self.saveCategories()
            self.loadData()
            
        }

        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        alert.addAction(add)
        alert.addAction(cancel)


        alert.addTextField { (text) in
            textFieldName = text
            textFieldName.placeholder = "Nome do ambiente"

        }
        alert.addTextField { (textPower) in
            textFieldPower = textPower
            textFieldPower.keyboardType = .decimalPad
            textFieldPower.placeholder = "Potencia do ambiente em Watts"

        }

        present(alert, animated: true, completion: nil)
        
    }
    
    func saveCategories() {
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)

        }

        tableView.reloadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<Equipments> = Equipments.fetchRequest()

        do{
            userEquips = try context.fetch(request)

        }catch {
            print(error.localizedDescription)
        }
 
    }
    
    
}


    //MARK: - tableview data source and delegates

extension EquipmentsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].equips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentCell")!
        
        cell.textLabel?.text = sections[indexPath.section].equips[indexPath.row].name
        let power = sections[indexPath.section].equips[indexPath.row].power
        
        cell.detailTextLabel?.text = String("\(power) W")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded){
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
}

    //MARK: - expandable header delegate

extension EquipmentsListViewController: ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].equips.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].type, section: section, delegate: self)
        return header
    }
    
}


//extension EquipmentsListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Equipments> = Equipments.fetchRequest()
//        
//        request.predicate = NSPredicate(format: "name CONTAINS [cd] %@", searchBar.text!)
//
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
//
//        do{
//            sections = try context.fetch(request)
//        }catch{
//            print(error.localizedDescription)
//        }
//
//        tableView.reloadData()
//
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadElement()
//            tableView.reloadData()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//
//
//}

