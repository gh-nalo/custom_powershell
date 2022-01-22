function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)" -ForegroundColor "red"
        }
        else {
            # we're on an actual branch, so print it
            Write-Host " ($branch)" -ForegroundColor "blue"
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host " (no branches yet)" -ForegroundColor "yellow"
    }
}

function prompt {
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('> ' * ($nestedPromptLevel + 1)) "

    $p = Split-Path -leaf -path (Get-Location)
    $d = Get-Date

    Write-Host "`n$d | " -NoNewline

    if (Test-Path .git) {
        Write-Host $path -NoNewline -ForegroundColor "green"
        Write-BranchName
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        Write-Host $path -ForegroundColor "green"
    }
    
    return "$env:CONDA_PROMPT_MODIFIER $userPrompt"
}

function workon($environment_name) {
    conda activate $environment_name
}

function envs {
    conda env list
}

function proj {
    Set-Location C:\Projects\
}

function setprof {
    # powershell_ise $profile
    $base_path = Get-Variable HOME -valueOnly
    code $base_path\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
}

function lab {
    jupyter-lab.exe .
}