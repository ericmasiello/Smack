//
//  UserDataService.swift
//  Smack
//
//  Created by Eric Masiello on 1/27/18.
//  Copyright © 2018 Eric Masiello. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func createUIColor(fromString components: String) -> UIColor {
        // components = "[0.5, 0.5, 0.5, 1]"
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ") // chars to skip in scanner
        let stopAtChar = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        scanner.scanUpToCharacters(from: stopAtChar, into: &r)
        scanner.scanUpToCharacters(from: stopAtChar, into: &g)
        scanner.scanUpToCharacters(from: stopAtChar, into: &b)
        scanner.scanUpToCharacters(from: stopAtChar, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        // if it can't unwrap these values, abort and return the default color
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        return UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
    }
}
