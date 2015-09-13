//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Julian Pile-Spellman on 8/31/15.
//  Copyright (c) 2015 babs. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
   var filePathUrl: NSURL
   var title: String
   
   init (filePathUrl: NSURL, title: String){
      self.filePathUrl = filePathUrl
      self.title = title
   }
}
