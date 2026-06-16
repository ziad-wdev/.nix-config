-- Layer Rules (Only for shell elements matching a namespace)
hl.layer_rule({
	match = { namespace = "logout_dialog" },
	blur = true,
	xray = true,
})

hl.layer_rule({
	match = { namespace = "quickshell:polkitagent" },
	blur = true,
})

-- Float generic utility windows
hl.window_rule({ match = { title = "^(Open File)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(Select a File)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(Choose wallpaper)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(Save As)(.*)$" }, float = true })
hl.window_rule({ match = { title = "^(Library)(.*)$" }, float = true })
