local chatGuildEvent = CreateFrame("Frame")
chatGuildEvent:RegisterEvent("CHAT_MSG_GUILD") -- CHAT_MSG_SAY
chatGuildEvent:SetScript("OnEvent", function(self, event, message, sender, ...)
	if _0Admin["rewards"] == nil then
		_0Admin["rewards"] = {}

		_0Admin["rewards"][get_array_size(_0Admin["rewards"])] = "ok"
	else
		_0Admin["rewards"][get_array_size(_0Admin["rewards"])] = "oka"
	end
end)