//
//  ShortcutManager.swift
//  ThinkpadAssistant
//
//  Created by Matt on 17.04.20.
//  Copyright © 2020 Matthäus Szturc. All rights reserved.
//

import Foundation
import MASShortcut

struct ShortcutManager {
    
    static let systemPrefsShortcut = MASShortcut(keyCode: kVK_F18, modifierFlags: [])
    static let launchpadShortcut = MASShortcut(keyCode: kVK_F19, modifierFlags: [])
    
    static func register() {
        MASShortcutMonitor.shared()?.register(systemPrefsShortcut, withAction: {
            startApp(withBundleIdentifier: "com.apple.systempreferences")
            })
        
        MASShortcutMonitor.shared()?.register(launchpadShortcut, withAction: {
            startApp(withBundleIdentifier: "com.apple.launchpad.launcher")
        })
        
        
    }
    
    static func unregister() {
        MASShortcutMonitor.shared().unregisterShortcut(systemPrefsShortcut)
    }
    
    private static func startApp(withBundleIdentifier: String){
        
        let focusedApp = NSWorkspace.shared.frontmostApplication?.bundleIdentifier
        
        if(withBundleIdentifier == focusedApp){
            NSRunningApplication.runningApplications(withBundleIdentifier: focusedApp!).first?.hide()
        } else {
            NSWorkspace.shared.launchApplication(withBundleIdentifier: withBundleIdentifier, options: NSWorkspace.LaunchOptions.default, additionalEventParamDescriptor: nil, launchIdentifier: nil)
        }
    }
}