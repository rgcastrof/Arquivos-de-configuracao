
# function username {
  # $usr = $env:USERNAME
  # "$usr"
# }

# function time {
    # $time = Get-Date -Format ("HH:mm")
    # "$time"
# }
function battery {
    $bat = (Get-CimInstance -ClassName Win32_Battery).EstimatedChargeRemaining 
    Write-Host "`nA bateria do notebook está em $bat%"
}

function homeDir {
    $currentPath = (Get-Location).Path
    if ($currentPath -eq $env:USERPROFILE) {
        $currentPath = '~'
        "$currentPath"
    } else {
        $currentPath = Split-Path -Leaf $pwd.Path
        "$currentPath"
    }
}

function git_prompt {
  if (Test-Path .git) {
    $git_branch = & git symbolic-ref --short HEAD 2>$null
    
    $git_status = & git status --porcelain 2>$null
    if (-not $git_status) {
      $git_status = "`e[32m✓"
    } else {
      $git_status = "`e[31m✗"
    }

    " `e[35mgit`e[0m::`e[35m(`e[31m$git_branch`e[35m)`e[0m$git_status"
  } else {
    $git_branch = ""
    $git_status = ""
  }

}


function prompt {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    $prefix = if (Test-Path variable:/PSDebugContext) { '[DBG]: ' } else { '' }
    if ($principal.IsInRole($adminRole)) {
        $prefix = "[ADMIN]:$prefix"
    }
    "`e[32m➜  ${prefix}`e[34m$(homeDir)`e[0m$(git_prompt)`e[0m  "
}


#Variáveis de ambiente
Set-PSReadLineOption -PredictionSource None
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Green

# Autostart
Get-Date
$(battery)


# Aliases
Set-Alias -Name vim -Value nvim
