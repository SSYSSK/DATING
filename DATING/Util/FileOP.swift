//
//  FileOP.swift
//  sst-ios-po
//
//  Created by Zal Zhang on 12/27/16.
//  Copyright © 2016 po. All rights reserved.
//

import UIKit

class FileOP: NSObject {
    
    static let fileManager = FileManager.default
    
    static func getFilePath(filePath: String) -> String? {
        var paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        if paths.count > 0 {
            return "\(paths[0])/"+filePath
        }
        return nil
    }
    
    static func fileExistsAtPath(filePath: String) -> Bool {
        return fileManager.fileExists(atPath: getFilePath(filePath: filePath)!)
    }
    
    static func read(filePath: String, inBundle: Bool) -> AnyObject? {
        var physicalFlePath = filePath
        if inBundle {
            physicalFlePath = Bundle.main.path(forResource: filePath, ofType:nil)!
        } else {
            physicalFlePath = getFilePath(filePath: filePath)!
        }
        if fileManager.fileExists(atPath: physicalFlePath) {
            return fileManager.contents(atPath: physicalFlePath) as AnyObject?
        }
        
        return nil
    }
    
    static func readJson(filePath: String, inBundle: Bool = true) -> Dictionary<String, Any>? {
        let data = read(filePath: filePath, inBundle: inBundle)
        if (data != nil) {
            let jsonObject = try? JSONSerialization.jsonObject(with: data as! Data, options:JSONSerialization.ReadingOptions.allowFragments)
            return jsonObject as? Dictionary<String, Any>
        }
        
        return nil
    }
    
    static func write(fileName: String, fileData: NSData, overwrite: Bool) -> Bool {
        let physicalFlePath = getFilePath(filePath: fileName)
        if overwrite || !fileManager.fileExists(atPath: physicalFlePath!) {
            let data = NSMutableData()
            data.append(fileData as Data)
            data.write(toFile: physicalFlePath!, atomically: true)
            return true
        }
        
        return false
    }
    
    @discardableResult
    static func archive(_ fileName: String, object: Any) -> Bool {
        let name = getFilePath(filePath: fileName)!
        return NSKeyedArchiver.archiveRootObject(object, toFile: name)
    }
    
    static func unarchive(_ fileName: String) -> AnyObject? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath(filePath: fileName)!) as AnyObject?
    }
    
    static func fileSize(path: String) -> Double {
        if fileManager.fileExists(atPath: path) {
            var dict = try? fileManager.attributesOfItem(atPath: path)
            if let fileSize = dict![FileAttributeKey.size] as? Int {
                return Double(fileSize) / 1024.0 / 1024.0
            }
        }
        return 0.0
    }
    
    static func folderSize(path: String) -> Double {
        var folderSize = 0.0
        if fileManager.fileExists(atPath: path) {
            let childFiles = fileManager.subpaths(atPath: path)
            for fileName in childFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.appendingPathComponent(fileName)
                folderSize += FileOP.fileSize(path: fileFullPathName)
            }
            return folderSize
        }
        return 0
    }
    
    static func cleanFolder(path: String, complete:()->()) {
        let childFiles = fileManager.subpaths(atPath: path)
        for fileName in childFiles! {
            if fileName == kUserFileName {
                continue
            }
            let tmpPath  = path as NSString
            let fileFullPathName = tmpPath.appendingPathComponent(fileName)
            if fileManager.fileExists(atPath: fileFullPathName) {
                do {
                    try fileManager.removeItem(atPath: fileFullPathName)
                } catch _ {
                    
                }
            }
        }
        complete()
    }

}
