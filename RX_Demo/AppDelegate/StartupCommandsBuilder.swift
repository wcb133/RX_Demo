//
//  StartupCommandsBuilder.swift
//  RX_Demo
//
//  Created by Weicb on 2022/1/14.
//  Copyright © 2022 fst. All rights reserved.
//

import UIKit

final class StartupCommandsBuilder {
    private var window: UIWindow!

    func setKeyWindow(_ window: UIWindow) -> StartupCommandsBuilder {
        self.window = window
        return self
    }

    func build() -> [Command] {
        return [
            InitializeThirdPartiesCommand(),
            InitialViewControllerCommand(keyWindow: window),
            InitializeAppearanceCommand(),
            RegisterToRemoteNotificationsCommand()
        ]
    }
}
