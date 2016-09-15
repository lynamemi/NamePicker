//
//  AddViewController.swift
//  NamePicker
//
//  Created by Emily Lynam on 9/14/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit; import CoreData

class AddViewController: UIViewController {
//    var firstName = [NSManagedObject]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: AddViewProtocolDelegate?
    var nameLabelToChange = "Add"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameAdded: UITextField!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        // call protocol function - make other view controller the delegate
        if nameLabelToChange == "Add First Name" {
            let firstName = nameAdded.text!
            delegate?.addViewController(self, didFinishAddingFirstName: firstName)
        } else if nameLabelToChange == "Add Last Name" {
            let lastName = nameAdded.text!
            delegate?.addViewController(self, didFinishAddingLastName: lastName)
        } else {
            print("save failed")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameLabelToChange
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
