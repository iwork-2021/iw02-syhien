//
//  JobViewController.swift
//  T0Do
//
//  Created by nju on 2021/10/21.
//

import UIKit

class JobViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelTouched(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "backToT0Do", sender: nil)
    }
    
    @IBAction func SaveTouched(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "backToT0Do", sender: nil)
//        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
