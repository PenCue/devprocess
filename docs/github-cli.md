## Create issue

```shell
$ gh issue create

Creating issue in PenCue/devprocess

? Choose a template  [Use arrows to move, type to filter]
  Bug report
> Feature request
  Open a blank issue
```

```shell
$ gh issue create

Creating issue in PenCue/devprocess

? Choose a template Feature request
? Title gh-cli-documentation-and-screenshots
? Body [(e) to launch vim, enter to skip]

```

```markdown
# PenCue Feature Request


**Is your feature request related to a problem? Please describe.**
Yes I needed a issue and PR to get screenshots and documentation

**Describe the solution you'd like**
I want to illustrate the command line and web interface for our branching model

**Additional context**

```

```
$ gh issue create

Creating issue in PenCue/devprocess

? Choose a template Feature request
? Title gh-cli-documentation-and-screenshots
? Body <Received>
? What's next? Add metadata
? What would you like to add?  [Use arrows to move, space to select, type to filter]
  [ ]  Assignees
  [x]  Labels
> [x]  Projects
  [ ]  Milestone		
```

```bash
$ gh issue create

Creating issue in PenCue/devprocess

? Choose a template Feature request
? Title gh-cli-documentation-and-screenshots
? Body <Received>
? What's next? Add metadata
? What would you like to add? Labels, Projects
? Labels documentation
? Projects  [Use arrows to move, space to select, type to filter]
> [x]  DevOps Process
```

```shell
$ gh issue create

Creating issue in PenCue/devprocess

? Choose a template Feature request
? Title gh-cli-documentation-and-screenshots
? Body <Received>
? What's next? Add metadata
? What would you like to add? Labels, Projects
? Labels documentation
? Projects DevOps Process
? What's next?  [Use arrows to move, type to filter]
> Submit
  Cancel
```

```
$ gh issue create

Creating issue in PenCue/devprocess

? Choose a template Feature request
? Title gh-cli-documentation-and-screenshots
? Body <Received>
? What's next? Add metadata
? What would you like to add? Labels, Projects
? Labels documentation
? Projects DevOps Process
? What's next? Submit
https://github.com/PenCue/devprocess/issues/3
```

## Create PR

```shell
$ gh pr create --draft
Warning: 1 uncommitted change

Creating draft pull request for 3-gh-cli-documentation-and-screenshots into develop in PenCue/devprocess

? Title 3 gh cli documentation and screenshots
```



```markdown
# PenCue Pull Request

### Scope

minimal. it only affects a single file and maybe some images

### Related Issues

issue 3

### Types of changes

What types of changes are included in this PR?
_Put an `x` in the boxes that apply_

- [ ] Bugfix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [X] Documentation Update (if none of the other choices apply)
- [ ] Includes an Architecture Decision Record(s)
  - [ ] ADRs are team reviewed.

### Checklist

- [X] The PR is as small as it can be. Split if necessary
- [X] Lint and unit tests pass locally
- [X] Added tests that prove my fix is effective or that my feature works
- [X] Added necessary documentation (if appropriate)
- [X] Any dependent changes have been merged and published in downstream modules

### Further comments
No comment
~
```

```shell
$ gh pr create --draft
Warning: 1 uncommitted change

Creating draft pull request for 3-gh-cli-documentation-and-screenshots into develop in PenCue/devprocess

? Title 3 gh cli documentation and screenshots
? Body <Received>
? What's next?  [Use arrows to move, type to filter]
  Submit
  Continue in browser
> Add metadata
  Cancel

```

```shell
$ gh pr create --draft
Warning: 1 uncommitted change

Creating draft pull request for 3-gh-cli-documentation-and-screenshots into develop in PenCue/devprocess

? Title 3 gh cli documentation and screenshots
? Body <Received>
? What's next? Add metadata
? What would you like to add? Projects
? Projects  [Use arrows to move, space to select, type to filter]
> [x]  DevOps Process

```

```shell
$ gh pr create --draft
Warning: 1 uncommitted change

Creating draft pull request for 3-gh-cli-documentation-and-screenshots into develop in PenCue/devprocess

? Title 3 gh cli documentation and screenshots
? Body <Received>
? What's next? Add metadata
? What would you like to add? Projects
? Projects DevOps Process
? What's next? Submit
https://github.com/PenCue/devprocess/pull/4
```

