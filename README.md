# tell-mark
A markdown to minecraft bedrock rawtext converter.

how to compile yourself:

    install nim.
    run nim c ./tell_mark.nim

meta: each md file needs the first 2 lines to be for meta data.

    line 1 = command type which must be one of these 3 (tell, title, actionbar)
    line 2 = player selector, just needs to be an in game selector example: @a[tag=test]

text: normal
format code: 1 : and the code ":dark red: I am the color dark red"

    :black:
    :dark blue:
    :dark green:
    :dark aqua:
    :dark red:
    :dark purple:
    :gold:
    :gray:
    :dark gray:
    :blue:
    :green:
    :aqua:
    :red:
    :light purple:
    :yellow:
    :white:
    :minecoin gold:
    :reset:
    :random:
    :bold:
    :italic:
    :strike:
    :underline:

selector: 1 * or _ "*player name*" or "_player name_"
score:
    
    url "[ name ]( board )" without the spaces