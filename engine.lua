Soupalion = {}
Soupalion.logger = {}
Soupalion.l = Soupalion.logger
function Soupalion.logger:inf(cnme, text)
	print("[" .. cnme .. "] " .. text)
end
function Soupalion.logger:infl(cnme,text)
	print("[" .. cnme .. "] " .. text)
	print()
end
function Soupalion:init(codename,version,visname,author)
	Soupalion.logger:inf("engine", "Initialisation called")
	Soupalion.codename = codename
	Soupalion.version = version
	Soupalion.name = visname
	Soupalion.author = author
	Soupalion.logger:inf("engine", "Basic init performed")
	Soupalion.logger:inf("engine", "Game starting: "..Soupalion.name.." v"..Soupalion.version.." by "..Soupalion.author)
end
return Soupalion
