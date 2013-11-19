Soupalion = {}
Soupalion.logger = require 'logger'
Soupalion.logger:init("engine")
Soupalion.l = Soupalion.logger
function Soupalion.logger:inf(cnme, text)
	print("[" .. cnme .. "] " .. text)
end
function Soupalion.logger:infl(cnme,text)
	print("[" .. cnme .. "] " .. text)
	print()
end
function Soupalion:init(codename,version,visname,author)
	Soupalion.logger:info("Initialisation called")
	Soupalion.codename = codename
	Soupalion.version = version
	Soupalion.name = visname
	Soupalion.author = author
	Soupalion.logger:info("Basic init performed")
	Soupalion.logger:info("Game starting: "..Soupalion.name.." v"..Soupalion.version.." by "..Soupalion.author)
end
return Soupalion
