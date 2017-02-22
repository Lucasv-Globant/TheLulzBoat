//
//  DrawerProtocol.swift
//  ShipMovingOnPath
//
//  Created by Eli Pacheco on 2/8/17.
//  Copyright © 2017 example. All rights reserved.
//

import Foundation
import UIKit

protocol DrawerProtocol: Service {
    func getPointsFrom(JSONfileName: String) -> [CGPoint]?
    func getPathFromPoints(points: [CGPoint]) -> UIBezierPath
    func loadImagesFromMainBundle(imagesPrefix: String, imagesNumber: Int) -> [CGImage]?
}
