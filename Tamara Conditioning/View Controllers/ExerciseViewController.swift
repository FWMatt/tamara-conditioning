//
//  ViewController.swift
//  Tamara Conditioning
//
//  Created by Marc Blasi on 01/06/2017.
//  Copyright © 2017 FutureWorkshops. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    @IBOutlet var nextExerciseButton: UIButton!
    @IBOutlet var exerciseImage: UIImageView!
    @IBOutlet weak var countDownView: IMCCircleProgressView!
    
    var exercises : [Exercise]!
    var currentExercisesIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.showExercise(self.exercises[self.currentExercisesIndex])
        
        self.nextExerciseButton.layer.cornerRadius = self.nextExerciseButton.frame.height/2
    }

    @IBAction func exerciseAction() {
        self.currentExercisesIndex += 1
        if self.currentExercisesIndex < self.exercises.count {
            self.showExercise(self.exercises[self.currentExercisesIndex])
        }
        else {
            self.currentExercisesIndex = 0
            self.showExercise(self.exercises[self.currentExercisesIndex])
//            self.performSegue(withIdentifier: "Done", sender: nil)
        }
    }
    
    func showExercise(_ exercise: Exercise) {
        self.title = exercise.title
        self.nextExerciseButton.isHidden = true
        self.exerciseImage.image = exercise.image
        self.nextExerciseButton.setTitle(exercise.title, for: .normal)
        self.countDownView.setProgress(0.0, animated: false, duration: 0)
        self.countDownView.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(exercise.duration), repeats: false) {[weak self] (_) in
            self?.nextExerciseButton.isHidden = false
            self?.countDownView.isHidden = true
        }
        self.countDownView.setProgress(1.0, animated: true, duration: CGFloat(exercise.duration))
    }
}

