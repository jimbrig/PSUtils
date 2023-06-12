Function New-Timer {
  <#
    .SYNOPSIS
      Creates a new stopwatch.
  
    .DESCRIPTION
      Function will create a new time, using the StopWatch class, allowing measurement of elapsed time in scripts.
  
    .EXAMPLE
      $MyTimer = New-Timer

      # Create and assign a new timer to object `$MyTimer`

    .NOTES
      Function takes no parameters and will start a new StopWatch object.
  #>
    
    [OutputType([System.Diagnostics.Stopwatch])]
    param ()
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    return $stopwatch
}

Function Get-TimerStatus {
    <#
        .SYNOPSIS
            Will return boolean value representing status of an existing stopwatch.
        
        .DESCRIPTION
            Function requires a [System.Diagnostics.Stopwatch] object as input and 
      will return $True if stopwatch is running or $False otherwise.
        
        .PARAMETER Timer
            A [System.Diagnostics.Stopwatch] object representing the StopWatch to check 
      status for.
        
        .EXAMPLE
      $MyTimer = New-Timer
            Get-TimerStatus -Timer $MyTimer

      # Create the timer and view its status.
    
        .OUTPUTS
            System.Boolean
    #>
    
    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Diagnostics.Stopwatch]
        $Timer
    )
    
    return $Timer.IsRunning
}

Function Get-ElapsedTime {
    <#
        .SYNOPSIS
            Will return information about elapsed time for the given StopWatch.
        
        .DESCRIPTION
            Function requires a [System.Diagnostics.Stopwatch] object as input and 
      will output information about elapsed time.
            
            By default a [TimeSpan] object is returned containing all information 
      about elapsed time.
            
            If any other parameter like -Days is used function will return an Int 
      or Double instead depending on the switch used.
        
        .PARAMETER ElapsedTime
            Will return a [TimeSpan] object representing the elapsed time for the 
      given stopwatch.
        
        .PARAMETER Days
            Will return an [Int] object representing the number of days since the 
      stopwatch was started.
        
        .PARAMETER Hours
            Will return an [Int] object representing the number of hours since the 
      stopwatch was started.
        
        .PARAMETER Minutes
            Will return an [Int] object representing the number of minutes since the 
      stopwatch was started.
        
        .PARAMETER Seconds
            Will return an [Int] object representing the number of seconds since the 
      stopwatch was started.
        
        .PARAMETER TotalDays
            Will return a [Double] object representing the number of TotalDays since 
      the stopwatch was started.
        
        .PARAMETER TotalHours
            Will return a [Double] object representing the number of TotalHours since 
      the stopwatch was started.
        
        .PARAMETER TotalMinutes
            Will return a [Double] object representing the number of TotalMinutes 
      since the stopwatch was started.
        
        .PARAMETER TotalSeconds
            Will return a [Double] object representing the number of TotalSeconds 
      since the stopwatch was started.
        
        .PARAMETER TotalMilliseconds
            Will return a [Double] object representing the number of TotalMilliseconds 
      since the stopwatch was started.
        
        .EXAMPLE
      $MyTimer = New-Timer
            Get-ElapsedTime -ElapsedTime $MyTimer -Days
        
        .OUTPUTS
            System.TimeSpan, System.Double, System.Int32
    #>
        
    [CmdletBinding(
    DefaultParameterSetName = 'FullOutput',
    ConfirmImpact = 'High',
        SupportsPaging = $false,
        SupportsShouldProcess = $false
  )]
    [OutputType([timespan], ParameterSetName = 'FullOutput')]
    [OutputType([int], ParameterSetName = 'Days')]
    [OutputType([int], ParameterSetName = 'Hours')]
    [OutputType([int], ParameterSetName = 'Minutes')]
    [OutputType([int], ParameterSetName = 'Seconds')]
    [OutputType([double], ParameterSetName = 'TotalDays')]
    [OutputType([double], ParameterSetName = 'TotalHours')]
    [OutputType([double], ParameterSetName = 'TotalMinutes')]
    [OutputType([double], ParameterSetName = 'TotalSeconds')]
    [OutputType([double], ParameterSetName = 'TotalMilliseconds')]
    [OutputType([timespan])]
    param
    (
        [Parameter(ParameterSetName = 'FullOutput', Mandatory = $true)]
        [Parameter(ParameterSetName = 'Days')]
        [Parameter(ParameterSetName = 'Hours')]
        [Parameter(ParameterSetName = 'Minutes')]
        [Parameter(ParameterSetName = 'Seconds')]
        [Parameter(ParameterSetName = 'TotalDays')]
        [Parameter(ParameterSetName = 'TotalHours')]
        [Parameter(ParameterSetName = 'TotalMilliseconds')]
        [Parameter(ParameterSetName = 'TotalMinutes')]
        [Parameter(ParameterSetName = 'TotalSeconds')]
        [System.Diagnostics.Stopwatch]
        $ElapsedTime,
        [Parameter(ParameterSetName = 'Days')]
        [switch]
        $Days,
        [Parameter(ParameterSetName = 'Hours')]
        [switch]
        $Hours,
        [Parameter(ParameterSetName = 'Minutes')]
        [switch]
        $Minutes,
        [Parameter(ParameterSetName = 'Seconds')]
        [switch]
        $Seconds,
        [Parameter(ParameterSetName = 'TotalDays')]
        [switch]
        $TotalDays,
        [Parameter(ParameterSetName = 'TotalHours')]
        [switch]
        $TotalHours,
        [Parameter(ParameterSetName = 'TotalMinutes')]
        [switch]
        $TotalMinutes,
        [Parameter(ParameterSetName = 'TotalSeconds')]
        [switch]
        $TotalSeconds,
        [Parameter(ParameterSetName = 'TotalMilliseconds')]
        [switch]
        $TotalMilliseconds
    )
    
    switch ($PsCmdlet.ParameterSetName)
    {
        'FullOutput'
        {
            # Return full timespan object
            return $ElapsedTime.Elapsed
            
            break
        }
        'Days'
        {
            # Return days with no decimals
            return $ElapsedTime.Elapsed.Days
            
            break
        }
        'Hours'
        {
            # Return hours with no decimals
            return $ElapsedTime.Elapsed.Hours
            
            break
        }
        'Minutes'
        {
            # Return minutes with no decimals
            return $ElapsedTime.Elapsed.Minutes
            
            break
        }
        'Seconds'
        {
            # Return seconds with no decimals
            return $ElapsedTime.Elapsed.Seconds
            
            break
        }
        'TotalDays'
        {
            # Return days with double precision
            return $ElapsedTime.Elapsed.TotalDays
            
            break
        }
        'TotalHours'
        {
            # Return hours with double precision
            return $ElapsedTime.Elapsed.TotalHours
            
            break
        }
        'TotalMinutes'
        {
            # Return minutes with double precision
            return $ElapsedTime.Elapsed.TotalMinutes
            
            break
        }
        'TotalSeconds'
        {
            # Return seconds with double precision
            return $ElapsedTime.Elapsed.TotalSeconds
            
            break
        }
        'TotalMilliseconds'
        {
            # Return milliseconds with double precision
            return $ElapsedTime.Elapsed.TotalMilliseconds
            
            break
        }
    }
}

Function Stop-Timer {
  <#
        .SYNOPSIS
            Function will halt a stopwatch.
        
        .DESCRIPTION
            Function requires a [System.Diagnostics.Stopwatch] object as input and 
      will invoke the stop() method to hald its execution.
        
            If no exceptions are returned function will return $True.
        
        .PARAMETER Timer
            A [System.Diagnostics.Stopwatch] representing the stopwatch to stop.
        
        .EXAMPLE
      $MyTimer = New-Timer
            Stop-Timer -Timer $MyTimer

      # Create and then Stop a timer
        
    .OUTPUTS
            System.Boolean
    #>
    
    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Diagnostics.Stopwatch]$Timer
    )
    
    Begin
    {
        # Save current configuration
        [string]$currentConfig = $ErrorActionPreference
        
        # Update configuration
        $ErrorActionPreference = 'Stop'
    }
    
    Process
    {
        try
        {
            # Stop timer
            $Timer.Stop()
            
            return $true
        }
        catch
        {
            # Save exception
            [string]$reportedException = $Error[0].Exception.Message
            
            Write-Warning -Message 'Exception reported while halting stopwatch - Use the -Verbose parameter for more details'
            
            # Check we have an exception message
            if ([string]::IsNullOrEmpty($reportedException) -eq $false)
            {
                Write-Verbose -Message $reportedException
            }
            else
            {
                Write-Verbose -Message 'No inner exception reported by Disconnect-AzureAD cmdlet'
            }
            
            return $false
        }
    }
    
    End
    {
        # Revert back configuration
        $ErrorActionPreference = $currentConfig
    }
}

