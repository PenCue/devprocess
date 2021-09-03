from github import Github
import os
import re
import github

from argparse import ArgumentParser, FileType

p = ArgumentParser(description="repo manager")
p.add_argument("-o", "--org", type=str, default="PenCue")
p.add_argument("-n", "--nop", type=bool, default=False)
p.add_argument("repo", type=str, nargs='+')
args = p.parse_args()

token = os.environ["GITHUB_ACCESSTOKEN"]
g = Github(token) # Your personal token

org = g.get_organization(args.org)

main_branches = ["dev", "int", "main"]

for repo_name in args.repo:    
    try:
        repo = org.get_repo(repo_name)
    except github.GithubException:
        print(f"repo {repo_name} doesn't exist in {org.name}")
        continue

    print(f"processing {repo_name}")
    if not args.nop:
        repo.edit(
            allow_merge_commit=True,
            allow_rebase_merge=False,
            allow_squash_merge=False,
            delete_branch_on_merge=True
        )

    for branch_name in main_branches:
        try:
            branch = repo.get_branch(branch_name)
            print(f"repo {repo.name} has branch {branch_name}")
        except github.GithubException:
            print(f"repo {repo.name} has no branch {branch_name}")
            continue

        try:
            protection = branch.get_protection()
        except github.GithubException:
            print(f"repo {repo.name} has no protection for {branch_name}")

        if not args.nop:
            branch.edit_protection(dismiss_stale_reviews=True,
                                    required_approving_review_count=1,
                                    enforce_admins=True)

        try:
            protection = branch.get_protection()
        except github.GithubException:
            print(f"repo {repo.name} has no protection for {branch_name}")
            continue

        if protection.required_pull_request_reviews is not None:
            print(f'\treviewers required {protection.required_pull_request_reviews.required_approving_review_count}')
