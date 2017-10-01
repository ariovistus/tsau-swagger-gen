param([string] $url)
docker run -v "$(pwd)\output:/output" -e "URL=$url" ariovistus/tsau-swagger-gen
