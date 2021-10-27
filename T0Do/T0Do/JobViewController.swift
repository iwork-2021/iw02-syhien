//
//  JobViewController.swift
//  T0Do
//
//  Created by nju on 2021/10/21.
//

import UIKit

protocol AddJobDelegate {
    func addJob(job: JobToDo)
}

class JobViewController: UIViewController {

    @IBOutlet weak var finishSwitch: UISwitch!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    var addJobDelegate: AddJobDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SaveButton.isEnabled = false
    }
    
    @IBAction func CancelTouched(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "backToT0Do", sender: nil)
    }
    
    @IBAction func SaveTouched(_ sender: UIBarButtonItem) {
        self.addJobDelegate?.addJob(job: JobToDo(title: titleInput.text!, isFinished: finishSwitch.isOn))
        self.performSegue(withIdentifier: "backToT0Do", sender: nil)
//        self.dismiss(animated: true, completion: nil)
    }

}

extension JobViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        SaveButton.isEnabled = !newText.isEmpty
        return true
    }
}
