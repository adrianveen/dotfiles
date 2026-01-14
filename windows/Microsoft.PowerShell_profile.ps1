Import-Module posh-git

function dotfiles
{git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @Args
}
function prompt
{
    # Get the current time in 24-hour format (HH:MM:SS)
    $timestamp = Get-Date -Format "HH:mm:ss"
    
    # Get the current location
    $currentPath = Get-Location
    
    # ANSI color codes
    $gray = "`e[90m"      # DarkGray
    $blue = "`e[34m"      # Blue
    $yellow = "`e[33m"    # Yellow
    $red = "`e[31m"       # Red
    $bold = "`e[1m"       # Bold
    $reset = "`e[0m"      # Reset
    
    # Build the path string
    $pathString = ""
    
    # Check if we're in the home directory or a subdirectory
    if ($currentPath.Path -eq $HOME)
    {
        $pathString = "$bold$red~$reset"
    } elseif ($currentPath.Path.StartsWith($HOME))
    {
        $relativePath = $currentPath.Path.Substring($HOME.Length).TrimStart('\')
        $pathParts = $relativePath -split '\\'
        
        if ($pathParts.Count -eq 1)
        {
            $pathString = "$bold$red~$reset$gray\$reset$red$($pathParts[0])$reset"
        } elseif ($pathParts.Count -eq 2)
        {
            $pathString = "$bold$red~$reset$gray\$reset$yellow$($pathParts[0])$reset$gray\$reset$red$($pathParts[1])$reset"
        } else
        {
            $parentDir = $pathParts[-2]
            $currentDir = $pathParts[-1]
            $pathString = "$bold$red~$reset$gray\...\$reset$yellow$parentDir$reset$gray\$reset$red$currentDir$reset"
        }
    } else
    {
        $drive = (Get-Location).Drive.Name + ":"
        $fullPath = $currentPath.Path
        $pathParts = $fullPath -split '\\'
        $pathParts = $pathParts | Where-Object { $_ -ne "" }
        
        if ($pathParts.Count -eq 1)
        {
            $pathString = "$blue$drive$reset$gray\$reset"
        } elseif ($pathParts.Count -eq 2)
        {
            $pathString = "$blue$drive$reset$gray\$reset$red$($pathParts[1])$reset"
        } elseif ($pathParts.Count -eq 3)
        {
            $pathString = "$blue$drive$reset$gray\$reset$yellow$($pathParts[1])$reset$gray\$reset$red$($pathParts[2])$reset"
        } else
        {
            $parentDir = $pathParts[-2]
            $currentDir = $pathParts[-1]
            $pathString = "$blue$drive$reset$gray\...\$reset$yellow$parentDir$reset$gray\$reset$red$currentDir$reset"
        }
    }
    # === posh-git ===
    # Defautl full prompt
    $gitStatus = $(Write-VcsStatus)
    # branch name only 
    # $branchText = ""

    # if (Get-Command Get-GitStatus -ErrorAction SilentlyContinue)
    # {
    #     $status = Get-GitStatus
    #     if ($status)
    #     {
    #         # -NoLeadingSpace lets you control spacing yourself
    #         $branchText = (Write-GitBranchName $status -NoLeadingSpace)
    #     }
    # }

    # Return the complete prompt as a single string
    return "┌─$reset$gray$timestamp$reset $gray[$reset$pathString$gray]$reset$gitStatus`n`└─$reset$ "
}



