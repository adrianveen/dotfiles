function prompt {
    # Get the current time in 24-hour format (HH:MM:SS)
    $timestamp = Get-Date -Format "HH:mm:ss"
    
    # Get the current location
    $currentPath = Get-Location
    
    # Check for active virtual environment
    if ($env:VIRTUAL_ENV) {
        $envName = Split-Path $env:VIRTUAL_ENV -Leaf
        Write-Host "($envName) " -NoNewline -ForegroundColor Green
    }
    elseif ($env:CONDA_DEFAULT_ENV) {
        Write-Host "($env:CONDA_DEFAULT_ENV) " -NoNewline -ForegroundColor Green
    }
    
    # Display timestamp
    Write-Host $timestamp -NoNewline -ForegroundColor DarkGray
    Write-Host " " -NoNewline
    
    # Display opening bracket
    Write-Host "[" -NoNewline -ForegroundColor DarkGray
    
    # Check if we're in the home directory or a subdirectory
    if ($currentPath.Path -eq $HOME) {
        # Exactly at home directory - bold tilde
        Write-Host "`e[1m~`e[0m" -NoNewline -ForegroundColor Red
    }
    elseif ($currentPath.Path.StartsWith($HOME)) {
        # Inside home directory somewhere
        $relativePath = $currentPath.Path.Substring($HOME.Length).TrimStart('\')
        $pathParts = $relativePath -split '\\'
        
        if ($pathParts.Count -eq 1) {
            # One level below home (e.g., ~\Documents)
            Write-Host "`e[1m~`e[0m" -NoNewline -ForegroundColor Red
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
            Write-Host $pathParts[0] -NoNewline -ForegroundColor Red
        }
        elseif ($pathParts.Count -eq 2) {
            # Two levels below home (e.g., ~\Documents\Projects) - no dots
            Write-Host "`e[1m~`e[0m" -NoNewline -ForegroundColor Red
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
            Write-Host $pathParts[0] -NoNewline -ForegroundColor Yellow
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
            Write-Host $pathParts[1] -NoNewline -ForegroundColor Red
        }
        else {
            # Three or more levels below home (e.g., ~\...\Projects\MyApp) - show dots
            $parentDir = $pathParts[-2]
            $currentDir = $pathParts[-1]
            
            Write-Host "`e[1m~`e[0m" -NoNewline -ForegroundColor Red
            Write-Host "\...\" -NoNewline -ForegroundColor DarkGray
            Write-Host $parentDir -NoNewline -ForegroundColor Yellow
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
            Write-Host $currentDir -NoNewline -ForegroundColor Red
        }
    }
    else {
        # Outside home directory - show drive letter
        $drive = (Get-Location).Drive.Name + ":"
        
        # Get full path and split it
        $fullPath = $currentPath.Path
        $pathParts = $fullPath -split '\\'
        # Remove empty first element (before drive letter)
        $pathParts = $pathParts | Where-Object { $_ -ne "" }
        
        if ($pathParts.Count -eq 1) {
            # At root of drive (e.g., D:\)
            Write-Host $drive -NoNewline -ForegroundColor Blue
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
        }
        elseif ($pathParts.Count -eq 2) {
            # One level down (e.g., D:\folder)
            Write-Host $drive -NoNewline -ForegroundColor Blue
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
            Write-Host $pathParts[1] -NoNewline -ForegroundColor Red
        }
        elseif ($pathParts.Count -eq 3) {
            # Two levels down (e.g., D:\parent\cwd) - no dots
            Write-Host $drive -NoNewline -ForegroundColor Blue
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
            Write-Host $pathParts[1] -NoNewline -ForegroundColor Yellow
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
            Write-Host $pathParts[2] -NoNewline -ForegroundColor Red
        }
        else {
            # Three or more levels down (e.g., D:\...\parent\cwd) - show dots
            $parentDir = $pathParts[-2]
            $currentDir = $pathParts[-1]
            
            Write-Host $drive -NoNewline -ForegroundColor Blue
            Write-Host "\...\" -NoNewline -ForegroundColor DarkGray
            Write-Host $parentDir -NoNewline -ForegroundColor Yellow
            Write-Host "\" -NoNewline -ForegroundColor DarkGray
            Write-Host $currentDir -NoNewline -ForegroundColor Red
        }
    }
    
    # Display closing bracket
    Write-Host "]" -ForegroundColor DarkGray
    
    # Return the bash-style prompt symbol on a new line
    return "$ "
}
