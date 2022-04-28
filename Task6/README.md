# Task 6. CI/CD


Before this, I didn't have any experience about the skills required for this task, but I found some similarities between `Github Action` and `GitLab CD/CD`, I have a little experience with `GitLab CD/CD`,so I tried to do it.

## Description
ci.yaml:
- unit tests suite for the API from Task 4 on Pull Requests,
- Build docker image and push it to Aliyun image hub on Pull Request merge.

cd.yaml；
- Deploy to Aliyun ECS.

## Prerequisites

1. Create an Alibaba Cloud Container Registry: [Container Registry](https://cr.console.aliyun.com/cn-shanghai/instances)
2.Creating encrypted secrets for a repository :[encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
Secrets should contain the following values：
```
DOCKER_REPOSITORY: // The public address of the Alibaba Cloud Container Registry repository.
DOCKER_USERNAME： // Alibaba Cloud account
DOCKER_PASSWORD：// The password set in the previous step
HOST：// Server ip
HOST_PORT：// Server ssh port (default is 22)
HOST_USERNAME：//  User of the server (Requires joining the docker group)
HOST_PASSWORD： // Host password
```
## Quickstart
1. Create a `.github/workflows` directory in your repository on GitHub if this directory does not already exist.


2. Creating your [workflow](https://docs.github.com/en/actions/quickstart)
Copy the ci.yaml and cd.yaml to `.github/workflows/`.

3. Test :
- When create a `pull request` ,the github action will trigger the ci task.
- When `push` some commits ,the github action will trigger the cd task.



More : [GitHub Action](https://docs.github.com/en/actions)


