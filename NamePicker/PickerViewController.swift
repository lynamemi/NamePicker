//
//  ViewController.swift
//  NamePicker
//
//  Created by Emily Lynam on 9/14/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit; import CoreData


class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, AddViewProtocolDelegate {
    var firstNames = [First]()
    var lastNames = [Last]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var pickerViewSelected: UIPickerView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBAction func addFirstNamePressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Add", sender: 1)
    }
    @IBAction func addLastNamePressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Add", sender: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchAllFirstNames()
        fetchAllLastNames()
        pickerViewSelected.dataSource = self
        pickerViewSelected.delegate = self
        firstNameLabel.text = firstNames[0].name!
        lastNameLabel.text = lastNames[0].name!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // let firstNameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "First")
        // is the same as:
        // let firstNameRequest = First.fetchRequest()
        do {
            let results = try context.fetch(First.fetchRequest())
            firstNames = results as! [First]
            print(firstNames)
        } catch {
            print("\(error)")
        }
    }*/
    
    func fetchAllFirstNames() {
        let firstNameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "First")
        do {
            let results = try context.fetch(firstNameRequest)
            firstNames = results as! [First]
        } catch {
            print("\(error)")
        }
    }
    
    func fetchAllLastNames() {
        let lastNameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Last")
        do {
            let results = try context.fetch(lastNameRequest)
            lastNames = results as! [Last]
        } catch {
            print("\(error)")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return firstNames.count
        } else {
            return lastNames.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return firstNames[row].name
        } else {
            return lastNames[row].name
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            firstNameLabel.text = firstNames[row].name!
        } else {
            lastNameLabel.text = lastNames[row].name!
        }
    }
    
    func addViewController(_ controller: AddViewController, didFinishAddingFirstName name: String) {
        dismiss(animated: true, completion: nil)
        let newFirstName = NSEntityDescription.insertNewObject(forEntityName: "First", into: context) as NSManagedObject
        do {
            newFirstName.setValue(name, forKey: "name")
            try self.context.save()
            print("Success!")
        } catch {
            print("Error: \(error)")
        }
        fetchAllFirstNames()
        pickerViewSelected.reloadAllComponents()
    }
    
    func addViewController(_ controller: AddViewController, didFinishAddingLastName name: String) {
        //        let newFirstName = NSManagedObject(entity: entity!, insertInto: context)
        //        newFirstName.setValue(nameAdded.text, forKey: "name")
        dismiss(animated: true, completion: nil)
        let newLastName = NSEntityDescription.insertNewObject(forEntityName: "Last", into: context) as NSManagedObject
        do {
            newLastName.setValue(name, forKey: "name")
            try self.context.save()
            print("Success!")
        } catch {
            print("Error: \(error)")
        }
        fetchAllLastNames()
        pickerViewSelected.reloadAllComponents()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddViewController
        controller.delegate = self
        if sender as! Int == 1 {
            controller.nameLabelToChange = "Add First Name"
        } else if sender as! Int == 2 {
            controller.nameLabelToChange = "Add Last Name"
        }
    }
}

