//
//  PlayAudioViewController.swift
//  Pitch Perfect
//
//  Created by Julian Pile-Spellman on 8/29/15.
//  Copyright (c) 2015 babs. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {
   var receivedAudio:RecordedAudio!
   var audioEngine:AVAudioEngine!
   var audioFile:AVAudioFile!
   
    override func viewDidLoad() {
        super.viewDidLoad()
      // initialize our audioEngine object
      audioEngine = AVAudioEngine()
      audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
   override func viewWillDisappear(animated: Bool) {
      // makes audio transition more fluid
      prepareAudio()
   }

   @IBOutlet weak var slowPlayButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
   @IBAction func playSlow(sender: UIButton) {
      playAudioWithEffect(1, rate: 1/4)
      
   }
   @IBAction func playFast(sender: UIButton) {
      playAudioWithEffect(1, rate: 2)

   }
   
   
   @IBAction func playChipmunk(sender: UIButton) {
      playAudioWithEffect(1000, rate: 1.0)

   }
   
   @IBAction func playDarthvaderAudio(sender: UIButton) {
      playAudioWithEffect(-1000, rate: 1.0)
   }
   
   
   @IBAction func stopButton(sender: UIButton) {
      prepareAudio()
   }
   
   func prepareAudio(){
      audioEngine.stop()
      audioEngine.reset()
   }
   
   
   
   func playAudioWithEffect(audioPitch: Float, rate: Float){
      prepareAudio()
      var audioPlayerNode = AVAudioPlayerNode()
      audioEngine.attachNode(audioPlayerNode)
      
      var changePitchEffect = AVAudioUnitTimePitch()
      changePitchEffect.pitch = audioPitch
      changePitchEffect.rate = rate
      audioEngine.attachNode(changePitchEffect)
      
      audioEngine.connect(audioPlayerNode, to:changePitchEffect, format: nil)
      audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
      
      audioPlayerNode.scheduleFile(audioFile , atTime: nil, completionHandler: nil)
      audioEngine.startAndReturnError(nil)
      
      audioPlayerNode.play()
   }
}
