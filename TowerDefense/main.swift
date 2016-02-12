//
//  main.swift
//  TowerDefense
//
//  Created by Chris Murphy on 11/30/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import UIKit

private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate) : nil
}

UIApplicationMain(Process.argc, Process.unsafeArgv, nil, delegateClassName())
