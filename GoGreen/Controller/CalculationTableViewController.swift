//
//  CalculationTableViewController.swift
//  GoGreen
//
//  Created by Gustavo Colaco on 12/10/18.
//  Copyright © 2018 Gustavo Colaco. All rights reserved.
//

import UIKit
import CoreData

class CalculationTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var environmentsList: [Environments] = []
//    var array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElement()

    }
    


    @IBAction func addEnvironment(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Informe o nome do ambiente a ser adicionado", message: "", preferredStyle: .alert)
        let add = UIAlertAction(title: "Adicionar", style: .default) { (action) in
           self.addElement(textField: textField)
        }
        
        let cancel = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Ex.: Sala"
            textField = alertTextField
        }
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //add a new environment into the environmentsList and save it in core data database
    func addElement(textField: UITextField) {
        let newEnvironment = Environments(context: self.context)
        newEnvironment.name = textField.text
        self.environmentsList.append(newEnvironment)
        
        do{
            try self.context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }
    
    //load the elements in environmetsList, and show it in our tableview
    func loadElement() {
        let request : NSFetchRequest<Environments> = Environments.fetchRequest()
        
        do {
            environmentsList = try context.fetch(request)
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return environmentsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calculationCell", for: indexPath)
        
        cell.textLabel?.text = environmentsList[indexPath.row].name
        
        return cell
    }
 
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
