//
//  UNSwiftyUD.swift
//  UNSwiftyUD
//
//  Created by Wataru Nishimoto on 2016/7/9.
//  Copyright © 2016 Wataru Nishimoto. All rights reserved.
//

import Foundation

class UDBase: NSObject {
    override init() {
        super.init()
        Mirror(reflecting: self).children.forEach { child in
            if let label = child.label {
                #if swift(>=3.0)
                    if let object = ud.object(forKey: path(label: label)) {
                        setValue(object, forKey:  actualPath(label: label))
                    }
                    addObserver(self, forKeyPath: actualPath(label: label), options: [.new, .old], context: nil)
                    ud.addObserver(self, forKeyPath: path(label: label), options: [.new, .old], context: nil)
                #else
                    if let object = ud.objectForKey(path(label)) {
                        setValue(object, forKey:  actualPath(label))
                    }
                    addObserver(self, forKeyPath: actualPath(label), options: [.New, .Old], context: nil)
                    ud.addObserver(self, forKeyPath: path(label), options: [.New, .Old], context: nil)
                #endif
            }
        }
    }

    deinit {
        Mirror(reflecting: self).children.forEach { child in
            if let label = child.label {
                #if swift(>=3.0)
                    removeObserver(self, forKeyPath: actualPath(label: label))
                    ud.removeObserver(self, forKeyPath: path(label: label))
                #else
                    removeObserver(self, forKeyPath: actualPath(label))
                    ud.removeObserver(self, forKeyPath: path(label))
                #endif
            }
        }
    }
    #if swift(>=3.0)
        override func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [NSKeyValueChangeKey : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
            if let keyPath = keyPath,
                change = change,
                newValue = change["new" as NSKeyValueChangeKey],
                oldValue = change["old" as NSKeyValueChangeKey]  where !newValue.isEqual(oldValue) {
                setValue(newValue, forKey: actualPath(label: keyPath))
                ud.set(newValue, forKey: path(label: keyPath) )
                ud.synchronize()
            }
        }
    #else
        override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
            if let keyPath = keyPath,
                change = change,
                newValue = change["new"],
                oldValue = change["old"]  where !newValue.isEqual(oldValue) {
                setValue(newValue, forKey: actualPath(keyPath))
                ud.setObject(newValue, forKey: path(keyPath))
                ud.synchronize()
            }
        }
    #endif
}

private extension UDBase {
    #if swift(>=3.0)
        var ud: UserDefaults {
            return UserDefaults.standard
        }

        func path(label: String) -> String {
            return "\(self.dynamicType)-" + actualPath(label: label)
        }

        func actualPath(label: String) -> String {
            return label.replacingOccurrences(of: "\(self.dynamicType)-", with: "")
        }
    #else
        var ud: NSUserDefaults {
            return NSUserDefaults.standardUserDefaults()
        }

        func path(label: String) -> String {
            return "\(self.dynamicType)-" + actualPath(label)
        }

        func actualPath(label: String) -> String {
            return label.stringByReplacingOccurrencesOfString("\(self.dynamicType)-", withString: "")
        }
    #endif
}
