//
//  yelpSetup.swift
//  TApp
//
//  Created by Liam Breen on 5/5/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import CDYelpFusionKit
import UIKit

final class CDYelpFusionKitManager: NSObject {
    
    static let shared = CDYelpFusionKitManager()
    
    var apiClient: CDYelpAPIClient!
    
    func configure() {
        // How to authorize using your clientId and clientSecret
        self.apiClient = CDYelpAPIClient(apiKey: "1Xp_Xhh8BS1cPRSapezeX9WfE7XFKaOw0qkpNQ3cYALypTtLDTSIzstiZ93INtNHqjyZga-TuPkxtG_yCXlHKGHv46VJuAEMlAGRfE-pEXlf8pfVT49sUbGsZ9TtWnYx")
    }
}

