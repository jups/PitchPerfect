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
   var audioPlayer: AVAudioPlayer!
   var receivedAudio:RecordedAudio!
   var audioEngine:AVAudioEngine!
   var audioFile:AVAudioFile!
   
   
   
   func setupAudio(rate:Float) {
      audioPlayer.stop()
      audioPlayer.currentTime = 0
      audioPlayer.rate = rate
      audioPlayer.play()
   }
    override func viewDidLoad() {
        super.viewDidLoad()
//      if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//         let filePathURL = NSURL.fileURLWithPath(filePath)
//         audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
//         audioPlayer.enableRate = true
//         
//      }
//      else {
//         println("filePath for movie_quote is empty")
//      }
      
      audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
      audioPlayer.enableRate = true
      
      // initialize our audioEngine object
      audioEngine = AVAudioEngine()
      audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
      
      
    }

   @IBOutlet weak var slowPlayButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @IBAction func playSlow(sender: UIButton) {
      println ("playSlow")
      setupAudio(0.5)


      
   }
   @IBAction func playFast(sender: UIButton) {
      println ("playFast")
      setupAudio(1.5)

   }
   
   
   @IBAction func playChipmunk(sender: UIButton) {
      println ("playChipmunk")
      playAudioWithVariablePitch(1000)

   }
   
   func playAudioWithVariablePitch(pitch: Float){
      audioPlayer.stop()
      audioEngine.stop()
      audioEngine.reset()
      
      var audioPlayerNode = AVAudioPlayerNode()
      audioEngine.attachNode(audioPlayerNode)
      
      var changePitchEffect = AVAudioUnitTimePitch()
      changePitchEffect.pitch = pitch
      audioEngine.attachNode(changePitchEffect)
      
      audioEngine.connect(audioPlayerNode, to:changePitchEffect, format: nil)
      audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
      
      audioPlayerNode.scheduleFile(audioFile , atTime: nil, completionHandler: nil)
      audioEngine.startAndReturnError(nil)
      
      audioPlayerNode.play()
   }
   
   @IBAction func playDarthvaderAudio(sender: UIButton) {
      playAudioWithVariablePitch(-1000)
   }
   
   @IBAction func stopButton(sender: UIButton) {
      audioPlayer.stop()
      audioEngine.stop()
      audioEngine.reset()
   }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
