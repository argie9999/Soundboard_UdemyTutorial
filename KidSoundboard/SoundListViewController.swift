//
//  SoundListViewController
//  KidSoundboard
//
//  Created by Bryan Robinson on 6/2/15.
//  Copyright (c) 2015 Bryan Robinson. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    var sounds: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)


        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Sound")
        self.sounds = context.executeFetchRequest(request, error: nil)! as! [Sound]
        
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
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        var pathComponents = [baseString, sound.url]
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)!
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: audioNSURL, error: nil)
        self.audioPlayer.play()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var newSoundViewController = segue.destinationViewController as! NewSoundViewController
        newSoundViewController.soundListViewController = self
    }
}

