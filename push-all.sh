#!/bin/bash

usage() {
    echo "Usage: "
    echo "$0 [-v v0.1.0]
    [-h]" 1>&2;
    echo "-s : The name of the microservice"
    echo "-v : The version of the microservice"
    echo "-h : display help"
    exit 1;
}

version=""

while getopts ":v:" option;
do case "${option}" in
    v)
        version=${OPTARG}
        ;;
    \?)
        usage
        ;;
    esac
done

echo "Build and push Docker image of hello-app with version ${version}"
gcloud builds submit --tag europe-west4-docker.pkg.dev/kitae-seo-wiremind-test/hello-repo/hello-app:${version} .

echo "Obtain an access token"
gcloud auth print-access-token | helm registry login -u oauth2accesstoken --password-stdin europe-west4-docker.pkg.dev

echo "Build and push helm chart of hello-app with version ${version}"
sed -i "s/HELLO_TAG/${version}/g" helm/hello-app/Chart.yaml
sed -i "s/HELLO_TAG/${version}/g" helm/hello-app/values.yaml
helm package helm/hello-app
helm push hello-app-helm-${version}.tgz oci://europe-west4-docker.pkg.dev/kitae-seo-wiremind-test/hello-repo