//
//  ExerciseDetailViewController.swift
//  finalProject
//
//  Created by Seak Yith on 12/4/21.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet var exerciseNameField: UITextField!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var replicateField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var template : TemplateExercise!
    var exerciseData = ExerciseRepository.get()
    var exercise : Exercise!
    
    //style button
    func stylebutton(button : UIButton, title : String){
        button.configuration = .gray()
        button.configuration?.baseForegroundColor = .systemPink
        button.configuration?.title = title
        button.configuration?.image = UIImage(systemName: "pencil")
        button.configuration?.imagePadding = 10
        //logInButton.configuration?.cornerStyle = .capsule
        
    }
    
    // Add exercise function and stored to database
    @IBAction func addExercise(_ sender: UIButton) {
        let exerName = exerciseNameField.text!
        let weight = (Double(weightField.text!))!
        let rep = (Int(replicateField.text!))!
        exercise = Exercise(name: exerName, weight: weight, rep: rep, template: template.templateID!)
        exerciseData.createExercise(exercise: exercise)
        
    }
    
    // segue back to Exercise View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! ExerciseViewController
            destination.template = template
            //destination.exercise = exercise
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stylebutton(button: addButton, title: "Add")
        // Do any additional setup after loading the view.
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
