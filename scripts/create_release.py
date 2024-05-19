import subprocess


def run_command(command):
    return subprocess.check_output(command, shell=True, text=True).strip()


def get_last_tag():
    try:
        return run_command("git describe --abbrev=0 --tags")
    except subprocess.CalledProcessError:
        return None


def get_commit_messages(tag):
    if tag:
        return run_command(f"git log {tag}..HEAD --oneline --pretty=format:'%s'")
    else:
        return run_command("git log --oneline --pretty=format:'%s'")


def generate_changelog(tag, commit_messages):
    changelog_file = "./CHANGELOG.md"
    with open(changelog_file, 'a') as file:
        file.write(f"# {tag}\n\n")
        for message in commit_messages.split('\n'):
            file.write(f"- {message}\n")
        file.write("\n")
    print(f"Changelog updated in {changelog_file}")


def get_current_commit_hash():
    return run_command("git rev-parse HEAD")


def create_new_tag(tag):
    if tag:
        new_tag = tag.split('.')
        new_tag[-1] = str(int(new_tag[-1]) + 1)
        return '.'.join(new_tag)
    else:
        return "v0.1.0"


def tag_current_commit(tag):
    commit_hash = get_current_commit_hash()
    run_command(f'git tag -a {tag} {commit_hash} -m "Tag {tag}"')


def auto_generate_changelog(commit_messages):
    pass


def main():
    last_tag = get_last_tag()

    if last_tag:
        commit_messages = get_commit_messages(last_tag)
        print(f"Commit messages since last tag ({last_tag}):")
    else:
        commit_messages = get_commit_messages(None)
        print("No tags found. Commit messages since the beginning:")

    print(commit_messages)

    new_tag = create_new_tag(last_tag)
    # tag_current_commit(new_tag)

    print(f"\nNew tag created: {new_tag}")

    generate_changelog(new_tag, commit_messages)


if __name__ == "__main__":
    main()
