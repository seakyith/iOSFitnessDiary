//
//  HomeViewController.swift
//  finalProject
//
//  Created by Seak Yith on 12/1/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var TemplateTableView: UITableView!
    var templateArray : [TemplateExercise] = []
    //var template = ExerciseRepository.getTemplate()
    var template = ExerciseRepository.get()
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    // style button
    func stylebutton(button : UIButton, title : String){
        button.configuration = .gray()
        button.configuration?.baseForegroundColor = .systemPink
        button.configuration?.title = title
        button.configuration?.image = UIImage(systemName: "pencil")
        button.configuration?.imagePadding = 10
        //logInButton.configuration?.cornerStyle = .capsule
        
    }
    func createImageArray() -> [UIImage]{
        var tempImages : [UIImage] = []
        var i = 0
        while i < 6 {
            tempImages.append(UIImage(named: "image\(i).jpg")!)
            i += 1
        }
        return tempImages
                          
    }
    
    @IBOutlet var templateName: UITextField!
    
    // add button action
    @IBAction func add(_ sender: UIButton) {
        if let templateName1 = templateName.text{
            let newTemplate = TemplateExercise(name: templateName1)
            template.createTemplate(template: newTemplate)
        }
        templateName.text = ""
        TemplateTableView.reloadData()
    }
    //row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    // segue to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = TemplateTableView.indexPathForSelectedRow?.row{
            let destination = segue.destination as! ExerciseViewController
            let template = template.getTemplate()[row]
            destination.template = template
            
        }
    }
    
    
    // table view for creating main exercise template
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return template.getTemplate().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
        
        let name = template.getTemplate()[indexPath.row]
        cell.textLabel?.text = name.templateName

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTemplateDetail", sender: self)
    }
    
    
    
    //Deleting
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //delete a row from data (a template from dB and table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            let removeTemplate = template.getTemplate()[indexPath.row]
            template.deleteTemplate(template: removeTemplate)
            
            tableView.endUpdates()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TemplateTableView.dataSource = self
        TemplateTableView.delegate = self
        self.stylebutton(button: addButton, title: "Add")
    }


}
