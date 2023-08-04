# Todo - `PSUtils`

## Templates/Helper Functions

- `New-GitIgnore` and `powershell.template.gitignore`: Add a template `.gitignore` to the root Powershell project.
- `New-GitAttributes` and `powershell.template.gitattributes`: Add a template `.gitattributes` to the root Powershell project.
- `New-ReadMe` and `README.template.md`: Add a template `README.md` to the root Powershell project.
- `New-License` and `LICENSE.template.md`: Add a template `LICENSE.md` to the root Powershell project.
- `New-ChangeLog` and `CHANGELOG.template.md`: Add a template `CHANGELOG.md` to the root Powershell project.
- `New-BuildTask` and `Task.template.ps1`: Add a template `task.template.ps1` to the root Powershell project.
- `New-ModuleManifest` and `ModuleManifest.template.psd1`: Add a template `ModuleManifest.psd1` to the root Powershell project.
- `New-ModuleScript` and `ModuleScript.template.psm1`: Add a template `ModuleScript.psm1` to the root Powershell project.


## Miscellaneous Functions

- `New-PSMenu`: Function to create an interactive menu in the console
  - Helpers:
    - `Invoke-DrawMenu`
    - `Invoke-ToggleSelection`


## Commonly Used Files

### GitHub

- GitHub: `.github/`
  - Markdown Template Files: `.github/markdown/`
    - `ISSUE_TEMPLATE/`
      - `bug.md`
      - `feature.md`
      - `question.md`
      - `docs.md`
    - `PULL_REQUEST_TEMPLATE.md`
    - `CODE_OF_CONDUCT.md`
    - `CONTRIBUTING.md`
    - `SECURITY.md`
  - Configuration Files:
    - `cliff.toml`: For usage with `git-cliff`
    - `mkdocs.yml`: For usage with `mkdocs`
    - `labels.yml`: GitHub Labels
    - `dependabot.yml`: For usage with `dependabot`
    - `CODEOWNERS`: GitHub Code Owners
  - Workflows: `.github/workflows/`
    - `build.yml`: Build workflow
    - `release.yml`: Release workflow
    - `publish.yml`: Publish workflow
    - `test.yml`: Test workflow
    - `lint.yml`: Lint workflow
    - `docs.yml`: Documentation workflow
    - `changelog.yml`: Changelog workflow
    - `dependabot.yml`: Dependabot workflow
    - `stale.yml`: Stale workflow
    - `build-site.yml`: Build site (GitHub Pages) workflow
    - `pester.yml`: Pester workflow


### VSCode

- `.vscode/`:
  - `extensions.json`
  - `settings.json`
  - `tasks.json`
  - `launch.json`
  - `keybindings.json`
  - `snippets/`
    - `powershell.json`
    - `markdown.json`
    - `git.json`
    - `yaml.json`
    - `json.json`

- `.devcontainer/`:
  - `Dockerfile`
  - `devcontainer.json`

### Build Tasks

- `{{ModuleName}}.build.ps1`: Build script
- `psake.ps1`: `psake` File

- `Tasks/`
  - `Build.Task.ps1`: Build task
  - `Clean.Task.ps1`: Clean task
  - `Lint.Task.ps1`: Lint task
  - `Test.Task.ps1`: Test task
  - `Docs.Task.ps1`: Documentation task
  - `Analyze.Task.ps1`: Analyze task
  - `Pester.Task.ps1`: Pester task
  - `Changelog.Task.ps1`: Changelog task
  - `Publish.Task.ps1`: Publish task
  - `Release.Task.ps1`: Release task
  - `Install.Task.ps1`: Install task
  - `Uninstall.Task.ps1`: Uninstall task
  - `Compile.Task.ps1`: Compile task
  - `Help.Task.ps1`: Help task

### Documentation

### Testing

### Linting

### Configuration



## Commonly Used Directories
