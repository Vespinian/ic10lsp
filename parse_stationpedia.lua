local json = vim.fn.json_decode(vim.fn.readfile("./Stationpedia.json"))

local prefabs = {}
for _, value in pairs(json.pages) do
	if value.PrefabName ~= nil and value.PrefabHash ~= nil then
		table.insert(prefabs, value.PrefabHash .. " " .. value.PrefabName)
	end
end
table.sort(prefabs)
-- print(vim.inspect(logictypes))
vim.fn.writefile(prefabs, "generated/stationpedia.txt")

local instruction = {}
local instructiondocs = {}
for index, value in pairs(json.scriptCommands) do
	local signature = '    "' .. index .. '" => InstructionSignature(&['
	local ins_example = {}
	-- vimscript equivalent s/<[^>]*.//g
	local example = value.example:gsub("%<[^>]*.", "")
	for substring in example:gmatch("%S+") do
		table.insert(ins_example, substring)
	end
	for i, v in pairs(ins_example) do
		if i ~= 1 then
			if i ~= 2 then
				signature = signature .. ", "
			end
			if v == "r?" then
				-- print("REGISTER")
				signature = signature .. "REGISTER"
			elseif v == "str" then
				-- print("NAME")
				signature = signature .. "NAME"
			elseif v == "num" then
				-- print("NUMBER")
				signature = signature .. "NUMBER"
			elseif v == "int" then
				-- print("INT")
				signature = signature .. "INT"
			elseif v == "d?" then
				-- print("DEVICE_IDENTIFIER")
				signature = signature .. "DEVICE_IDENTIFIER"
			elseif v == "batchMode" then
				-- print("BATCH_MODE")
				signature = signature .. "BATCH_MODE"
			elseif v == "nameHash" then
				-- print("NAME_HASH")
				signature = signature .. "NAME_HASH"
			elseif v == "deviceHash" then
				-- print("NAME_HASH")
				signature = signature .. "DEVICE_HASH"
			elseif v == "r?|d?" then
				-- print("VALUE")
				signature = signature .. "VALUE"
			elseif string.find(v, "reagentHash") then
				-- print("REAGENT_HASH")
				signature = signature .. "REAGENT_HASH"
			elseif string.find(v, "device") then
				-- print("DEVICE")
				signature = signature .. "DEVICE"
			elseif string.find(v, "id") then
				-- print("ID")
				signature = signature .. "ID"
			elseif string.find(v, "address") then
				-- print("ADDRESS")
				signature = signature .. "ADDRESS"
			elseif string.find(v, "logicType") then
				-- print("LOGIC_TYPE")
				signature = signature .. "LOGIC_TYPE"
			elseif string.find(v, "logicSlotType") then
				-- print("SLOT_LOGIC_TYPE")
				signature = signature .. "SLOT_LOGIC_TYPE"
			elseif string.find(v, "slotIndex") then
				-- print("SLOT_INDEX")
				signature = signature .. "SLOT_INDEX"
			elseif string.find(v, "reagentMode") then
				-- print("REAGENT_MODE")
				signature = signature .. "REAGENT_MODE"
			elseif string.find(v, "value") then
				-- print("VALUE")
				signature = signature .. "VALUE"
			else
				-- print("LETTERED_VALUE")
				signature = signature .. "LETTERED_VALUE"
			end
		end
	end
	signature = signature .. "]),"
	-- print(vim.inspect(ins_example))
	table.insert(instruction, signature)
	table.insert(instructiondocs, '    "' .. index .. '" => "' .. string.gsub(value.desc, "\n", "\r") .. '",')
end
table.sort(instruction)
table.sort(instructiondocs)
table.insert(instruction, 1, "pub(crate) const INSTRUCTIONS: phf::Map<&'static str, InstructionSignature> = phf_map! {")
table.insert(instruction, "};")

table.insert(instructiondocs, 1, "pub(crate) const INSTRUCTION_DOCS: phf::Map<&'static str, &'static str> = phf_map! {")
table.insert(instructiondocs, "};")
vim.fn.writefile(instruction, "generated/instructions.rs")
vim.fn.writefile(instructiondocs, "generated/instructiondocs.rs")
local file = io.open("generated/instructiondocs.rs", "r")
local content = file:read("*a")
file:close()
local file = io.open("generated/instructiondocs.rs", "w")
local content_mod = string.gsub(content, "\r", "\n")
file:write(content_mod)
file:close()
