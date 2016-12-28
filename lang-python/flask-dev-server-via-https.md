# Setting up the Flask development server to use HTTPS

_Tested in an Alpine 3.4 Docker container running Python 3.5.2 and Flask 0.11.1._

Doing this requires two things: using a data volume container to provide the certificate, and using the Flask-Script extension and the Python built-in library "ssl".

## The certificate

I put the CA signed server certificate and the server certificate private key in a data volume container. The container holds these two files:

* `/tsl/cert.pem`
* `/tls/certkey.pem`

I gave the container the name "dv-cert-flask-example-dev". The certificate is for the domain "flask.example.com". The certificate is chained with the CA cert, as per [this TIL](../tls/create-server-cert-using-local-ca-cert.md).

## Flask dev server

I've installed the Flask-Script extension. In my `manage.py` source file I create a Flask `Server` with an SSL context. That's done like this:

```python
context = ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)
context.load_cert_chain('/tls/cert.pem', keyfile='/tls/certkey.pem')
app = create_app(os.getenv('FLASK_CONFIG') or 'default')
manager = Manager(app)

# override the default "runserver" command
manager.add_command("runserver", Server(ssl_context=context))
```

## Launching the app using the Flask server in a Docker container

The command to run the container looks like this:

```bash
docker run -d  \
  --name example \
  --volumes-from flask-example-dv \
  --volumes-from dv-cert-flask-example-dev \
  --workdir /src \
  --expose=443 \
  -p 443:443 \
  --env-file "${HOME}/.secrets/flaskwebdev.list" \
  datihein/flask-aaj-tls:1.0.0 \
  /src/doit.sh
```

Note that we are exposing port 443 (could be a different port, but I picked the standard HTTPS port) and mapping the container port 443 to the Docker host machine's port 443. That will let the browser on my Mac system connect with 443 in the container by routing through port 443 on Linux VM that is hosting the Docker containers.

The `flask-example-dv` data volume container holds the application source code (in the path `/src`), and the `dv-cert-flask-example-dev` data volume container holds the cert and private key (in the path `/tls`) to be used for the HTTPS endpoints.

The environment file holds some secrets to be shared with the container via environment variables.

And finally, the script `/src/doit.sh` contains the command that launches the Flask development server. The script looks something like this:

```bash
#! /bin/ash
#
python3 manage.py runserver --host 0.0.0.0 --port 443 --debug --reload
```

## Comments

I don't need to put the CA cert in the trusted store on the container because the Flask app is a server, and is providing the cert. If it was a client that needed to validate the cert, then I'd have to add the root CA cert to the container's trusted store.
