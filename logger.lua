logger = {}
function logger:init(name)
	logger.name = name
end
function logger:info(text)
	print("["..logger.name.."] "..text)
end
return logger
