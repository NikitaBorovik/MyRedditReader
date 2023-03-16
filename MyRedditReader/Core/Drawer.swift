//
//  Drawer.swift
//  MyRedditReader
//
//  Created by Никита Боровик on 16.03.2023.
//

import Foundation
import UIKit

class Drawer{
    
    static func drawBookmark(on uiView: UIView){
        uiView.layer.sublayers?.removeAll()
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x:0,y:uiView.bounds.maxY))
        path.addLine(to: CGPoint(x: uiView.bounds.midX, y: uiView.bounds.midY))
        path.addLine(to: CGPoint(x: uiView.bounds.maxX, y: uiView.bounds.maxY))
        path.addLine(to: CGPoint(x: uiView.bounds.maxX, y: 0))
        path.close()
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.yellow.cgColor
        layer.fillColor = UIColor.red.cgColor
        layer.lineWidth = 1.0
        uiView.layer.addSublayer(layer)
    }
}
