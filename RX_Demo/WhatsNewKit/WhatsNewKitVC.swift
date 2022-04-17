//
//  WhatsNewKitVC.swift
//  RX_Demo
//
//  Created by Weicb on 2022/4/16.
//  Copyright © 2022 fst. All rights reserved.
//

import Foundation
import WhatsNewKit

class WhatsNewKitVC: UIViewController {
    // Initialize WhatsNew
    let whatsNew = WhatsNew(// The Title
        title: "WhatsNewKit",
        // The features you want to showcase
        items: [
            WhatsNew.Item(title: "Installation",
                          subtitle: "You can install WhatsNewKit via CocoaPods or Carthage",
                          image: UIImage(named: "icon_dizhi")?.withRenderingMode(.alwaysOriginal)),
            WhatsNew.Item(title: "Open Source",
                          subtitle: "Contributions are very welcome 👨‍💻",
                          image: UIImage(named: "img")?.withRenderingMode(.alwaysOriginal))
        ])

    override func viewDidLoad() {
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Initialize WhatsNewViewController with WhatsNew
            let whatsNewViewController = WhatsNewViewController(
                whatsNew: self.whatsNew
            )
            // Present it 🤩
            self.present(whatsNewViewController, animated: true)
        }
    }

    // 带版本的
    func test1() {
        // Initialize WhatsNewVersionStore
        let versionStore: WhatsNewVersionStore = KeyValueWhatsNewVersionStore()

        // Passing a WhatsNewVersionStore to the initializer
        // will give you an optional WhatsNewViewController
        let whatsNewViewController: WhatsNewViewController? = WhatsNewViewController(whatsNew: whatsNew,
                                                                                     versionStore: versionStore)

        // Verify WhatsNewViewController is available
        guard let viewController = whatsNewViewController else {
            // The user has already seen the WhatsNew-Screen for the current Version of your app
            return
        }

        // Present WhatsNewViewController
        present(viewController, animated: true)
    }
}
