
Personality.Artificial.DW_MISSIONSTART = {
	"Got a survey drone on location. Coming through clear.",
	"Check check. I'm your eye in the sky.",
	"Scanning the LZ. Over.",
	"Looks good from up here.",
	"I've got visual. Put on a show.",
	"I've got visual on the LZ.",
	"Locked on to the zone.",
	"Zone scan is good. Drop 'em.",
	"Landing checks are coming in clean.",
	"Local systems are under control. Get to it.",
	"Local network breached, killswitches are live. Go for drop.",
	"Connecting to local network. We'll be in before the shooting starts.",
	"Found a good entry point to the Grid. We can use this.",
	"Weapons hot, #squad. We have a strike target in the area.",
	"Seeing some valuable stuff in the LZ. You know what to do.",
	"Zio eruption ongoing. Drop 'em.",
	"Zio are breaching. Get to it.",
	"Seeing some Zio. Play hero for the locals.",
	"Drop is good. Play hero for the locals.",
	"There's Zio in the area. Get to it.",
	"Time to wreck 'em.",
	"Landing checks are good. Go for drop.",
}

modapiext.dialog:addRuledDialog("DW_MISSIONSTART", {
    Odds = 100,
    { main = "DW_MISSIONSTART" }
})

Personality.Artificial.DW_MISSIONSTART_CEO = {
	"Eyes on the prize. One good hit here and we take it all.",
	"Keep it clean out there. This is our death blow.",
	"Got visual on the HQ. Prepare for tertiary action.",
	"Everything is in place. Go for the tower.",
	"Suppressor fields are burning out. We only have one chance to take that tower.",
	"They're about to realize why we're really here.",
	"Killswitches are ready. Hit the tower and we lock down the whole island.",
	"This is the real thing. Hit the tower and we lock down the whole island.",
	"The tower's security is too much for us. One hit from your weapons would do it, though.",
	"Can't get into the tower's network from here. You'll need to rough it up first.",
	"Agent teams are in position. Get the tower.",
	"That tower needs to break at any cost. Remember your real mission.",
	"Ready to strike the HQ. Take them down!",
	"Here's the important one. Don't hold back now.",
}

modapiext.dialog:addRuledDialog("DW_MISSIONSTART_CEO", {
    Odds = 100,
    { main = "DW_MISSIONSTART_CEO" }
})

Personality.Artificial.DW_MISSIONSTART_FINAL = {
	"Getting ready to unplug. You're on your own from here.",
	"We have what we need from here. Play along and burn out the Zio.",
	"Covering our tracks now. Save the day and we can pull you out.",
	"Keep it together out there, all we did is riding on this.",
	"For what it's worth, the agents believe in you. Best of luck.",
	"Preparing to unplug. We're all counting on you.",
	"For once, we're playing fair. I'll see you on the other side.",
}

modapiext.dialog:addRuledDialog("DW_MISSIONSTART_FINAL", {
    Odds = 100,
    { main = "DW_MISSIONSTART_FINAL" }
})

Personality.Artificial.DW_LOOT = {
	"Salvage team TRI-M you're cleared to go.",
	"Salvage teams are on site. We'll have it picked clean within the hour.",
	"Getting a signal. Their good stuff survived that.",
	"Recovery teams are coming in hot.",
	"Salvage agents are moving in.",
	"Locking down the site. Survivors are being compensated.",
	"Survivors are being persuaded. Transmitting agent codes.",
	"Rolling out a good story. They'll pay us big time.",
	"Securing the site now. Good work.",
	"Sensors indicate all targets unresponsive. Good work.",
	"Transmitting termination codes. They'll pay out for that one.",
	"Site leveled, we're good for secondary action.",
	"You made it look like an accident, right?",
	"They'll blame the Zio. Keep going.",
	"Agents are moving in. Keep it up.",
	"This island's getting softer. Good work.",
	"That'll punch a hole in their chain of command.",
	"Key targets neutralized. Now get the rest of the Zio.",
	"Minimal debris splash. Teardown is clean.",
	"#ceo's going to feel that.",
	"Suppression is ongoing, the locals won't see a thing.",
	"Suppression is holding. We're clean.",
	"Suppression is up and holding. They won't see a thing.",
	"Suppressors are working. We can leverage this.",
}

modapiext.dialog:addRuledDialog("DW_LOOT", {
    Odds = 100,
    { main = "DW_LOOT" }
})

Personality.Artificial.DW_LOOT_WRONG = {
	"Not a marked target. What are you doing?",
	"That's not your target. What are you doing?",
	"Wrong target. What are you doing?",
	"Leave something for us to take over.",
	"We can compensate. Don't do that again.",
	"That knocked out our grid tap. Rerouting to backup.",
	"We already have the grid compromised. It can't take much more.",
	"Agent team TRI-L unresponsive. Where did that just hit?!",
	"Agent team TRI-B unresponsive. That'll set us back.",
	"We need to survive this before we can take over, you know.",
	"Picking up a voltage drop. What happened?",
	"Lost drone connection. Did something happen?!",
	"Local public is in panic. We didn't suppress that one.",
	"Local public is panicking. This isn't going to plan.",
	"You're outside suppression. They saw that one.",
	"Didn't have suppression up yet. Registering tragedy.",
	"I'll warm up the suppressor, but might not be able to hide this one.",
	"The civillians need to forgive us for these, you know.",
	"At this rate we'll have nothing left to rule over.",
	"We're here to stop the Zio too, you know!",
}

modapiext.dialog:addRuledDialog("DW_LOOT_WRONG", {
    Odds = 100,
    { main = "DW_LOOT_WRONG" }
})

Personality.Artificial.DW_LOOT_CEO = {
	"Hardpoint is breached! All agents, sieze them!",
	"Hardpoint is down! Take everything you can!",
	"We have breakthrough! Go go go!",
	"Tower is down, I repeat, tower is down!",
	"We are go for tertiary action! Sieze them!",
	"We are go for tertiary action! All agents move out!",
	"Suppression is failing. Take control now!",
	"Secure the tower! This island is ours now!",
	"Hold off the Zio just a little longer. We have them.",
	"Agents, push for total surrender. We have them.",
	"Lock down the tower site. We need them alive.",
	"Going loud. The locals will forgive us, or at least fear us.",
}

modapiext.dialog:addRuledDialog("DW_LOOT_CEO", {
    Odds = 100,
    { main = "DW_LOOT_CEO" }
})