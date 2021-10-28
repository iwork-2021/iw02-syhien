//
//  T0DoTableViewController.swift
//  T0Do
//
//  Created by nju on 2021/10/21.
//

import UIKit

class T0DoTableViewController: UITableViewController, AddJobDelegate, EditJobDelegate {
    func editJob(job: JobToDo, jobIndex: Int) {
        self.jobs[jobIndex] = job
        self.tableView.reloadData()
    }
    
    func addJob(job: JobToDo) {
        self.jobs.append(job)
        self.tableView.reloadData()
    }
    
    func dataFilePath() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return path!.appendingPathComponent("T0DoJobs.json")
    }
    
    func saveAll() {
        do {
            let data = try JSONEncoder().encode(jobs)
            try data.write(to: dataFilePath(), options: .atomic)
        } catch {
            print("Unable to save: \(error.localizedDescription)")
        }
    }
    
    func loadAll() {
        if let data = try? Data(contentsOf: dataFilePath()) {
            do {
                jobs = try JSONDecoder().decode([JobToDo].self, from: data)
            } catch {
                print("Error loading from: \(error.localizedDescription)")
            }
        }
    }
    
    var jobs:[JobToDo] = [
        JobToDo(title: "Eat lunch", isFinished: false),
        JobToDo(title: "iOS homework", isFinished: true),
        JobToDo(title: "movie script", isFinished: false)
    ]
    
    @IBAction func refreshTouched(_ sender: Any) {
        jobs.sort { (joba, jobb) -> Bool in
            return joba.isFinished == false
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.loadAll()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "T0DoCell", for: indexPath) as! T0DoTableViewCell
        let job = jobs[indexPath.row]
        cell.status.text! = job.isFinished ? "✅" : "🥱"
        cell.job.text! = job.title
        cell.backgroundColor = job.isFinished ? .systemGray6 : .none
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        jobs.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let finishAction = UIContextualAction(style: .normal, title: "✅") { (action, view, completionHandler) in
            self.jobs[indexPath.row].isFinished = true
            completionHandler(true)
            self.tableView.reloadData()
        }
        finishAction.backgroundColor = .green
        let unfinishAction = UIContextualAction(style: .normal, title: "🥱") { (action, view, completionHandler) in
            self.jobs[indexPath.row].isFinished = false
            completionHandler(true)
            self.tableView.reloadData()
        }
        unfinishAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [finishAction, unfinishAction])
    }

    @IBAction func unwindToT0Do(segue: UIStoryboardSegue) {
        print("Back to T0Do")
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addJob" {
            let addJobViewController = segue.destination as! JobViewController
            addJobViewController.addJobDelegate = self
        }
        else if segue.identifier == "editJob" {
            let editJobViewController = segue.destination as! JobViewController
            let cell = sender as! T0DoTableViewCell
            let job = JobToDo(title: cell.job.text!, isFinished: cell.status.text! == "✅" ? true : false)
            editJobViewController.jobToEdit = job
            editJobViewController.jobToEditIndex = tableView.indexPath(for: cell)?.row
            editJobViewController.editJobDelegate = self
        }
    }
    

}
