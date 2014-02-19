local Libra = LibStub("Libra")

local addon = Libra:NewAddon(...)

local defaults = {
	global = {
		Characters = {
			["*"] = {}
		}
	}
}

function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("Vortex_SavedInstancesDB", defaults)
	self.ThisCharacter = self.db.global.Characters[DataStore:GetCharacter()]
	self.Characters = self.db.global.Characters
	self:RegisterEvent("UPDATE_INSTANCE_INFO")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
end

function addon:UPDATE_INSTANCE_INFO()
	wipe(self.ThisCharacter)
	
	for i = 1, GetNumSavedInstances() do
		local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, _, isRaid, maxPlayers, difficultyName, maxBosses, defeatedBosses = GetSavedInstanceInfo(i)

		if locked or extended then
			tinsert(self.ThisCharacter, {
				name = instanceName,
				difficulty = difficultyName,
				reset = time() + instanceReset,
				extended = extended or nil,
				link = GetSavedInstanceChatLink(i),
			})
		end
	end
	for i = 1, GetNumSavedWorldBosses() do
		local instanceName, instanceID, instanceReset = GetSavedWorldBossInfo(i)
		tinsert(self.ThisCharacter, {
			name = instanceName,
			difficulty = RAID_INFO_WORLD_BOSS,
			reset = time() + instanceReset,
		})
	end
end

function addon:CHAT_MSG_SYSTEM(message)
	if message == INSTANCE_SAVED then
		RequestRaidInfo()
	end
end