#!/usr/bin/env sh

get_status_data() {
    git fetch origin 

    LOCAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)

    LOCAL_REV=$(git rev-parse HEAD)
    REMOTE_REV=$(git rev-parse origin/${LOCAL_BRANCH})

    LOCAL_TAG=$(git tag --points-at HEAD)
    REMOTE_TAG=$(git tag --points-at origin/${LOCAL_BRANCH})
}

check_changes() {
    if [ $LOCAL_REV != $REMOTE_REV ]; then
        echo "Remote repository has new commits"
        make deploy_dev
        return 1
    else
        echo "Remote repository doesn't have new commits"
    fi

    if [ $LOCAL_TAG != $REMOTE_TAG ]; then
        echo "Remote repository has new tag"
        make deploy_stage
        return 1
    else
        echo "Remote repository doesn't have new tag"
        return 1
    fi
}

main() {
  get_status_data
  check_changes
}

main 