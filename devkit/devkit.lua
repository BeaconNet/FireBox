local sts = [[
	if not FireBox then
		print("Warning")
		print("This is a FireBox Game")
		print("Run this game using the FireBox software")
		return false
	end
	
	shell.run(FireBox.gameDir)
]]

term.setBackgroundColour(colours.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
print("Loading FireBox APIs...")
local apis = fs.list("FireBox/apis")
for k, v in pairs(apis) do
	os.loadAPI("FireBox/apis/"..v)
	print("Loaded "..v)
end
print("Insert a disk to code")
local e, par = os.pullEvent("disk")
if not disk.hasData(par) then
	print("This isn't a disk")
	return
end
sleep(0.1)
term.clear()
term.setCursorPos(1,1)
print("FireBox Developer Kit [DevKit]")
write("Name of the game: ")
local name = read()
write("Version: ")
local version = read()
write("Author: ")
local author = read()
write("Name of the main file to run on disk\n(EXAMPLE: mygame): ")
local run = read()
local f = fs.open(disk.getMountPath(par).."/fireboxlaunch","w")
f.write("run = \""..run.."\"\ngameName = \""..name.."\"\nversionGame = \""..version.."\"\nauthorGame = \""..author.."\"\n")
f.close()
disk.setLabel(par, name.." [FireBox]")
shell.run("/rom/programs/edit", disk.getMountPath(par).."/"..run)
local f = fs.open(disk.getMountPath(par).."/start","w")
f.write(sts)
f.close()
term.clear()
term.setCursorPos(1,1)
print("Run: edit "..disk.getMountPath(par).."/"..run.." to edit the game")
