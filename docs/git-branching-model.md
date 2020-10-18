# PenCue Git Branching Model 

## Requirements and principles

##### Requirements:

1. The main delivery model of is an SAAS service with an API interface. 

   1. no shipping of code

   2. each customer gets its own instance*. 

      1. simplifies data ownership and integration with landscape. 

      [^*]: We still call it SAAS

2. Continuous integration and deployment CI/CD of releases.  

3. Breaking API changes are very rare. 

4. Customers will stay on latest release. 

   * unless there are breaking API changes in which case customer may remain on previous major release while verifying the API changes. 
   * Breaking API changes should be rare after version v1.0.0

5. No code changes in production or integration releases. 

6. No direct commits in any of the main branches

##### Principles

1. there are 3 main branches:

   1. Development (**dev**)
   2. Integration (**int**)
   3. Production (**main**)

2. Features and fixes will only be added to the development branch via Pull Requests (PR)

3. The Integration branch will be updated via PR from **dev** to **int**

4. The Production branch will be updated via PR from **int** to **main**

5. Use Semantic Versioning (https://semver.org/)

   1. Major only updated on breaking API changes. We expect to be on v1 for a long time.
   2. Minor for features/rework/substantial performance upgrades
   3. Patch for bugs/non functionals/minor performance fixes

6. Fix forward

7. These principles are flexible and adjustable after consensus of the team working

    

   

## Overview

![git-branching-model](assets/git-branching-model.svg)

## The Main branches 

#### Development : `dev` Branch

All new features and fixes are merged with the dev branch first via a PR.  The pull request "ready for review" triggers and automatic test suite and code review and requests code and result review by another team member. 

###### Requirements for merging: 

- [ ] Automatic local integration/regression testing 
- [ ] Automatic Code quality (lint, pep etc) 
- [ ] Manual Review of code and test results for completeness and correctness against issue

The scope of the review and code is to the repo itself, integration testing and review of integrated results is done in next step 

**note** that the impact of the feature and fix will require different ways of reviewing the merge request.  See below **TODO review guidelines for patch,rework,feature,performance,and breaking changes**

#### Integration and Testing : `int` Branch

After the feature/fix has been merged into the dev branch (automatically) an Pull Request will be created to trigger the integration testing. After the requirements have been met and reviewed the code can be merged into **int**

###### Requirements for merging:

- [ ] Automatic integration testing with other branches and customer configurations. 
- [ ] Pass vulnerability scan. 
- [ ] Compare results with previous releases. 
- [ ] Performance benchmarks
- [ ] Monitoring completness. 
- [ ] Randomized extra testing (manual testcases/fuzzing/chaosmonkey/pentest/rebuild from scratch)

The scope of integration testing is all representative customer configurations using if permitted customer (anonimized) production data and at as large a scale as feasible (production and larger)

If the PR gets rejected it will be closed and process returns back to **dev** branch.  Any integration issues will be recorded as new issues.  

Note:  cosmetic errors (typos) can be allowed but please record them in an (existing) issue. 

#### Production ready : `main` Branch

When an release is ready for main, the code is production ready.  The focus of the final PR to **main** is external: documentation ready and readable, customer updated, etc. In general the PR should rarely be rejected at this late stage. It may result in new issues for the backlog. 

###### Requirements for merging:

- [ ] Documentation ready/understandable
- [ ] Customer updated/tickets updated. 
- [ ] last sanity check by team outsider. 

When the PR is merged it will trigger deploy to all customer and demo enviroments. 

If the PR is rejected it will be closed and process returns back to **dev**

## The Issue branches 

All development work will be done in issue branches.  The issue branches can be deleted after the code has been merged. 

Each issue branch starts with creating an issue in the repo.  

We use the following issue types:

| issue type                                                   | Purpose                                                      | Version  increment |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------ |
| Fix/Bug<br />![type-fix-label](assets/type-fix-label.png)    | Fix an bug/error which doesn't affect the functionality.     | patch              |
| Rework<br />![type-rework-label](assets/type-rework-label.png) | Fix an bug/error which resulted in functional errors.  for example calculation errors are not as expected. These errors must be treated as special cases since it may require rework at the other side of the API. | minor              |
| Feature<br />![type-feature-label](assets/type-feature-label.png) | Add/update a functional or technical feature. This may include changes to improve integration at the other side of the API. | minor              |
| Performance<br />![type-performance-label](assets/type-performance-label.png) | Changes to the code which improve the performance without functional  changes.  If the functionality changes it is an feature or a breaking change. | minor              |
| Major Change<br />![type-major-change-label](assets/type-major-change-label.png) | Code is an breaking change if it changes the API interface or changes in functionality which require changes to the systems using the API.  <br />Note *that extra functionality is not an breaking change as long as the API and functionality doesn't change for the current systems.* | major              |

Create a branch of **dev** when ready to work on the issue. Use the naming convention from the table below

| issue type  | Branch name                                                  |
| ----------- | ------------------------------------------------------------ |
| fix         | **fix**/{issue#}_{lowercase\_issue\_with\_spaces\_replaced\_by\_underscores}<br />`fix/42_api_slowdown_after_gizmo_introduction_in_32` |
| rework      | **rework**/{issue#}_{lowercase\_issue\_with\_spaces\_replaced\_by\_underscores}<br />`rework/43_gizmo_returns_dunno_instead_of_42_in_some_cases` |
| feature     | **feat**/{issue#}_{lowercase\_issue\_with\_spaces\_replaced\_by\_underscores}<br />`feat/32_adding_new_gizmo` |
| Performance | **perf**/{issue#}_{lowercase\_issue\_with\_spaces\_replaced\_by\_underscores}<br />`perf/53_rewrote_complete_object_def` |
| major       | **major**/{issue#}_{lowercase\_issue\_with\_spaces\_replaced\_by\_underscores}<br />`major/56_api_change_from_rest_to_graphql` |
| hot-fix     | **hot-fix**/{issue#}_{lowercase\_issue\_with\_spaces\_replaced\_by\_underscores}<br />`hot-fix/63_graphsql_gizmo_query_breaks_gizmo_factory` |

#### Version increments (bumps)

We use semver versioning for the API and internal code.   We increment according the followinr rules:

| issue type  | Version increment | before  | after   |
| ----------- | ----------------- | ------- | ------- |
| fix/hot-fix | vX.Y.Z+1          | v2.32.4 | v2.32.5 |
| feature     | vX.Y+1.0          | v2.32.4 | v2.33.0 |
| major       | vX+1.0.0          | v2.32.4 | v3.0.0  |

**Note:** the name of the branch is important since the start of the branch name will trigger the version increments automatically.

**Note**: the version number is set right **after** the merge into ***dev*** by an CI action.  So until the branch is merged it doesn't know its version number. () **TO DO** automatically create  change log with version number after merge.  this may be tricky because dev branch doesn't allow direct commits and a PR would trigger version bump. )

|
|
|

#### Release tagging

Feature branches are not tagged.  All the main branches are tagged using the version number.  The head of each branch has 3 tags:

| Tag    | Purpose                                                      | Changes                       |
| ------ | ------------------------------------------------------------ | ----------------------------- |
| vX.Y.Z | Unique identifier for the version                            | no                            |
| vX.Y   | points to the latest patch release within a feature release.  Mainly here for completeness. the use case is limited. | at every patch within feature |
| vX     | points to the latest feature and patch release within a major release train. | at every patch and feature    |

The version tags have different suffixes based on the branch: 

| branch | tag                    | example          |
| ------ | ---------------------- | ---------------- |
| dev    | unstable               | v2.36.7.unstable |
| int    | rc (release candidate) | v2.36.7.rc       |
| main   | *no tag*               | v2.36.7          |

**Note** codewise there is ***no*** difference between dev, int and main.  The existence of the tag indicates the status of the release. The branches are used to trigger different test suites and deployments. 

### Issue status

| Label                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![status-new-label](assets/status-new-label.png)             | issue is new but not refined or ready to work on.            |
| ![status-refined-label](assets/status-refined-label.png)     | Issue is refined and ready to work on.                       |
| ![status-in-progress-label](assets/status-in-progress-label.png) | Issue is being worked on. branch created and if possible a draft PR |
| ![status-on-hold-label](assets/status-on-hold-label.png)     | Issue has been put on hold due to other priorities.          |
| ![status-ready-label](assets/status-ready-label.png)         | issue is ready for review, PR is set to ready                |
| ![status-wonfix-label](assets/status-wonfix-label.png)       | Issue won't be fixed or implemented and closed               |
| ![status-duplicate-label](assets/status-duplicate-label.png) | issue is a duplicate and closed                              |
| ![status-blocked-label](assets/status-blocked-label.png)     | Issue needs to be worked on but blocked                      |

### Priority definitions





## Development workflow 

#### Open an issue. 

Open an issue in the repository most relevant to the issue; ie in which you expect the bulk of the work to be done.  

Issues should be opened as soon as the issue is raised.  this may be some time before work on it commences.  

The issues can be opened on the command line or via the browser the https://github.com/org/repo/issues/ 

| Field     | Description                                                  | Example                                              |
| --------- | ------------------------------------------------------------ | ---------------------------------------------------- |
| **Title** | A short descriptive title for the issue <br />starting with *feat*/*fix*/*rework* etc<br />It should give your team member an idea <br />the issue is about | `feat/add-gizmo-factory`                             |
| **Body**  | Use the feature or bug template as a guide.  <br />leave the headers and clean up the boilerplate text |                                                      |
| Labels    | *Type*: label with feature/fix etc/ <br />*Status*: status of the issue (see above)<br />Priority: Priority of issue (see above) | ![type-feature-label](assets/type-feature-label.png) |
|           |                                                              |                                                      |

 

On the command line :

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
? What's next? Submit
https://github.com/PenCue/devprocess/issues/3

```

After the issue is opened and a number has been assigned. In this case `3`

#### create feature branch

When starting work on a new feature, branch off from the `develop` branch.

```shell
$ git checkout -b 3-gh-cli-documentation-and-screenshots develop
Switched to a new branch '3-gh-cli-documentation-and-screenshots'
```

### Create a Draft Pull Request 

As early as possible commit the feature branch back to orgin and create a pull request to track progress.   The automated integration tests are run on each update to the branch connected to the PR.  

```shell
$ git add docs/github-cli.md
$ git commit -m "Adding github cli snippets for doc"
[3-gh-cli-documentation-and-screenshots 3f14e9e] Adding github cli snippets for doc
$ git push --set-upstream origin 3-gh-cli-documentation-and-screenshots
 * [new branch]      3-gh-cli-documentation-and-screenshots -> 3-gh-cli-documentation-and-screenshots
Branch '3-gh-cli-documentation-and-screenshots' set up to track remote branch '3-gh-cli-documentation-and-screenshots' from 'origin'.
```

Continue to work on the feature with regular commits to track changes and make sure the automated integration tests are still passing. 

### Incorporating a finished feature on develop 

After the feature is finished, the draft PR is changed to a PR ready for review.  The developer requests one or more team members to review the PR. 

Finished features may be merged into the `develop` branch to definitely add them to the upcoming release:

```
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff myfeature
Updating ea1b82a..05e9557
(Summary of changes)
$ git branch -d myfeature
Deleted branch myfeature (was 05e9557).
$ git push origin develop
```

The `--no-ff` flag causes the merge to always create a new commit object, even if the merge could be performed with a fast-forward. This avoids losing information about the historical existence of a feature branch and groups together all commits that together added the feature. Compare:

![img](https://nvie.com/img/merge-without-ff@2x.png)

In the latter case, it is impossible to see from the Git history which of the commit objects together have implemented a feature—you would have to manually read all the log messages. Reverting a whole feature (i.e. a group of commits), is a true headache in the latter situation, whereas it is easily done if the `--no-ff` flag was used.

Yes, it will create a few more (empty) commit objects, but the gain is much bigger than the cost.

### Release branches 

- May branch off from:

  `develop`

- Must merge back into:

  `develop` and `production`

- Branch naming convention:

  `release-*`

Release branches support preparation of a new production release. They allow for last-minute dotting of i’s and crossing t’s. Furthermore, they allow for minor bug fixes and preparing meta-data for a release (version number, build dates, etc.). By doing all of this work on a release branch, the `develop` branch is cleared to receive features for the next big release.

The key moment to branch off a new release branch from `develop` is when develop (almost) reflects the desired state of the new release. At least all features that are targeted for the release-to-be-built must be merged in to `develop` at this point in time. All features targeted at future releases may not—they must wait until after the release branch is branched off.

It is exactly at the start of a release branch that the upcoming release gets assigned a version number—not any earlier. Up until that moment, the `develop` branch reflected changes for the “next release”, but it is unclear whether that “next release” will eventually become 0.3 or 1.0, until the release branch is started. That decision is made on the start of the release branch and is carried out by the project’s rules on version number bumping.

#### Creating a release branch 

Release branches are created from the `develop` branch. For example, say version 1.1.5 is the current production release and we have a big release coming up. The state of `develop` is ready for the “next release” and we have decided that this will become version 1.2 (rather than 1.1.6 or 2.0). So we branch off and give the release branch a name reflecting the new version number:

```
$ git checkout -b release-1.2 develop
Switched to a new branch "release-1.2"
$ ./bump-version.sh 1.2
Files modified successfully, version bumped to 1.2.
$ git commit -a -m "Bumped version number to 1.2"
[release-1.2 74d9424] Bumped version number to 1.2
1 files changed, 1 insertions(+), 1 deletions(-)
```

After creating a new branch and switching to it, we bump the version number. Here, `bump-version.sh` is a fictional shell script that changes some files in the working copy to reflect the new version. (This can of course be a manual change—the point being that *some* files change.) Then, the bumped version number is committed.

This new branch may exist there for a while, until the release may be rolled out definitely. During that time, bug fixes may be applied in this branch (rather than on the `develop` branch). Adding large new features here is strictly prohibited. They must be merged into `develop`, and therefore, wait for the next big release.

#### Finishing a release branch 

When the state of the release branch is ready to become a real release, some actions need to be carried out. First, the release branch is merged into `production` (since every commit on `production` is a new release *by definition*, remember). Next, that commit on `production` must be tagged for easy future reference to this historical version. Finally, the changes made on the release branch need to be merged back into `develop`, so that future releases also contain these bug fixes.

The first two steps in Git:

```
$ git checkout production
Switched to branch 'production'
$ git merge --no-ff release-1.2
Merge made by recursive.
(Summary of changes)
$ git tag -a 1.2
```

The release is now done, and tagged for future reference.

> **Edit:** You might as well want to use the `-s` or `-u <key>` flags to sign your tag cryptographically.

To keep the changes made in the release branch, we need to merge those back into `develop`, though. In Git:

```
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff release-1.2
Merge made by recursive.
(Summary of changes)
```

This step may well lead to a merge conflict (probably even, since we have changed the version number). If so, fix it and commit.

Now we are really done and the release branch may be removed, since we don’t need it anymore:

```
$ git branch -d release-1.2
Deleted branch release-1.2 (was ff452fe).
```

### Hotfix branches 

![img](https://nvie.com/img/hotfix-branches@2x.png)

- May branch off from:

  `production`

- Must merge back into:

  `develop` and `production`

- Branch naming convention:

  `hotfix-*`

Hotfix branches are very much like release branches in that they are also meant to prepare for a new production release, albeit unplanned. They arise from the necessity to act immediately upon an undesired state of a live production version. When a critical bug in a production version must be resolved immediately, a hotfix branch may be branched off from the corresponding tag on the production branch that marks the production version.

The essence is that work of team members (on the `develop` branch) can continue, while another person is preparing a quick production fix.

#### Creating the hotfix branch 

Hotfix branches are created from the `production` branch. For example, say version 1.2 is the current production release running live and causing troubles due to a severe bug. But changes on `develop` are yet unstable. We may then branch off a hotfix branch and start fixing the problem:

```
$ git checkout -b hotfix-1.2.1 production
Switched to a new branch "hotfix-1.2.1"
$ ./bump-version.sh 1.2.1
Files modified successfully, version bumped to 1.2.1.
$ git commit -a -m "Bumped version number to 1.2.1"
[hotfix-1.2.1 41e61bb] Bumped version number to 1.2.1
1 files changed, 1 insertions(+), 1 deletions(-)
```

Don’t forget to bump the version number after branching off!

Then, fix the bug and commit the fix in one or more separate commits.

```
$ git commit -m "Fixed severe production problem"
[hotfix-1.2.1 abbe5d6] Fixed severe production problem
5 files changed, 32 insertions(+), 17 deletions(-)
```

#### Finishing a hotfix branch 

When finished, the bugfix needs to be merged back into `production`, but also needs to be merged back into `develop`, in order to safeguard that the bugfix is included in the next release as well. This is completely similar to how release branches are finished.

First, update `production` and tag the release.

```
$ git checkout production
Switched to branch 'production'
$ git merge --no-ff hotfix-1.2.1
Merge made by recursive.
(Summary of changes)
$ git tag -a 1.2.1
```

> **Edit:** You might as well want to use the `-s` or `-u <key>` flags to sign your tag cryptographically.

Next, include the bugfix in `develop`, too:

```
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff hotfix-1.2.1
Merge made by recursive.
(Summary of changes)
```

The one exception to the rule here is that, **when a release branch currently exists, the hotfix changes need to be merged into that release branch, instead of `develop`**. Back-merging the bugfix into the release branch will eventually result in the bugfix being merged into `develop` too, when the release branch is finished. (If work in `develop` immediately requires this bugfix and cannot wait for the release branch to be finished, you may safely merge the bugfix into `develop` now already as well.)

Finally, remove the temporary branch:

```
$ git branch -d hotfix-1.2.1
Deleted branch hotfix-1.2.1 (was abbe5d6).
```

## Summary 





Note 

Based on https://nvie.com/posts/a-successful-git-branching-model/ by [Vincent Driessen](https://nvie.com/about/) 

This is derivative work and all copyrights remain owned by the original author. All mistakes and confusion are proudly owned by us. 