local _, addon = ...

local SavedInstances = Vortex:NewModule("Saved instances", {
	noSearch = true,
	noSort = true,
})

function SavedInstances:BuildList(character)
	return addon.Characters[character]
end

function SavedInstances:UpdateButton(button, object)
	button.label:SetPoint("TOPLEFT", button.icon, 0, 0)
	button.source:SetPoint("TOPLEFT", button.icon, "LEFT", 2, -2)
	button.label:SetText(object.name)
	-- button.label:SetTextColor(color.r, color.g, color.b)
	button.source:SetText(object.difficulty)
	local expires = object.reset - time()
	if expires > 0 then
		button.info2:SetText(SecondsToTime(expires, true, nil, 3))
		if object.extended then
			button.info:SetText(EXTENDED)
		end
	else
		button.label:SetFormattedText("|cff808080%s|r", object.name)
		button.info2:SetFormattedText("|cff808080%s|r", RAID_INSTANCE_EXPIRES_EXPIRED)
	end
end

-- function SavedInstances:SetupButtons()
	-- for i, button in ipairs(Vortex.scrollFrame.buttons) do
	-- end
-- end

-- function SavedInstances:RestoreButtons()
	-- for i, button in ipairs(Vortex.scrollFrame.buttons) do
	-- end
-- end