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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var pickerViewSelected: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchAllFirstNames()
        pickerViewSelected.dataSource = self
        pickerViewSelected.delegate = self
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
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return firstNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return firstNames[row].name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func addViewController(_ controller: AddViewController, didFinishAddingName name: String) {
//        let newFirstName = NSManagedObject(entity: entity!, insertInto: context)
//        newFirstName.setValue(nameAdded.text, forKey: "name")
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddViewController
        controller.delegate = self
    }
}

