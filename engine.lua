Soupalion = {}
Soupalion.l = {}
function Soupalion.l:inf(cnme, text)
	print("[" .. cnme .. "] " .. text)
end
function Soupalion.l:infl(cnme,text)
	print("[" .. cnme .. "] " .. text)
	print()
end
function Soupalion:init(codename,version,visname,author)
	Soupalion.l:inf("engine", "Initialisation called")
	Soupalion.codename = codename
	Soupalion.version = version
	Soupalion.name = visname
	Soupalion.author = author
	Soupalion.l:inf("engine", "Basic init performed")
	Soupalion.l:inf("engine", "Game starting: "..Soupalion.name.." v"..Soupalion.version.." by "..Soupalion.author)
end
return Soupalion
