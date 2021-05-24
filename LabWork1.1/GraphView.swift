//
//  GraphView.swift
//  LabWork1.1
//
//  Created by Vladislav on 25.04.2021.
//

import Foundation
import UIKit

class GraphView: UIView {
    override func draw(_ rect: CGRect) {
        let centerOfAxis = (x: bounds.width/2, y: bounds.height/2)
        let cursor = UIBezierPath()
        
        cursor.move(to: CGPoint(x: 0, y: centerOfAxis.y))
        cursor.addLine(to: CGPoint(x: bounds.width, y: centerOfAxis.y))
        cursor.close()
        cursor.move(to: CGPoint(x: centerOfAxis.x, y: 0))
        cursor.addLine(to: CGPoint(x: centerOfAxis.x, y: bounds.height))
        cursor.close()
        cursor.move(to: CGPoint(x: centerOfAxis.x - 10, y: 10))
        cursor.addLine(to: CGPoint(x: centerOfAxis.x, y: 0))
        cursor.move(to: CGPoint(x: centerOfAxis.x, y: 0))
        cursor.addLine(to: CGPoint(x: centerOfAxis.x + 10, y: 10))
        cursor.close()
        cursor.move(to: CGPoint(x: bounds.width - 10, y: centerOfAxis.y - 10))
        cursor.addLine(to: CGPoint(x: bounds.width, y: centerOfAxis.y))
        cursor.move(to: CGPoint(x:bounds.width, y: centerOfAxis.y))
        cursor.addLine(to: CGPoint(x: bounds.width - 10, y: centerOfAxis.y + 10))
        cursor.close()
        cursor.move(to: CGPoint(x: centerOfAxis.x + centerOfAxis.x/6, y: centerOfAxis.y - 10))
        cursor.addLine(to: CGPoint(x: centerOfAxis.x + centerOfAxis.x/6, y: centerOfAxis.y + 10))
        cursor.close()
        cursor.move(to: CGPoint(x: centerOfAxis.x - 10, y: centerOfAxis.y - centerOfAxis.y/6))
        cursor.addLine(to: CGPoint(x: centerOfAxis.x + 10, y: centerOfAxis.y - centerOfAxis.y/6))
        cursor.close()
        var color = UIColor.black
        color.setStroke()
        cursor.stroke()
        cursor.lineWidth = 1
        
        let cursorOfGraph = UIBezierPath()
        let part = centerOfAxis.x/6;
        
        cursorOfGraph.move(to: CGPoint(x: 0, y: centerOfAxis.y))
        
        
        for i in stride (from: -6, to: 6, by: 0.01){
            let funcValue = pow(M_E,i)
            cursorOfGraph.addLine(to: CGPoint(x: centerOfAxis.x + part * CGFloat(i), y: centerOfAxis.y - part * CGFloat(funcValue)))
            cursorOfGraph.move(to: CGPoint(x: centerOfAxis.x + part * CGFloat(i), y: centerOfAxis.y - part * CGFloat(funcValue)))
        }
        
        cursorOfGraph.close()
        color = UIColor.blue
        color.setStroke()
        cursorOfGraph.stroke()
        cursorOfGraph.lineWidth = 1
    }
}
