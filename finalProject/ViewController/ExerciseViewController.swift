//
//  ExerciseViewController.swift
//  finalProject
//
//  Created by Seak Yith on 12/4/21.
//

import UIKit
func dateConverter() -> String{
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "MMM dd yyyy"
    let now = dateFormater.string(from: Date())
    return now
}
var templateDB = ExerciseRepository.get()
class ExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var ExerciseTableView: UITableView!
    @IBOutlet var templateName: UILabel!
    @IBOutlet var date: UILabel!
    var template : TemplateExercise!
    var exercise = templateDB.getExercise()

    
    // table view function/properties
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templateDB.queryByTemplateID(template: template).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Templatecell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let name = templateDB.queryByTemplateID(template: template)[indexPath.row]
        cell.textLabel?.text = name.exerciseName
        cell.detailTextLabel?.text = "Set 1: Weight: \(name.weight) Replicate \(name.rep) "
        
   
        return cell
        
    }
    
    //Deleting
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //delete a row from data (an exercise from dB and table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            let removeExercise = templateDB.getExercise()[indexPath.row]
            templateDB.deleteExercise(exercise: removeExercise)
            tableView.endUpdates()
        }
    }
    
    
    
    
    
    
    
    // segue back to Exercise View Detail Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! ExerciseDetailViewController
            destination.template = template
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        date.text = dateConverter()
        templateName.text = template.templateName
        ExerciseTableView.delegate = self
        ExerciseTableView.dataSource = self
        
    }
    
    


}
