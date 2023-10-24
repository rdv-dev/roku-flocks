function init()
    m.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"

    m.numBoids = 10
    m.boidSize = 24
    m.edgeThreshold = m.boidSize * 3
    
    for i=1 To m.numBoids
        ' Workaround for converting int to string
        boidNum = StrI(i)
        boidNum = Right(boidNum, boidNum.Len()-1)

        ' create a boid
        boid = m.top.createChild("Rectangle")
        boid.id = "boid"+boidNum
        boid.width = m.boidSize
        boid.height = m.boidSize
        boid.scaleRotateCenter = [m.boidSize / 2, m.boidSize / 2]
        boid.rotation = 0.0
        boid.color = "0x1010EBFF"

        ' randomly choose a position
        centerx = Rnd(1280-m.edgeThreshold)
        centery = Rnd(720-m.edgeThreshold)
        boid.translation = [ centerx, centery ]
    end for

    ' required for remote button input
    m.top.setFocus(true)

    end function

