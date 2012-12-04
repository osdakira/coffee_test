
hanKana = ["ｳﾞ","ｶﾞ","ｷﾞ","ｸﾞ","ｹﾞ","ｺﾞ","ｻﾞ","ｼﾞ","ｽﾞ","ｾﾞ","ｿﾞ","ﾀﾞ","ﾁﾞ","ﾂﾞ","ﾃﾞ","ﾄﾞ","ﾊﾞ","ﾋﾞ","ﾌﾞ","ﾍﾞ","ﾎﾞ","ﾊﾟ","ﾋﾟ","ﾌﾟ","ﾍﾟ","ﾎﾟ","ﾞ","｡","｢","｣","､","･","ｦ","ｧ","ｨ","ｩ","ｪ","ｫ","ｬ","ｭ","ｮ","ｯ","ｰ","ｱ","ｲ","ｳ","ｴ","ｵ","ｶ","ｷ","ｸ","ｹ","ｺ","ｻ","ｼ","ｽ","ｾ","ｿ","ﾀ","ﾁ","ﾂ","ﾃ","ﾄ","ﾅ","ﾆ","ﾇ","ﾈ","ﾉ","ﾊ","ﾋ","ﾌ","ﾍ","ﾎ","ﾏ","ﾐ","ﾑ","ﾒ","ﾓ","ﾔ","ﾕ","ﾖ","ﾗ","ﾘ","ﾙ","ﾚ","ﾛ","ﾜ","ﾝ","ﾟ"]

zenKana = ["ヴ","ガ","ギ","グ","ゲ","ゴ","ザ","ジ","ズ","ゼ","ゾ","ダ","ヂ","ヅ","デ","ド","バ","ビ","ブ","ベ","ボ","パ","ピ","プ","ペ","ポ","゛","。","「","」","、","・","ヲ","ァ","ィ","ゥ","ェ","ォ","ャ","ュ","ョ","ッ","ー","ア","イ","ウ","エ","オ","カ","キ","ク","ケ","コ","サ","シ","ス","セ","ソ","タ","チ","ツ","テ","ト","ナ","ニ","ヌ","ネ","ノ","ハ","ヒ","フ","ヘ","ホ","マ","ミ","ム","メ","モ","ヤ","ユ","ヨ","ラ","リ","ル","レ","ロ","ワ","ン","゜"]

hanNumber = (String.fromCharCode code for code in [48..57])
zenNumber = (String.fromCharCode code for code in [65296..65305])

hanAlpha = (String.fromCharCode code for code in [97..122].concat [65..90])
zenAlpha = (String.fromCharCode code for code in [65345..65370].concat [65313..65338])
han_fp = hanKana.concat hanNumber, hanAlpha
zen_fp = zenKana.concat zenNumber, zenAlpha

han_sp = hanNumber.concat hanAlpha
zen_sp = zenNumber.concat zenAlpha

$ ->
    $("#src").keyup (e) ->
        me = $("#src")
        val = me.val()
        $("#len").html val.length

        fp_str = split_fp val, 24
        $("#fp").val fp_str

        sp_str = split_sp val, 40
        $("#sp").val sp_str

split_fp = (val, limit) ->
    length = val.length
    lines = []
    line = []
    count = 0
    for idx in [0..length-1]
        # code = val.charCodeAt idx
        char = val.charAt idx
        charIdx = zen_fp.indexOf(char)
        if charIdx != -1
            char = han_fp[charIdx]
            if char.length > 1
                byte = 2
            else
                byte = 1
        else
            if char in han_fp
                byte = 1
            else
                byte = 2
        count += byte
        if count > limit
            count = byte
            lines.push line[..]
            line = []
        line.push char
        console.log byte, char, count, limit
    lines.push line
    lines = (line.join("") for line in lines)
    return lines.join("<br />\n")


split_sp = (val, limit) ->
    length = val.length
    lines = []
    line = []
    count = 0
    for idx in [0..length-1]
        # code = val.charCodeAt idx
        char = val.charAt idx
        charIdx = zen_sp.indexOf(char)
        if charIdx != -1
            char = han_sp[charIdx]
            if char.length > 1
                byte = 2
            else
                byte = 1
        else
            if char in han_sp
                byte = 1
            else
                byte = 2
        count += byte
        if count > limit
            count = byte
            lines.push line[..]
            line = []
        line.push char
        # console.log byte, char, count, limit
    lines.push line
    lines = (line.join("") for line in lines)
    return lines.join("<br />\n")

isAlnum = (aChar) ->
    return isDigit(aChar) or isAlpha(aChar)

isDigit = (aChar) ->
    myCharCode = aChar.charCodeAt(0)
    return 47 < myCharCode <  58

isAlpha = (aChar) ->
    myCharCode = aChar.charCodeAt(0)
    return 64 < myCharCode <  91 or 96 < myCharCode < 123

isHanKana = (aChar) ->
    return aChar in hanKana