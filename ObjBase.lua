
local _NOOP = function () end

local ObjBase = Class.new {
	persistent = false,
	world = function () return Game.world end,
	type = "ObjBase",

	-- overridable methods
	create = _NOOP,
	draw = _NOOP,
	onCollide = _NOOP,
	postCollide = _NOOP,
}


function ObjBase:addModule( newModule )
	if not self.modules then self.modules = {} end
	if not self.allFuncts then self.allFuncts = {} end
	if not self.overRideFuncts then
		self.overRideFuncts = {"create","tick","destroy"}
	end

	local modName = newModule.type

	if newModule.dependencies then
		for i,v in ipairs(newModule.dependencies) do
			if not self:hasModule(v) then
				lume.trace("module: ",v,"added through dependency to module: ", modName)
				local dependencyPath = "modules." .. v
				self:addModule(require(dependencyPath))
			end
		end
	end

	if newModule.trackFunctions then
		for i,v in ipairs(newModule.trackFunctions) do
			if not self.allFuncts[v] then
				self:trackFunction(v)
			end
		end
	end

	for i,v in ipairs(self.overRideFuncts) do
		if newModule[v] then
			if not self.allFuncts[v] then
				self.allFuncts[v] = {}
			end
			self.allFuncts[v][modName] = newModule[v]
		end
	end
	if newModule.create then
		newModule.create(self)
	end
	if newModule.onRemove then
		self.allFuncts["onRemove"][modName] = newModule.onRemove
	end

	Class.include(self,newModule)
	for i,v in ipairs(self.overRideFuncts) do
		local function iterateFunctions( self, ... )
			for k,funct in pairs(self.allFuncts[v]) do
				funct(self,...)
			end
		end
		--local funct = lume.fn(iterateFunctions, self)
		self[v] = iterateFunctions
	end
	self.modules[modName] = true
end

function ObjBase:hasModule( modName )
	return self.modules[modName]
end

function ObjBase:removeModule(modName )
	if self.allFuncts["onRemove"][modName] then
		self.allFuncts["onRemove"][modName](self)
	end
	for i,v in ipairs(self.allFuncts) do
		v[modName] = nil
	end
end

function ObjBase:getModules()
	return self.modules
end

function ObjBase:trackFunction( functionName )
	table.insert(self.overRideFuncts,functionName)
	if self[functionName] and self[functionName] ~= _NOOP then
		if not self.allFuncts[functionName] then 
			self.allFuncts[functionName] = {}
		end
		self.allFuncts[functionName]["default"] = self[functionName]
	end

	local function iterateFunctions( self, ... )
		for k,funct in pairs(self.allFuncts[functionName]) do
			funct(self,...)
		end
	end
	--local funct = lume.fn(iterateFunctions, self)
	self[functionName] = iterateFunctions
end

return ObjBase

