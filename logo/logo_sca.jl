using Luxor

@drawsvg begin
setcolor("red")
circle(Point(0, 0), 100, action = :stroke)
text("hello world", halign=:center, valign=:middle)
end

function t()
    move(Point(100, 0))
    line(Point(0, -100))
    line(Point(-100, 0))
    closepath()
    strokepath()
end

function p(n)
    p = ngon(Point(0, 0), 300, n, vertices=true)
    poly(p, action = :stroke, close=true)
end


@drawsvg begin
    origin()
    background("black")
    sethue("white")
    # t()
   for i in [ 3 5 7 9 11 13 17 19]
        p(i)
    end

    translate(-40,20)
    fontsize(50)
    rotate(0.01)
    text("SCA")

   
end 400 400

Drawing(800, 800, "logo_sca.png")
origin()
background("black")
sethue("white")
# t()
for i in [ 3 5 7 9 11 13 17 19]
    p(i)
end

translate(-40,20)
fontsize(50)
rotate(0.01)
text("SCA")
finish()
preview()