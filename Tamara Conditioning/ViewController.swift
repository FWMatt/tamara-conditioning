//
//  ViewController.swift
//  Tamara Conditioning
//
//  Created by Marc Blasi on 01/06/2017.
//  Copyright © 2017 FutureWorkshops. All rights reserved.
//

import UIKit

struct Exercise {
    var titleButton: String
    var image: UIImage
    var timer: Float
}

class ExerciseViewController: UIViewController {
    
    @IBOutlet var nextExerciseButton: UIButton!
    @IBOutlet var exerciseImage: UIImageView!
    @IBOutlet weak var countDownView: IMCCircleProgressView!
    
    let exercises = [Exercise(titleButton: "Switch Arm", image: #imageLiteral(resourceName: "exercise"), timer: 5), Exercise(titleButton: "Switch Arm", image: #imageLiteral(resourceName: "oneHand"), timer: 5)]
    
    var currentExercisesIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "tamara Conditioning"
        
        self.showExercise(self.exercises[self.currentExercisesIndex])
        
        self.nextExerciseButton.layer.cornerRadius = self.nextExerciseButton.frame.height/2
    }

    @IBAction func exerciseAction() {
        self.currentExercisesIndex += 1
        if self.currentExercisesIndex < self.exercises.count {
            self.showExercise(self.exercises[self.currentExercisesIndex])
        }
        else {
            self.performSegue(withIdentifier: "Done", sender: nil)
        }
    }
    
    func showExercise(_ exercise: Exercise) {
        self.nextExerciseButton.isHidden = true
        self.exerciseImage.image = exercise.image
        self.nextExerciseButton.setTitle(exercise.titleButton, for: .normal)
        self.countDownView.setProgress(0.0, animated: false, duration: 0)
        self.countDownView.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(exercise.timer), repeats: false) {[weak self] (_) in
            self?.nextExerciseButton.isHidden = false
            self?.countDownView.isHidden = true
        }
        self.countDownView.setProgress(1.0, animated: true, duration: CGFloat(exercise.timer))
    }
}

