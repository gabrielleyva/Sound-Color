//
//  ViewController.swift
//  Sound Color
//
//  Created by Gabriel I Leyva Merino on 4/18/16.
//  Copyright © 2016 Gabriel Leyva Merino. All rights reserved.
//

import UIKit
import Beethoven
import Pitchy
import SpriteKit



class ViewController: UIViewController {
    
    lazy var pitchEngine: PitchEngine = { [unowned self] in
        let pitchEngine = PitchEngine(delegate: self)
        return pitchEngine
        }()
    
    var myParticle = SKEmitterNode()
    
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let testFrame = self.view.frame //frame size 
        
       
        let testView : SKView = SKView(frame: testFrame)//creates a SkView object
        let myScene = SKScene(size: testFrame.size)//creates an SKScene
      
        testView.presentScene(myScene) //sets the present scene
        
        //setting up the view
        testView.backgroundColor = UIColor.clearColor()
        testView.scene?.backgroundColor = UIColor.clearColor()
        testView.alpha =  1
        self.view.addSubview(testView)
        
        let path = NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks") //sets path emitter file
        
        //creates and sets the particle effects
        myParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        myParticle.position = CGPointMake(self.view.frame.width / 2, self.view.frame.width / 2)
        myParticle.name = "rainParticle"
        myParticle.targetNode = testView.scene
        print(myParticle)
        testView.scene?.addChild(myParticle)
        
        transView.alpha = 0.5 //make a view translucent
        
        //title label of the app
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.whiteColor().CGColor
        titleLabel.layer.cornerRadius = 5
        titleLabel.textColor = UIColor.whiteColor()
        
        
        pitchEngine.start() //starts listening to the music
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - UI
    
    //algorithm that changes the color of the particle based on the Chord it listens to
    func offsetColor(pitch: Pitch) -> UIColor {
        let color: UIColor
        let note  =  pitch.note.string
        
     if (note == "F3"){
    
    color = UIColor.redColor()
    
    } else if (note == "A#2") {
    
    color = UIColor.purpleColor()
    
    } else if(note == "B2"){
    
    color = UIColor.greenColor()
    
    
    } else if (note == "C3") {
    
    color = UIColor.cyanColor()
    
    } else if (note == "D3"){
    
    color = UIColor.yellowColor()
    
    } else if (note == "G4"){
    
    color = UIColor(colorLiteralRed: 0, green: 255, blue: 0, alpha: 1)
    
    } else if (note == "E3"){
        
    color = UIColor(colorLiteralRed: 135, green: 206, blue: 250, alpha: 1)
    
    } else if (note == "A2"){
        
    color = UIColor(colorLiteralRed: 255, green: 165, blue: 0, alpha: 1)
    
    } else if (note == "D2" ){
        
        
    color = UIColor(colorLiteralRed: 255, green: 20, blue: 147, alpha: 1)
    
    } else {
    
    color = UIColor.whiteColor()
    }

    
        return color
    }
}


    // MARK: - PitchEngineDelegate8

extension ViewController: PitchEngineDelegate {
    
        func pitchEngineDidRecievePitch(pitchEngine: PitchEngine, pitch: Pitch) {
            print(pitch.note.string)
            
            
            let color = offsetColor(pitch) //gets the color depending on the frequency
            myParticle.particleColorSequence = nil
            myParticle.particleColorBlendFactor = 1.0
            myParticle.particleColor = color //changes the color
            
     
        }
    
    
        //error in the pitch 
        func pitchEngineDidRecieveError(pitchEngine: PitchEngine, error: ErrorType) {
            print(error)
        }
    }

 


