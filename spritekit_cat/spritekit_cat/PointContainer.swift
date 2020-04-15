import SpriteKit

class PointContainer: SKNode {
    let cat = Cat()
    let textPoint1 = SKTexture(imageNamed: "pot1")
    let textPoint2 = SKTexture(imageNamed: "pot2")
    var arrPoint = [EPoint]()
    let startIndex = 40
    var currtIndex = 40
    var isFind = false
    var stepNum = 0
    var arrNext = [Int]()
    
    func onInit(){
        for i in 0...80{
            let point = EPoint(texture: textPoint1)
            let row = Int(i/9)
            let col = i%9
            var gap = 0
            
            if Int(row % 2) == 1 {
                gap = 19
            }else{
                
            }
            let width = Int(textPoint1.size().width)
            let x = col * (width+5) - (9*width)/2 + gap
            let y = row * width -  (9*width)/2
            point.position = CGPoint(x: CGFloat(x), y: CGFloat(y))

            if row == 0 || row == 8 || col == 0 || col == 8 {
                point.isEdge = true
            }
            point.index = i
            point.zPosition = 10
            addChild(point)
            arrPoint.append(point)
        }
        
        
        cat.position = onGetPosition(startIndex)
        cat.zPosition = 20
        addChild(cat)
        
        onData()
        onCreateRed()
    }
    func onData(){
        for point in arrPoint{
            let row = Int( point.index/9 )
            if Int(row % 2) == 1 {
                if point.index - 1 >= 0 && point.index - 1 <= 80{
                    point.aroundPoint.append(point.index - 1)
                }
                if point.index + 9 >= 0 && point.index + 9 <= 80{
                    point.aroundPoint.append(point.index + 9)
                }
                if point.index + 10 >= 0 && point.index + 10 <= 80{
                    point.aroundPoint.append(point.index + 10)
                }
                if point.index + 1 >= 0 && point.index + 1 <= 80{
                    point.aroundPoint.append(point.index + 1)
                }
                if point.index - 8 >= 0 && point.index - 8 <= 80{
                    point.aroundPoint.append(point.index - 8)
                }
                if point.index - 9 >= 0 && point.index - 9 <= 80{
                    point.aroundPoint.append(point.index - 9)
                }
            }
            else{
                if point.index - 1 >= 0 && point.index - 1 <= 80{
                    point.aroundPoint.append(point.index - 1)
                }
                if point.index + 8 >= 0 && point.index + 8 <= 80{
                    point.aroundPoint.append(point.index + 8)
                }
                if point.index + 9 >= 0 && point.index + 9 <= 80{
                    point.aroundPoint.append(point.index + 9)
                }
                if point.index + 1 >= 0 && point.index + 1 <= 80{
                    point.aroundPoint.append(point.index + 1)
                }
                if point.index - 10 >= 0 && point.index - 10 <= 80{
                    point.aroundPoint.append(point.index - 10)
                }
                if point.index - 9 >= 0 && point.index - 9 <= 80{
                    point.aroundPoint.append(point.index - 9)
                }
            }
        }
    }
    
    func onSetRed(_ index: Int) {
        arrPoint[index].type = pointtype.red
        arrPoint[index].texture = textPoint2
    }
    func onCreateRed(){
        for i in 0...8{
            let r1 = Int(arc4random() % 9) + i * 9
            let r2 = Int(arc4random() % 9) + i * 9
            if r1 != startIndex{
                onSetRed(r1)
            }
            if r2 != startIndex{
                onSetRed(r2)
            }
        }
    }
    func onGetPosition(_ index: Int)->CGPoint{
        return CGPoint(x: arrPoint[index].position.x, y: arrPoint[index].position.y)
    }
    func onGetNextPoint(_ index: Int) {
        onSetRed(index)
        for point in arrPoint[currtIndex].aroundPoint{
            if arrPoint[point].isEdge && arrPoint[point].type == pointtype.gray{
                gameReset("You Loss !")
            }
        }
        onResetStep()
        let currPoint = arrPoint[currtIndex]
        currPoint.step = 0
        
        arrNext.append(currtIndex)
        onFind(arrNext)
        
        if !isFind {
            gameReset("You Win !")
        }
    }
    func onResetStep(){
        arrNext = [Int]()
        isFind = false
        for p in arrPoint {
            p.step = 99
            p.prePointIndex = -1
        }
    }
    func onFind(_ arrNext:[Int]){
        if !isFind{
            let arrNext = onGetNexts(arrNext)
            if arrNext.count != 0{
                onFind(arrNext)
            }
        }
    }
    func onGetNexts(_ arrNext:[Int])->[Int]{
        let step = arrPoint[arrNext[0]].step + 1
        var tempPoints = [Int]()
        for nextP in arrNext{
            if isFind{
                break
            }
            for p in arrPoint[nextP].aroundPoint{
                if arrPoint[p].isEdge && arrPoint[p].type == pointtype.gray{
                    isFind = true
                    onGetPrePoint(arrPoint[p])
                    break
                }
                else if ( arrPoint[p].type == pointtype.gray) && (arrPoint[p].step > arrPoint[nextP].step){
                    arrPoint[p].step = step
                    arrPoint[p].prePointIndex = arrPoint[nextP].index
                    if arrPoint[p].index != arrPoint[nextP].prePointIndex{
                        tempPoints.append(p)
                    }
                }
            }
        }
        return tempPoints
    }
    func onGetPrePoint(_ point: EPoint){
        var p2  = point.aroundPoint[0]
        for p in point.aroundPoint{
            if arrPoint[p].step < arrPoint[p2].step{
                p2 = p
            }
        }
        if arrPoint[p2].step == 0{
            cat.position = onGetPosition(point.index)
            self.currtIndex = point.index
        }
        else{
            onGetPrePoint(arrPoint[p2])
        }
    }
    func gameReset(_ result: String){
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Again", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.scene?.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
        for point in arrPoint{
            point.type = pointtype.gray
            point.texture = textPoint1
        }
        cat.position = onGetPosition(startIndex)
        currtIndex = startIndex
        onCreateRed()
        onResetStep()
    }
}


