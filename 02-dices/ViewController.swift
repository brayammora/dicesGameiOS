//
//  ViewController.swift
//  02-dices
//
//  Created by Brayam Alberto Mora Arias on 25/02/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageDiceLeft: UIImageView!
    @IBOutlet weak var imageDiceRight: UIImageView!
    
    var randomDiceLeft: Int = 0
    var randomDiceRight: Int = 0
    let diceImages: [String]
    let nFaces: UInt32
    
    required init?(coder aDecoder: NSCoder) {
        self.diceImages = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
        self.nFaces = UInt32(diceImages.count)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func rollPressed(_ sender: UIButton) {
        generateRandomDices()
    }
    
    func generateRandomDices(){
        randomDiceLeft = Int(arc4random_uniform(nFaces))
        randomDiceRight = Int(arc4random_uniform(nFaces))
        let nameImageDiceLeft = diceImages[randomDiceLeft]
        let nameImageDiceRight = diceImages[randomDiceRight]
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseInOut,
                       animations: {
                        self.imageDiceLeft.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(translationX: 100, y: 100)).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/2))
                        
                        self.imageDiceRight.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(translationX: 100, y: -100)).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/2))
                        
                        self.imageDiceLeft.alpha = 0.0
                        self.imageDiceRight.alpha = 0.0
        }) { (completion) in
            self.imageDiceLeft.transform = CGAffineTransform.identity
            self.imageDiceRight.transform = CGAffineTransform.identity
            self.imageDiceLeft.image = UIImage(named: nameImageDiceLeft)
            self.imageDiceRight.image = UIImage(named: nameImageDiceRight)
            self.imageDiceLeft.alpha = 1.0
            self.imageDiceRight.alpha = 1.0
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if (motion == .motionShake) {
            generateRandomDices()
        }
    }
}

