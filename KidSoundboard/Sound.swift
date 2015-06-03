//
//  Sound.swift
//  KidSoundboard
//
//  Created by Bryan Robinson on 6/2/15.
//  Copyright (c) 2015 Bryan Robinson. All rights reserved.
//

import Foundation
import CoreData

class Sound: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var url: String

}
