function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)"  -NoNewline  -ForegroundColor "red"
        }
        else {
            # we're on an actual branch, so print it
            Write-Host " ($branch)"  -NoNewline -ForegroundColor "yellow"
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host " (no branches yet)"  -NoNewline  -ForegroundColor "blue"
    }
}

function prompt {
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('$ ' * ($nestedPromptLevel + 1)) "

    $p = Split-Path -leaf -path (Get-Location)
    $d = Get-Date

    Write-Host "`n" -NoNewline
    Write-Host $path -NoNewline -ForegroundColor "blue"

    if (Test-Path .git) {
        Write-BranchName -NoNewline
    }
    
    Write-Host " | $d`n" -NoNewline
    
    return "$userPrompt"
}

function setprof {
    # powershell_ise $profile
    $base_path = Get-Variable HOME -valueOnly
    code $base_path\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
}

function proj {
    cd C:\Projects\
}

function ll {
    dir
}