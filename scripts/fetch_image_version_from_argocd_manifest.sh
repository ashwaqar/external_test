#!/bin/bash

argocd login argocd-dev.screening.guardanthealth.com --username admin --password ${ARGOCD_CREDENTIALS} --grpc-web

get_image_version(){
    DEPLOYED_VERSION=$(argocd app manifests "${APP_NAME}-${TARGET_ENVIRONMENT}" --grpc-web | grep "image:")
};
if get_image_version; then
    echo "image version fetched is ${DEPLOYED_VERSION}";
    if [ "${CI}" = "true" ]; then
        cf_export DEPLOYED_VERSION="${DEPLOYED_VERSION}"
    else
        export DEPLOYED_VERSION="${DEPLOYED_VERSION}"
    fi
else
    echo "Failed to get image version from argocd manifests";
    exit 1;
fi
exit $?