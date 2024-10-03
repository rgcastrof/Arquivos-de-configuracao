function username {
  $usr = $env:USERNAME
  "$usr"
}

function time {
    $time = Get-Date -Format ("HH:mm")
    "$time"
}
function battery {
    $bat = (Get-CimInstance -ClassName Win32_Battery).EstimatedChargeRemaining 
    "󰁹 $bat%"
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
      $git_status = '✓'
    } else {
      $git_status = '✗'
    }

    " ➜ ($git_branch)$git_status"
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
    "$(battery) ${prefix}[$(username)@$(time) $(homeDir)]$(git_prompt) "
}
