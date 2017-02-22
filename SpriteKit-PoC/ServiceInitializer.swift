//
//  ServiceInitilizator.swift
//  ShipMovingOnPath
//
//  Created by Eli Pacheco on 2/8/17.
//  Copyright © 2017 example. All rights reserved.
//

import Foundation

protocol Service {
    var serviceName: String { get }
}

protocol ServiceInitializer{
    init?(services: [Service])
}

enum ServiceConstans {
    
    enum ServiceName: String {
        case Drawer = "Drawer"
    }
    
}
