//
//  MainViewController.swift
//  Tamara Conditioning
//
//  Created by Julien Hebert on 11/12/2017.
//  Copyright © 2017 FutureWorkshops. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    lazy var exercises : [Exercise] = {
        let exercises = [Exercise(title: "Leg Hold", image: #imageLiteral(resourceName: "legHold"), duration: 20.0, color: .purple),
                         Exercise(title: "One Hand Hold", image: #imageLiteral(resourceName: "oneHand"), duration: 20.0, color: .blue),
                         Exercise(title: "Bridge", image: #imageLiteral(resourceName: "bridge"), duration: 20.0, color: .cyan),
                         Exercise(title: "Squat", image: #imageLiteral(resourceName: "squat"), duration: 20.0, color: .green),
                         Exercise(title: "Pike Hold", image: #imageLiteral(resourceName: "pikeHand"), duration: 20.0, color: .yellow),
                         Exercise(title: "Split", image: #imageLiteral(resourceName: "split"), duration: 20.0, color: .orange),
                         Exercise(title: "Box Split", image: #imageLiteral(resourceName: "boxSplit"), duration: 20.0, color: .red)]
        return exercises
    }()
    
    
    @IBOutlet fileprivate weak var tableView: UITableView! {
        didSet {
            if #available(iOS 11.0, *) {
                self.tableView.contentInsetAdjustmentBehavior = .never
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Conditioning"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let indexPath = sender as? IndexPath, let exercieViewController = segue.destination as? ExerciseViewController {
            exercieViewController.exercises = self.exercises
            exercieViewController.currentExercisesIndex = indexPath.row
        }
        
    }
    
}


extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: "OpenExercise", sender: indexPath)
        
    }
    
}

extension MainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let exercise = self.exercises[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = exercise.title
        cell.backgroundColor = exercise.color
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}


