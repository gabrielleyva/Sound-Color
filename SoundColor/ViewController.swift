//
//  ViewController.swift
//  SoundColor
//
//  Created by Gabriel Leyva Merino on 6/6/18.
//  Copyright © 2018 Gabriel Leyva Merino. All rights reserved.
//

import UIKit
import Beethoven
import Pitchy
import SpriteKit

class ViewController: UIViewController {

    lazy var pitchEngine: PitchEngine = { [weak self] in
        let config = Config(estimationStrategy: .yin)
        let pitchEngine = PitchEngine(config: config, delegate: self)
        pitchEngine.levelThreshold = -30.0
        return pitchEngine
        }()
    
    var myParticle = SKEmitterNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testFrame = self.view.frame
        let testView : SKView = SKView(frame: testFrame)
        let myScene = SKScene(size: testFrame.size)
        testView.presentScene(myScene) //sets the present scene
        testView.backgroundColor = UIColor.clear
        testView.scene?.backgroundColor = UIColor.clear
        testView.alpha =  1
        
        self.view.addSubview(testView)
        
        //creates and sets the particle effects
        let path = Bundle.main.path(forResource: "MyParticle", ofType: "sks")
        myParticle = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        myParticle.position = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.width / 2)
        myParticle.name = "rainParticle"
        myParticle.targetNode = testView.scene
        
        testView.scene?.addChild(myParticle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pitchEngine.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //algorithm that changes the color of the particle based on the Chord it listens to
    func offsetColor(pitch: Pitch) -> UIColor {
        let color: UIColor
        let note  =  pitch.note.string
        
        if (note == "F3"){
            color = UIColor.red
        } else if (note == "A#2") {
            color = UIColor.purple
        } else if(note == "B2"){
            color = UIColor.green
        } else if (note == "C3") {
            color = UIColor.cyan
        } else if (note == "D3"){
            color = UIColor.yellow
        } else if (note == "G4"){
            color = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)
        } else if (note == "E3"){
            color = UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1)
        } else if (note == "A2"){
            color =  UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1)
        } else if (note == "D2" ){
            color = UIColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 1)
        } else {
            color = UIColor.white
        }
        return color
    }
}



extension ViewController: PitchEngineDelegate {
    func pitchEngine(_ pitchEngine: PitchEngine, didReceivePitch pitch: Pitch) {
        print(pitch.note.string)
        
        let color = offsetColor(pitch: pitch) //gets the color depending on the frequency
        myParticle.particleColorSequence = nil
        myParticle.particleColorBlendFactor = 1.0
        myParticle.particleColor = color //changes the color
    }
    
    func pitchEngine(_ pitchEngine: PitchEngine, didReceiveError error: Error) {
        print(error)
    }
    
    func pitchEngineWentBelowLevelThreshold(_ pitchEngine: PitchEngine) {
        
    }
    
}
