function init()
    m.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"

    m.animTimer = m.top.findNode("testTimer")

    m.numBoids = 10
    m.boidSize = 24
    m.edgeThreshold = m.boidSize * 3

    m.wander = 200
    m.wanderhalf = m.wander / 2
    
    generateBoids()

    ' required for remote button input
    m.top.setFocus(true)

    For i=1 to m.numBoids
        boidNum = StrI(i)
        boidNum = Right(boidNum, boidNum.Len()-1)
        boidAnim = m.top.FindNode("boidPA"+boidNum)
        boidAnim.repeat = false
        boidAnim.control = "start"
    end for

    m.animTimer.control = "start"
    m.animTimer.ObserveField("fire", "updateAnim")

    end function

function updateAnim()

    For i=1 to m.numBoids
        boidNum = StrI(i)
        boidNum = Right(boidNum, boidNum.Len()-1)
        boidPA = m.top.FindNode("boidPA"+boidNum)
        boidAnim = boidPA.getChild(0)
        boidVector = boidAnim.getChild(0)

        centerx = boidVector.keyValue[1][0]
        centery = boidVector.keyValue[1][1]

        newPosx = centerx + Rnd(m.wander) - m.wanderhalf
        newPosy = centery + Rnd(m.wander) - m.wanderhalf

        boidVector.keyValue = [
            boidVector.keyValue[1],
            [newPosx,newPosy]
        ]
    
        boidPA.repeat = false
        boidPA.control = "start"
    end for

end function

function generateBoids() 

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

        ' choose a new position to go to
        newPosx = centerx + Rnd(m.wander) - m.wanderhalf
        newPosy = centery + Rnd(m.wander) - m.wanderhalf

        boidPA = m.top.createChild("ParallelAnimation")
        boidPA.SetFields({"id":"boidPA"+boidNum})

        duration = 1
        
        anim = boidPA.createChild("Animation")
        anim.addFields({"boidNumber":boidNum})
        anim.id = "boidAnim"+boidNum
        anim.duration = duration
        anim.easeFunction = "linear"

        v2dfi = anim.createChild("Vector2DFieldInterpolator")
        v2dfi.id = "boidVector" + boidNum
        v2dfi.key = [0.0,1.0]
        v2dfi.keyValue = [[centerx,centery],[newPosx,newPosy]]
        v2dfi.fieldToInterp = "boid"+boidNum+".translation"
    end for

end function

