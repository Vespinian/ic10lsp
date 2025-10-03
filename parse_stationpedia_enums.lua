local json = vim.fn.json_decode(vim.fn.readfile("./Enums.json"))

local logictypes = {}
local logictypesdocs = {}
for index, value in pairs(json.scriptEnums.LogicType.values) do
	table.insert(logictypes, '    "' .. index .. '",')
	table.insert(logictypesdocs, '    "' .. index .. '" => "' .. string.gsub(value.description, "\n", "\r") .. '",')
end
table.sort(logictypes)
table.sort(logictypesdocs)
table.insert(logictypes, 1, "pub(crate) const LOGIC_TYPES: phf::Set<&'static str> = phf_set! {")
table.insert(logictypes, "};")
table.insert(logictypesdocs, 1, "pub(crate) const LOGIC_TYPE_DOCS: phf::Map<&'static str, &'static str> = phf_map! {")
table.insert(logictypesdocs, "};")
-- print(vim.inspect(logictypes))
vim.fn.writefile(logictypes, "generated/logictypes.rs")
vim.fn.writefile(logictypesdocs, "generated/logictypesdocs.rs")
local file = io.open("generated/logictypesdocs.rs", "r")
local content = file:read("*a")
file:close()
local file = io.open("generated/logictypesdocs.rs", "w")
local content_mod = string.gsub(content, "\r", "\n")
file:write(content_mod)
file:close()

local slotlogictypes = {}
local slotlogictypesdocs = {}
for index, value in pairs(json.scriptEnums.LogicSlotType.values) do
	table.insert(slotlogictypes, '    "' .. index .. '",')
	table.insert(slotlogictypesdocs, '    "' .. index .. '" => "' .. string.gsub(value.description, "\n", "\r") .. '",')
end
table.sort(slotlogictypes)
table.sort(slotlogictypesdocs)
table.insert(slotlogictypes, 1, "pub(crate) const SLOT_LOGIC_TYPES: phf::Set<&'static str> = phf_set! {")

table.insert(slotlogictypes, "};")
table.insert(
	slotlogictypesdocs,
	1,
	"pub(crate) const SLOT_TYPE_DOCS: phf::Map<&'static str, &'static str> = phf_map! {"
)
table.insert(slotlogictypesdocs, "};")
-- print(vim.inspect(slotlogictypes))
vim.fn.writefile(slotlogictypes, "generated/slotlogictypes.rs")
vim.fn.writefile(slotlogictypesdocs, "generated/slotlogictypesdocs.rs")
local file = io.open("generated/slotlogictypesdocs.rs", "r")
local content = file:read("*a")
file:close()
local file = io.open("generated/slotlogictypesdocs.rs", "w")
local content_mod = string.gsub(content, "\r", "\n")
file:write(content_mod)
file:close()

-- local reagentmodes = {}
-- for index, _ in pairs(json.scriptEnums.LogicReagentMode.values) do
-- 	table.insert(reagentmodes, index)
-- end
-- table.sort(reagentmodes)
-- -- print(vim.inspect(reagentmodes))
-- vim.fn.writefile(reagentmodes, "data/reagentmodes.txt")

-- local batchmodes = {}
-- for index, _ in pairs(json.scriptEnums.LogicBatchMethod.values) do
-- 	table.insert(batchmodes, index)
-- end
-- table.sort(batchmodes)
-- -- print(vim.inspect(batchmodes))
-- vim.fn.writefile(batchmodes, "data/batchmodes.txt")
