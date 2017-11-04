//
//  Wall.swift
//  Tank War Redux
//
//  Created by Keith Davis on 11/3/17.
//  Copyright © 2017 Keith Davis. All rights reserved.
//

import Foundation

class Wall{
    var ws:[Rectangle]
    static let w1=UIImage(named: "tile1.png")!
    static let w2=UIImage(named: "tile2.png")!
    static let w3=UIImage(named: "tile3.png")!
    
    init(){
        ws=[Rectangle(x: 191,y: 0,w: 32,h: 32)]
        ws.append(Rectangle(x: 191,y: 568,w: 32,h: 32))
        ws.append(Rectangle(x: 382,y: 284,w: 32,h: 32))
        ws.append(Rectangle(x: 230,y: 100,w: 128,h: 32))
        ws.append(Rectangle(x: 230,y: 200,w: 128,h: 32))
        ws.append(Rectangle(x: 230,y: 350,w: 128,h: 32))
        ws.append(Rectangle(x: 230,y: 450,w: 128,h: 32))
        ws.append(Rectangle(x: 262,y: 520,w: 64,h: 32))
        ws.append(Rectangle(x: 262,y: 232,w: 32,h: 32))
        ws.append(Rectangle(x: 100,y: 120,w: 32,h: 64))
        ws.append(Rectangle(x: 100,y: 400,w: 32,h: 64))
        ws.append(Rectangle(x: 0,y: 284,w: 64,h: 32))
        ws.append(Rectangle(x: 140,y: 252,w: 32,h: 96))
    }
    
    func draw(_ view:UIView){
        var w:UIImageView
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 191, y: 0, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 191, y: 568, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 382, y: 284, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 230, y: 100, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 262,y: 100, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 294, y: 100, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 326, y: 100, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 230, y: 200, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 262,y: 200, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 294, y: 200, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 326, y: 200, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 230, y: 350, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 262,y: 350, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 294, y: 350, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 326, y: 350, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 230, y: 450, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 262,y: 450, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 294, y: 450, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 326, y: 450, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w3)
        w.frame = CGRect(x: 262, y: 520, width: 64, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 262, y: 232, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 100, y: 120, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 100, y: 152, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 100, y: 400, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w1)
        w.frame = CGRect(x: 100, y: 432, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w3)
        w.frame = CGRect(x: 0, y: 282, width: 64, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 140, y: 252, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 140,y: 284, width: 32, height: 32)
        view.addSubview(w)
        w = UIImageView(image: Wall.w2)
        w.frame = CGRect(x: 140,y: 316, width: 32, height: 32)
        view.addSubview(w)
    }
}
