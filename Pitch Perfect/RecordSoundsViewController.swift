//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Julian Pile-Spellman on 8/26/15.
//  Copyright (c) 2015 babs. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

   @IBOutlet weak var recordButton: UIButton!
   @IBOutlet weak var recordingMessage: UILabel!
   @IBOutlet weak var stopButton: UIButton!
   
   
   var audioRecorder:AVAudioRecorder!
   var recordedAudio:RecordedAudio!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()

   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   override func viewWillAppear(animated: Bool) {
      stopButton.hidden = true
      recordButton.enabled = true
      recordingMessage.text = "Press To Record"
   }
   
   @IBAction func recordAudio(sender: UIButton) {
      recordButton.enabled = false
      recordingMessage.text = "Recording in Progress"
      stopButton.hidden = false
      
      // Recording the Audio

      let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
      let recordingName = "my_audio.wav"
      let pathArray = [dirPath, recordingName]
      let filePath = NSURL.fileURLWithPathComponents(pathArray)
      
      var session = AVAudioSession.sharedInstance()
      session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
      
      audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
      // delegate here (audioRecorder's delegate is self, or RecordSoundsViewController)
      audioRecorder.delegate = self
      audioRecorder.meteringEnabled = true;
      audioRecorder.record()
      
   }
   
   func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
      // use if(flag) to make sure that we have successfully recorded audio
      if (flag) {
         // Saving Recorded Audio by calling RecordedAudio class
         recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
         // Perform a Segue
         self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
      }else {
         println ("Audio was not recorded successfully")
         recordButton.enabled = true
         stopButton.hidden = true
         
      }
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if(segue.identifier == "stopRecording"){
         let playAudioVC:PlayAudioViewController = segue.destinationViewController as! PlayAudioViewController
         let data = sender as! RecordedAudio
         playAudioVC.receivedAudio = data
         
         
      }
   }
   
   
   @IBAction func stopAudio(sender: UIButton) {
      audioRecorder.stop()
      // sharing this recording with the other viewController
      var audioSession = AVAudioSession.sharedInstance();
      audioSession.setActive(false, error: nil)
   }


}

