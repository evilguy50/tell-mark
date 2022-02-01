from htmlparser import entityToRune
from unicode import `$`

proc mcEmote*(index: string): string = $(entityToRune("#x" & index))