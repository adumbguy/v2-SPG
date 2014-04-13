function love.load()

	imgcurser = love.graphics.newImage("textures/curser.png")

	state = not
	love.mouse.setVisible(state)

	
--Setting Image Quads, for tile based drawing I will be using 48x48 tile sets (24x24 Tiles)
	Tileset1 = love.graphics.newImage("textures/tileset2.png")
	tileW, tileH = 32,32
	tilesetW, tilesetH = Tileset1:getWidth(), Tileset1:getHeight()
	Quads = {}
		Quads[1] = love.graphics.newQuad(0,0, tileW, tileH, tilesetW, tilesetH) --Grass
		Quads[2] = love.graphics.newQuad(32, 0, tileW, tileH, tilesetW, tilesetH) --Big Rocks
		Quads[3] = love.graphics.newQuad(0, 32, tileW, tileH, tilesetW, tilesetH) --Flowers
		Quads[4] = love.graphics.newQuad(32,32, tileW, tileH, tilesetW, tilesetH) --Lil' Rocks
		Quads[5] = love.graphics.newQuad(64,0, tileW, tileH, tilesetW, tilesetH) --Big Rocks II
		Quads[6] = love.graphics.newQuad(64,32, tileW, tileH, tilesetW, tilesetH) --Shrubs
		Quads[7] = love.graphics.newQuad(96,0, tileW, tileH, tilesetW, tilesetH)
		Quads[8] = love.graphics.newQuad(96,32, tileW, tileH, tilesetW, tilesetH) --Lil' Grass
	Tiletable ={
	{ 4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4 },
	{ 4,1,1,1,1,1,1,1,1,1,1,6,1,1,1,1,1,1,1,1,1,1,3,1,4 },
	{ 4,1,3,1,1,1,1,1,6,1,1,1,1,1,1,3,1,1,6,1,1,1,1,1,4 },
	{ 4,1,1,1,1,6,1,1,2,1,1,2,1,1,6,1,1,1,1,6,1,1,1,6,4 },
	{ 4,1,6,1,1,1,1,8,1,1,1,1,1,1,1,1,6,1,1,1,1,1,1,1,4 },
	{ 4,1,1,4,1,6,1,1,1,2,2,1,1,4,1,1,1,4,1,4,2,2,1,1,4 },
	{ 4,1,1,4,6,1,8,1,4,3,3,4,1,2,1,1,1,2,1,4,1,1,1,1,4 },
	{ 4,6,1,4,1,1,1,1,4,3,3,4,5,7,4,1,4,1,1,4,2,2,1,1,4 },
	{ 4,1,1,4,1,1,8,1,4,3,3,4,6,8,2,1,2,1,1,4,1,1,1,1,4 },           
	{ 4,6,1,4,1,1,1,1,2,3,3,2,1,1,1,4,1,1,1,4,1,1,1,1,4 },
	{ 4,1,1,2,2,2,2,1,8,2,2,1,1,8,1,2,1,3,1,2,2,2,1,1,4 },
	{ 4,1,1,1,1,8,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,4 },
	{ 4,1,6,1,1,6,1,8,1,2,1,1,1,1,4,4,4,1,1,1,1,6,1,1,4 },
	{ 4,1,1,1,1,1,8,1,4,3,4,1,1,1,4,1,4,1,1,6,1,1,1,1,4 },
	{ 4,1,8,3,1,1,1,1,4,3,4,1,8,1,1,4,1,1,1,1,1,1,1,1,4 },
	{ 4,1,1,1,1,6,1,8,1,4,1,1,2,1,4,1,1,6,1,1,1,1,3,1,4 },
	{ 4,1,8,1,1,1,1,1,1,6,1,1,1,1,6,1,1,1,1,1,1,1,1,1,4 },
	{ 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2 }
	}
	
--Physics engine stuff form here on
	love.physics.setMeter(64) --sets distance for one meter
	world = love.physics.newWorld(0, 9.81*64, true) --xgrav, ygrav(m/s/s * what you made your meter distance), then just true
	objects = {}
	
		objects.wallr = {}
		objects.wallr.body = love.physics.newBody(world, 800, 600/2)
		objects.wallr.shape = love.physics.newRectangleShape(25, 800)
		objects.wallr.fixture = love.physics.newFixture(objects.wallr.body, objects.wallr.shape)
		objects.wallr.fixture:setRestitution(0)
		
		objects.walll = {}
		objects.walll.body = love.physics.newBody(world, 0, 600/2)
		objects.walll.shape = love.physics.newRectangleShape(25, 800)
		objects.walll.fixture = love.physics.newFixture(objects.walll.body, objects.walll.shape)
		objects.walll.fixture:setRestitution(0)

		objects.ceiling = {}
		objects.ceiling.body = love.physics.newBody(world, 800/2, 0)
		objects.ceiling.shape = love.physics.newRectangleShape(800, 25)
		objects.ceiling.fixture = love.physics.newFixture(objects.ceiling.body, objects.ceiling.shape)
		objects.ceiling.fixture:setRestitution(0)

		objects.ground = {}
		objects.ground.body = love.physics.newBody(world, 800/2, 600)
		objects.ground.shape = love.physics.newRectangleShape(800, 25)
		objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
		objects.ground.fixture:setRestitution(0)
		
		objects.dasblock = {}
		objects.dasblock.body = love.physics.newBody(world, 800/2 + 100, 600-200, "dynamic")
		objects.dasblock.shape = love.physics.newRectangleShape(20,20)
		objects.dasblock.fixture = love.physics.newFixture(objects.dasblock.body, objects.dasblock.shape, 1)
		objects.dasblock.fixture:setRestitution(0)
	
end
	
function loadmap()

	

end

function love.draw()
	
	--[[love.graphics.setColor(6,15,150,255)
	love.graphics.polygon("fill", objects.dasblock.body:getWorldPoints(objects.dasblock.shape:getPoints()))]]
	
	love.graphics.setColor(255,255,255)
	for rowIndex=1, #Tiletable do
		local row = Tiletable[rowIndex]
		for columnIndex=1, #row do
			local number = row[columnIndex]
			love.graphics.draw(Tileset1, Quads[number], (columnIndex-1)*tileW, (rowIndex-1)*tileH)
		end
	end
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(imgcurser, x, y) --the curser
	
end

function love.update(dt)
	world:update(dt)

		
 x = love.mouse.getX()
 y = love.mouse.getY()

	
	if love.mouse.isDown("l") then
		print("x pos:", x)
		print("y pos:", y)
	end
end

function love.keypressed(key)

end

function love.focus(bool)
	if not bool then
		print("Unfocused")
	else
		print("Focused")
	end
end

function love.quit()
	
end