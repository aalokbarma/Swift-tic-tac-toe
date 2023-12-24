//
//  ViewController.swift
//  TicTacToe
//
//  Created by Aalok Barma on 19/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Naught
        case Cross
    }

    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var Board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    func initBoard(){
        Board.append(a1)
        Board.append(a2)
        Board.append(a3)
        Board.append(b1)
        Board.append(b2)
        Board.append(b3)
        Board.append(c1)
        Board.append(c2)
        Board.append(c3)
    }
    
    func fullBoard () -> Bool {
        for button in Board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    var CrossScore = 0
    var NaughtScrore = 0
    

    @IBAction func boardTypeAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS){
            CrossScore += 1
            resultAlert(title: "Cross Wins")
            
        }
        else if checkForVictory(NOUGHT){
            NaughtScrore += 1
            resultAlert(title: "Nought Wins")
            
        }
        
        if (fullBoard()){
            resultAlert(title: "Draw")
        }
    }
    
    func addToBoard (_ sender: UIButton){
        if(sender.title(for: .normal) == nil){
            if(currentTurn == Turn.Naught){
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Naught
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
    func checkForVictory (_ s :String) -> Bool{
//        Condition for Horizontal Victory
        if checkSymbol(a1, s) && checkSymbol(a2, s) && checkSymbol(a3, s){
            return true
        }
        if checkSymbol(b1, s) && checkSymbol(b2, s) && checkSymbol(b3, s){
            return true
        }
        if checkSymbol(c1, s) && checkSymbol(c2, s) && checkSymbol(c3, s){
            return true
        }
//        Condition for Vertical Victory
        if checkSymbol(a1, s) && checkSymbol(b1, s) && checkSymbol(c1, s){
            return true
        }
        if checkSymbol(a2, s) && checkSymbol(b2, s) && checkSymbol(c2, s){
            return true
        }
        if checkSymbol(a3, s) && checkSymbol(b3, s) && checkSymbol(c3, s){
            return true
        }
//        Condition for cross victory
        if checkSymbol(a1, s) && checkSymbol(b2, s) && checkSymbol(c3, s){
            return true
        }
        if checkSymbol(a3, s) && checkSymbol(b2, s) && checkSymbol(c1, s){
            return true
        }
        return false
    }
    
    func checkSymbol(_ button :UIButton, _ symbol : String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert (title: String){
        let message = "\nNaught" + String(NaughtScrore) + "\n\nCrosses" + String(CrossScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard (){
        for button in Board {
            button.setTitle( nil , for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Naught {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross {
            firstTurn = Turn.Naught
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    
}

