//
//  ColorManager.swift
//  MixingColors
//
//  Created by Natalia on 24.05.2024.
//

import UIKit

class ColorManager {
    
    static let shared = ColorManager()
    private init() {}
    
    func mix(colors: [UIColor]) -> UIColor? {
        guard !colors.isEmpty else { return nil }
        
        let numberOfColors = CGFloat(colors.count)
        
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        
        // Раскладываем каждый цвет на компоненты r, g, b, a
        // и находим сумму соответствующих компонентов
        for color in colors {
            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            color.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
            
            r += r1
            g += g1
            b += b1
            a += a1
        }
        
        // Делим сумму соответствующих компонентов на количество, чтобы получить среднее
        r /= numberOfColors
        g /= numberOfColors
        b /= numberOfColors
        a /= numberOfColors
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
