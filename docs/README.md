## Production Improvements
### Web server
The container uses the flask development webserver, which is not intended for production use. This
would be improved by using 

### Terraform state
Provisioning remote state was out of scope for this project. In production, it would be best to
securely manage state remotely so that more people can access it.

### TDD FTW

Testing was out of scope for this project. For production use, it would be best to follow the Test
Driven Development methodology by writing tests first.

### Security

For production purposes, security should always be the first consideration. As this will not be
put to production use, code and container security scanning has been omitted. This should be
implemented before moving into production.

### Pinning

For production use, all dependencies should be pinned to specific versions to ensure repeatability.
Here, we are using "latest" for simplicity.

### Environments

This has focused on deploying to a "prod" environment. In a real production environment, it is often
good practice to have one or more testing environments. These can be deployed to either by separate
code, or by a matrix deployment.

### Portability

While ECS provides ease of use, Kubernetes provides portability. As a provider migration was out of
scope for this project, ECS was selected, however if vendor lock-in were a concern in a production
environment, then Kubernetes would be worth considering.