//
//  SoundListViewController
//  KidSoundboard
//
//  Created by Bryan Robinson on 6/2/15.
//  Copyright (c) 2015 Bryan Robinson. All rights reserved.
//

import UIKit
import AVFoundation

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    var sounds: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        var soundPath = NSBundle.mainBundle().pathForResource("cough", ofType: "m4a")
        var soundUrl = NSURL.fileURLWithPath(soundPath!)
        
        var sound1 = Sound()
        sound1.name = "Hear a cough"
        sound1.URL = soundUrl!
        
        var sound2 = Sound()
        sound2.name = "Clear throat"
        sound2.URL = soundUrl!
        
        self.sounds.append(sound1)
        self.sounds.append(sound2)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var sound = self.sounds[indexPath.row]
        var cell = UITableViewCell()
        cell.textLabel?.text = sound.name
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var sound = self.sounds[indexPath.row]
        self.audioPlayer = AVAudioPlayer(contentsOfURL: sound.URL, error: nil)
        self.audioPlayer.play()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var newSoundViewController = segue.destinationViewController as! NewSoundViewController
        newSoundViewController.soundListViewController = self
    }
}

