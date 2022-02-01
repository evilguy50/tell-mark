type
    Format* = object
        code*: string
        to*: string

proc newFormat*(code, to: string): Format=
    result.code = code
    result.to = to

var formats*: seq[Format] = @[Format(code:"black", to:"§0"),
Format(code:"dark blue",to:"§1"),Format(code:"dark green",to:"§2"),
Format(code:"dark aqua",to:"§3"),Format(code:"dark red",to:"§4"),
Format(code:"dark purple",to:"§5"),Format(code:"gold",to:"§6"),
Format(code:"gray",to:"§7"),Format(code:"dark gray",to:"§8"),
Format(code:"blue",to:"§9"),Format(code:"green",to:"§a"),
Format(code:"aqua",to:"§b"),Format(code:"red",to:"§c"),
Format(code:"light purple",to:"§d"),Format(code:"yellow",to:"§e"),
Format(code:"white",to:"§f"),Format(code:"minecoin gold",to:"§g"),
Format(code:"random",to:"§k"),Format(code:"strike",to:"§m"),
Format(code:"underline",to:"§n"),Format(code:"italic",to:"§o"),
Format(code:"bold",to:"§l"),Format(code:"reset",to:"§r"),
Format(code:"less",to:"<"),Format(code:"more",to:">")]

var codes*, tos*: seq[string]
for i in formats:
    codes.add(i.code)
    tos.add(i.to)