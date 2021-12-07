//
//  DataLayer.swift
//  finalProject
//
//  Created by Seak Yith on 12/3/21.
//

import Foundation
import SQLite
import UIKit
class TemplateExercise{
    var templateName : String
    var allExercises : [Exercise]
    var templateID : Int?

    // initilizer
    init(name: String, id : Int){
        templateName = name
        allExercises = []
        templateID = id
    }
    init(name: String){
        templateName = name
        allExercises = []
    }
}

class Exercise{
    var exerciseName : String
    var weight : Double
    var rep : Int
    var templateID : Int
    var date : Date
    // Initializer
    init(name: String, weight : Double, rep : Int, template : Int){
        self.exerciseName = name
        self.weight = weight
        self.rep = rep
        self.templateID = template
        self.date = Date()
        
    }
    
}




class DatabaseExercise {
    var conn : Connection
    var TemplateTable : Table!
    var idCol : Expression<Int>!
    var nameCol : Expression<String>!
    //var exerciseCol : Expression<String>!
    //Exercise Table
    var ExerciseTable : Table!
    var weightCol : Expression<Double>!
    var repCol : Expression<Int>!
    var exerciseCol1 : Expression<String>!
    var templateIDCol : Expression<Int>!
    
    init() {
            let rootPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let dbPath = rootPath.appendingPathComponent("exercises.sqlite").path
            print("Database location: \(dbPath)")
            conn = try! Connection(dbPath)
            //initializeExerciseTable()
            initializeTemplateTable()
         
    }
    //Tempalte Table
    private func initializeTemplateTable() {
        TemplateTable = Table("Template")
        nameCol = Expression<String>("Name")
        //exerciseCol = Expression<String>("Exercise")
        idCol = Expression<Int>("id")
        let createTable1 = TemplateTable.create(ifNotExists: true){t in
            t.column(idCol, primaryKey: .autoincrement)
             t.column(nameCol)
             //t.column(exerciseCol)
             
         }
        
        ExerciseTable = Table("Exercise")
        exerciseCol1 = Expression<String>("Exercise")
        weightCol = Expression<Double>("weight")
        repCol = Expression<Int>("Rep")
        templateIDCol = Expression<Int>("template_id")
        let createTable = ExerciseTable.create(ifNotExists: true){t in
            t.column(exerciseCol1, unique: true)
            t.column(weightCol)
            t.column(repCol)
            t.column(templateIDCol)
            t.foreignKey(templateIDCol, references: TemplateTable, idCol, delete: .setNull)
        }
        try! conn.run(createTable)
        try! conn.run(createTable1)
     }
    //Exercise Table
//    private func initializeExerciseTable() {
//        ExerciseTable = Table("Exercise")
//        exerciseCol1 = Expression<String>("Exercise")
//        weightCol = Expression<Double>("weight")
//        repCol = Expression<Int>("Rep")
//        templateIDCol = Expression<Int64>("template_id")
//        let createTable = TemplateTable.create(ifNotExists: true){t in
//            t.column(exerciseCol1, unique: true)
//            t.column(weightCol)
//            t.column(repCol)
//            t.column(templateIDCol)
//            t.foreignKey(templateIDCol, references: TemplateTable, idCol, delete: .setNull)
//        }
//        try! conn.run(createTable)
//
//    }

 }
//Creating exercise Repository
class ExerciseRepository {
    var db = DatabaseExercise()
    
    static private var repository : ExerciseRepository!
    
    static func get() -> ExerciseRepository {
        if repository == nil {
            repository = ExerciseRepository()
        }
        return repository
    }
    func createTemplate(template: TemplateExercise){
        let conn = db.conn
        let table = db.TemplateTable!
        //insert to the table
        let insertTable = table.insert(db.nameCol <- template.templateName)
        try! conn.run(insertTable)
    }
    func createExercise(exercise : Exercise){
        let conn = db.conn
        let table = db.ExerciseTable!
        //insert to the table
        let insertTable = table.insert(db.exerciseCol1 <- exercise.exerciseName, db.weightCol <- exercise.weight, db.repCol <- exercise.rep, db.templateIDCol <- (exercise.templateID))
        try! conn.run(insertTable)
    }
    func getTemplate() -> [TemplateExercise]{
        var list = [TemplateExercise]()
        let table = db.TemplateTable!
        let rs = try! db.conn.prepare(table)
        for r in rs {
            try! list.append(TemplateExercise(name: r.get(db.nameCol), id: Int(r.get(db.idCol))))
        }
        return list
    }
    func getExercise() -> [Exercise]{
        var list = [Exercise]()
        let table = db.ExerciseTable!
        let rs = try! db.conn.prepare(table)
        for r in rs {
            try! list.append(Exercise(name: r.get(db.exerciseCol1), weight: r.get(db.weightCol), rep: r.get(db.repCol), template: Int(r.get(db.templateIDCol))))
            
        }
        return list
    }
    func deleteTemplate(template: TemplateExercise){
        let table = db.TemplateTable.filter(db.nameCol == template.templateName)
        try! db.conn.run(table.delete())
    }
    func deleteExercise(exercise: Exercise){
        let table = db.ExerciseTable.filter(db.exerciseCol1 == exercise.exerciseName)
        try! db.conn.run(table.delete())
    }
    func queryByExerciseID(exercise: [Exercise]) -> [Exercise] {
        var list = [Exercise]()
        var table = db.ExerciseTable!
        //let rs = try! db.conn.prepare(table)
        for exercise in exercise {
            table = db.ExerciseTable.filter(db.templateIDCol == exercise.templateID)
            let rs = try! db.conn.prepare(table)
            for r in rs{
                try! list.append(Exercise(name: r.get(db.exerciseCol1), weight: r.get(db.weightCol), rep: r.get(db.repCol), template: Int(r.get(db.templateIDCol))))
        }
            
        
        }
        return list
    }
    func queryByTemplateID(template: TemplateExercise) -> [Exercise] {
        var list = [Exercise]()
        var table = db.ExerciseTable!
        //let rs = try! db.conn.prepare(table)
        table = db.ExerciseTable.filter(db.templateIDCol == (template.templateID)!)
        let rs = try! db.conn.prepare(table)
        for r in rs{
            try! list.append(Exercise(name: r.get(db.exerciseCol1), weight: r.get(db.weightCol), rep: r.get(db.repCol), template: Int(r.get(db.templateIDCol))))
 
       
        }
        return list
    }
}
