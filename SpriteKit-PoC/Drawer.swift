//
//  Drawer.swift
//  ShipMovingOnPath
//
//  Created by Eli Pacheco on 2/8/17.
//  Copyright © 2017 example. All rights reserved.
//

import Foundation
import UIKit

struct Drawer: DrawerProtocol {
    
    var serviceName: String = ServiceConstans.ServiceName.Drawer.rawValue
    
    func getPointsFrom(JSONfileName: String) -> [CGPoint]? {
        
        let bundle = Bundle.main
        
        guard let path = bundle.path(forResource: JSONfileName, ofType: "json") else {
            return nil
        }
        
        guard let data = NSData(contentsOfFile: path) as? Data else {
            return nil
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data,
                                                           options: JSONSerialization.ReadingOptions.allowFragments) else {
            return nil
        }
        
        guard let nsArrayObject = json as? NSArray,
            let swiftArray = nsArrayObject as? [[CGFloat]]else {
                return nil
        }
        
        let points = swiftArray.map { (pointArray) -> CGPoint in
            return CGPoint(x: pointArray[0], y: pointArray[1])
        }
        
        return points
    }
    
    func getPathFromPoints(points: [CGPoint]) -> UIBezierPath {
        
        let path: UIBezierPath = UIBezierPath()
        guard let startPoint = points.first else {
            return path
        }
        
        path.move(to: startPoint)
        
        for point in points[1 ..< points.count] {
            path.addLine(to: point)
        }
        
        return path
    }
    
    func loadImagesFromMainBundle(imagesPrefix: String, imagesNumber: Int) -> [CGImage]? {
        var images = [CGImage]()
        
        for imageIndex in 0...imagesNumber {
            let imageName = String(format: imagesPrefix, imageIndex)
            guard let path = Bundle.main.path(forResource: imageName, ofType: nil) else { return nil }
            guard let image = UIImage(contentsOfFile: path), let cgImage = image.cgImage else { return nil }
            images.append(cgImage)
        }
        
        return images
    }
    
}
