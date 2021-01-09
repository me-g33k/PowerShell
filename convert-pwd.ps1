function convert-pwd {
    <#
    .SYNOPSIS
      Convert presented string into obscured password
    .DESCRIPTION
      Convert presented string into obscured password
    .PARAMETER tgtPWord
        Target password string. Usually the username.
    .INPUTS
      NONE
    .OUTPUTS
      NONE
    .NOTES
      Version:        $Rev$
      Author:         $Author$
      Creation Date:  $Date$
      Purpose/Change: Initial script development
    .LINK
        Script posted over:
        http://sourceSite.local
    .EXAMPLE
        PS D:\WIP> convert-pwd "ashlee.smith"
        A3sH7eE.essM@y3TH
    #>
    [CmdletBinding()]
    param (
            [Parameter(Mandatory=$true,
                       ValueFromPipelineByPropertyName=$true,
                       Position=0)]
            [string]
            $tgtPWord
        )
        process {
            $cipher = @{
                a = "a","A","@","4","3h","eh"
                b = "b","B","9","bee","b33"
                c = "c","C","see","533"
                d = "d","D"
                e = "e","E","3"
                f = "f","F","ef","ehf"
                g = "g","G","gee","g33"
                h = "h","H","aych","aech"
                i = "i","I","eye","3y3","aye","@y3"
                j = "j","J","jay","j@y","jeh"
                k = "k","K","kay","k@y","keh"
                l = "l","L","7","el","ehl"
                m = "m","M","em","3m","ehm","3hm"
                n = "n","N","en","3n","ehn","3hn"
                o = "o","O","0","oh","0h"
                p = "p","P","pee","p3h"
                q = "q","Q","que","Kue"
                r = "r","R","ehr","3hr"
                s = "s","S","ess","3s","35"
                t = "t","T","tee","t33"
                v = "v","V","vee","v33"
                w = "w","W","dubu"
                x = "x","X","ehks","3hk5"
                y = "y","Y","why","whye"
                z = "z","Z","zee","z33"
            }

            $newPwd =""

            foreach ($chr in $tgtPWord.tochararray() ){

                $chr = $chr.tostring()
            
                if($cipher.containskey("$chr")){
                    $chr = $chr.tolower()
                    $encChr = $cipher.item($chr) | get-random
                    # $msg = "Old chr - $chr :: New chr - $encChr"
                    # Write-host -foreground yellow $msg    
                } else {
                    $encChr = $chr
                }
                
                $newPwd = $newPwd + $encChr
            
            }
            
            return $newPwd
        }
    } 