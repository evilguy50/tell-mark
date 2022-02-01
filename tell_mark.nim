import os, re, json, strutils
import slimdown
include "./formats.nim"
include "./runes.nim"

var emotes = readFile("./emotes.json").parseJson()
var eFormats = formats
for e in emotes["emotes"]:
    var newCode = e["name"].getStr()
    var newTo = mcEmote(e["code"].getStr())
    eFormats.add(newFormat(newCode, newTo))

for md in os.walkFiles("./marks/*.md"):
    var oldLines = md.readFile().splitLines()
    var rawCmd = oldLines[0]
    var rawSelect = oldLines[1]
    var mdLines: seq[string]
    var lineIndex = -1
    for l in md.readFile().splitLines():
        lineIndex.inc(1)
        if lineIndex > 1:
            mdLines.add(l)
    var mdStr = mdLines.join(r"\n").replace("<", ":less:").replace(">", ":more:")
    var mdName = md.splitFile()[1]
    var newMD = $(md(mdStr))
    echo newMD
    var rx = re("""()?(<([a-zA-Z0-9 ='"<>§@]{0,10000}\/)?([a-z]{0,10})>)""")
    echo newMD
    var text = newMD.split(rx)
    echo text
    var texts: seq[string]
    var textIndex = -1
    for t in text:
        textIndex.inc(1)
        if t.len() != 0:
            var newT = t
            try:
                if text[textIndex + 1] == "":
                    newT = t & " "
            except:
                echo ""
            texts.add("{\"text\":\"$t\"}".replace("$t", newT))
            newMD = newMD.replace(t, "$$$text")
    echo newMD
    var other = newMD.split("$$$text")
    var others: seq[string]
    for o in other:
        try:
            if o.contains("</em>"):
                others.add("{\"selector\":\"$s\"}".replace("$s", o.replace(o, o.findall((re("""()?([a-z0-9"_@=\[\],{} ]{1,100})(?=<\/)""")))[0])))
                newMD = newMD.replace(o, "$$$other")
            elif o.contains("</a>"):
                var newO = "{\"score\":{\"name\": \"$name\",\"objective\": \"$board\"}}".replace("$board",o.replace(o, o.findall((re("""()?((?<=href=')[a-z0-9_]{1,20})""")))[0]))
                newO = newO.replace("$name", o.replace(o, o.findAll(re("""()?([a-z0-9 "_@=\[\],{}]{1,100})(?=<\/)"""))[0]))
                newMD = newMD.replace(o, "$$$other")
                others.add(newO)
        except:
            echo(getCurrentExceptionMsg())
    echo newMD
    newMD = format(replace(newMD, "$$$text", "$#").replace("$$$other","[||]"), texts.toOpenArray(0, texts.len() - 1))
    newMD = format(replace(newMD, "[||]", "$#"), others.toOpenArray(0, others.len() - 1))
    newMD = newMD.replace("}{", "},{")
    case rawCmd:
    of "actionbar":
        newMD = "titleraw " & rawSelect & " actionbar {\"rawtext\":[" & newMD & "]}"
    of "title":
        newMD = "titleraw " & rawSelect & " title {\"rawtext\":[" & newMD & "]}"
    of "tell":
        newMD = "tellraw " & rawSelect & " {\"rawtext\":[" & newMD & "]}"
    else:
        continue
    for f in eFormats:
        newMD = newMD.replace(":" & f.code & ":", f.to)
    writeFile("./out/" & mdName & ".mcfunction", newMD)