//
//  MainViewTouchHandler.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/28.
//

import UIKit

class TouchHandler {
    
    enum GestureType {
        case tap, longPress, swipe, none
    }

    var startTime: DispatchTime!
    let longPressStandard: Double = 3
    
    func determineGestureType(_ touches: Set<UITouch>, with event: UIEvent?, completed: ((_ type: GestureType)->())?) {
        var type: GestureType = .none

        if let startTime = self.startTime {
            let endTime = DispatchTime.now()
            let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            self.startTime = nil
            
            if timeInterval > longPressStandard {
                type = .longPress
            }
        }
        else {
            self.startTime = DispatchTime.now()
        }
        if let completed = completed {
            completed(type)
        }
    }
}
