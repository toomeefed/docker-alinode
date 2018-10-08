docker images --format "{{.Repository}}:{{.Tag}}" toomee/alinode | xargs -L1 docker push
