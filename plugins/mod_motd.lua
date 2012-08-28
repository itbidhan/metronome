local host = module:get_host();
local motd_text = module:get_option_string("motd_text");
local motd_jid = module:get_option_string("motd_jid", host);

if not motd_text then return; end

local jid_join = require "util.jid".join;
local st = require "util.stanza";

motd_text = motd_text:gsub("^%s*(.-)%s*$", "%1"):gsub("\n%s+", "\n"); -- Strip indentation from the config

module:hook("presence/bare", function (event)
		local session, stanza = event.origin, event.stanza;
		if not session.presence and not stanza.attr.type then
			local motd_stanza =
				st.message({ to = session.full_jid, from = motd_jid })
					:tag("body"):text(motd_text);
			module:send(motd_stanza);
			module:log("debug", "MOTD send to user %s", session.full_jid);
		end
end, 1);