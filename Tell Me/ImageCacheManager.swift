//
//  ImageCacheManager.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-29.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation
import Kingfisher

class ImageCacheManager{
    static let sharedInstance = ImageCacheManager()
    
    let downloader = ImageDownloader(name: "the_downloader")
    let cache = ImageCache(name: "the_cache")
}
