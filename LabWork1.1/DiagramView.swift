//
//  DiagramView.swift
//  LabWork1.1
//
//  Created by Vladislav on 25.04.2021.
//

import UIKit

class DiagramView: UIView {

    override func draw(_ rect: CGRect) {
        let values = [(value: 0.3, color: UIColor.orange),
                   (value: 0.3, color: UIColor.green),
                   (value: 0.4, color: UIColor.black)]
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        var currAngle:CGFloat = 0

        for i in values {
            let cursor = UIBezierPath()
            cursor.move(to: center)
            cursor.addArc(withCenter: center, radius: bounds.width/2.5, startAngle: currAngle, endAngle: currAngle + (CGFloat.pi * 2 * CGFloat(i.value)), clockwise: true)
            currAngle = currAngle + (CGFloat.pi * 2 * CGFloat(i.value))
            cursor.close()
            let color = i.color
            color.setFill()
            cursor.fill()
        }
        let cursor2 = UIBezierPath()
        cursor2.addArc(withCenter: center, radius: bounds.width/5, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let color = UIColor.white
        color.setFill()
        cursor2.fill()
        
    }

}
