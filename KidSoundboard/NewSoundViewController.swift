//
//  NewSoundViewController.swift
//  KidSoundboard
//
//  Created by Bryan Robinson on 6/2/15.
//  Copyright (c) 2015 Bryan Robinson. All rights reserved.
//

import UIKit
import AVFoundation

class NewSoundViewController : UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        var pathComponents = [baseString, "MyAudio.m4a"]
        self.audioURL = NSURL.fileURLWithPathComponents(pathComponents)!

        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: audioURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        super.init(coder: aDecoder)
    }
    

    @IBOutlet weak var soundTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder
    var audioURL: NSURL
    var soundListViewController = SoundListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveTapped(sender: AnyObject) {
        // Create a sound object
        var sound = Sound()
        sound.name = self.soundTextField.text!
        sound.URL = self.audioURL
        
        // Add sound to sounds array
        self.soundListViewController.sounds.append(sound)
        
        // Dismiss ViewController
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func recordTapped(sender: AnyObject) {

        var tile = ""
        if self.audioRecorder.recording {
            self.audioRecorder.stop()
            title = "RECORD"
        } else {
            var session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            self.audioRecorder.record()
            title = "Finish Recording"
        }
        
        self.recordButton.setTitle(title, forState: UIControlState.Normal)
    }
}
