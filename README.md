# Introduction
This application is a simple web application that says "Hello World" with a given name. It's developped for Wiremind interview.

# Parameters
`firstname` and `lastname` are the parameters that will be used to greet the user. They are passed as query parameters in the URL.
For example, if you want to greet John Doe, you can use the following URL:
```
http://localhost:8080/hello?firstname=John&lastname=Doe
```

# Docker Image and helm Chart registration
The script `push-app.sh` is used to push Docker image and helm chart to the GKE registry. The tag should be given. with the `-t` flag.
