---
external help file: PSUtils-help.xml
Module Name: PSUtils
online version:
schema: 2.0.0
---

# Get-LatestGitHubRelease

## SYNOPSIS
Retrieve the latest release from a GitHub repository.

## SYNTAX

```
Get-LatestGitHubRelease [-Repo] <String> [-Extensions <Array>] [-DownloadPath <String>] [<CommonParameters>]
```

## DESCRIPTION
Uses the GitHub API to pull the latest release of any app, tool or utility hosted on GitHub.

## EXAMPLES

### EXAMPLE 1
```

```

## PARAMETERS

### -Repo
GitHub Repository Reference in the format: \<user/org\>/\<repo\>.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Extensions
Target glob patterns of desired extension to search for.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DownloadPath
Path to download to, defaults to ~/Downloads.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
