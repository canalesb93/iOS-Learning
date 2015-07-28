//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Ricardo Canales on 7/26/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // 1 == nought
    // 2 == crosses
    var activePlayer = 1
    var resultsHidden = false
    
    var gameActive = true
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8], [0,4,8],[2,4,6]]
    
    @IBAction func buttonPressed(sender: AnyObject) {

        if gameState[sender.tag] == 0 && gameActive {
            
            var image = UIImage()
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
                image = UIImage(named: "cross.png")!
                activePlayer = 2
            } else {
                image = UIImage(named: "nought.png")!
                activePlayer = 1
            }
            
            sender.setImage(image, forState: .Normal)

            for combination in winningCombinations {
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                    
                    if gameState[combination[0]] == 1{
                        resultLabel.text = "Crosses has won!"
                    } else {
                        resultLabel.text = "Noughts has won!"
                    }
                    
                    showResults()
                    
                    gameActive = false
                    
                }
            }
            
        }
        
    }
    
    @IBAction func restart(sender: AnyObject) {
        restartGame()
    }
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        restartGame()
    }
    
    func restartGame(){
        
        hideResults(false)
        activePlayer = 1
        gameActive = true
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        var button : UIButton
        
        for var i = 0; i < 9; i++ {
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, forState: .Normal)
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        hideResults(false)
//        resultLabel.hidden = true
//        playAgainButton.hidden = true
        
        resultLabel.layer.borderWidth = 2.0
        resultLabel.layer.cornerRadius = 8
        
        resultLabel.transform = offstageLeft
        playAgainButton.transform = offstageLeft


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // setup 2D transitions for animations
    let offstageLeft = CGAffineTransformMakeTranslation(-400, 0)
    let offstageRight = CGAffineTransformMakeTranslation(400, 0)
    
    func hideResults(animated: Bool){

        

        UIView.animateWithDuration(0.5) { () -> Void in
            self.resultLabel.transform = self.offstageLeft
            self.playAgainButton.transform = self.offstageLeft
        }

//                UIView.animateWithDuration(0.5, animations: { () -> Void in
//                    self.resultLabel.center = CGPointMake(-400, self.resultLabel.center.y)
//                    self.playAgainButton.center = CGPointMake(-400, self.playAgainButton.center.y)
//                })
        
    }
    
    // Shows results(label and button)
    func showResults(){
        print("TESTS shouldnt be here")
        resultLabel.hidden = false
        playAgainButton.hidden = false
    

    
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.resultLabel.transform = CGAffineTransformIdentity
            self.playAgainButton.transform = CGAffineTransformIdentity
//                self.resultLabel.center = CGPointMake(self.resultLabel.center.x + 400, self.resultLabel.center.y)
//                
//                self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
        })
    }


}

