-- Author      : Dolu89
-- Create Date : 8/27/2016 2:04:42 PM

--Functions
function MenuMogs()
	-- Make the menu appear at the cursor: 
	local menu = {}
	for _charMogsK, _charMogsV in pairs(AllMogs) do
		local elemMenuTitle = {text = _charMogsK, isTitle = true}
		table.insert(menu, elemMenuTitle);
		for mogK, mogV in pairs(_charMogsV) do
			local elemMenu = { text = mogV.text, id = mogV.id, func = function()
				SelectedMog:SetText(mogV.text);
				C_Transmog.LoadSources(mogV.sources);
			end }
			table.insert(menu, elemMenu);
		end
	end
	menuFrame = CreateFrame("Frame", "ExampleMenuFrame", OB3SMF1, "UIDropDownMenuTemplate")
	EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU");
end

function ImportData()
	if AllMogs == nil then
		AllMogs = {}
	end
	local name = UnitName("player")
	local realmName = GetRealmName()
	local char = name.."-"..realmName

	local outfitId = C_TransmogCollection.GetOutfits()
	local allCharSources = {}

	for i = 1, table.getn(outfitId) do
		local elemSources = { text = outfitId[i].name, outfitID = outfitId[i].outfitID, charName = char, sources = C_TransmogCollection.GetOutfitSources(outfitId[i].outfitID) }
		table.insert(allCharSources, elemSources);
	end

	AllMogs[char] = allCharSources
	print("OB3S Mog : Import success !")
end


--Events
--On btnImport click
function btnImport_OnClick()
	ImportData()
end

--On btnSelect click
function btnSelectMog_OnClick()
	MenuMogs()
end
