function guild_send_message(message)
  SendChatMessage(message, "GUILD", nil, GetUnitName("PLAYERTARGET"))
end

function get_player_guild_rank_index(player)
	if player == nil then
		player = "player"
	end

	local guildName, guildRankName, guildRankIndex = GetGuildInfo(player)

	return guildRankIndex
end

function get_player_guild_rank_name(player)
	if player == nil then
		player = "player"
	end

	local guildName, guildRankName, guildRankIndex = GetGuildInfo(player)

	return guildRankName
end

function get_player_guild_name(player)
	if player == nil then
		player = "player"
	end

	local guildName, guildRankName, guildRankIndex = GetGuildInfo(player)

	return guildName
end