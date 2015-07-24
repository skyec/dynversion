# Dynamically load different versions of a single page app

Goal: be able to ship multiple versions of a SPA to something like S3/CF and
have the application bootstrapping figure out which version to load (and fallback
to a default version if no version set).

## Layout

```
index.html
require.js
app/
  main.js  # This is the unminified, development version of the main app and
           # contains the app's entry point.
  thing.js # This gets bundled up by the minifier.
v/ # this is where versioned build output goes
  1/
    main.min.js # Version one of the app.
  2/
    main.min.js # Version two of the app.
```

## Dynamic loading

In `index.html` there is a small `script` in the `head` that checks for a cookie
(or a query parameter) called `appversion` that will contain the version number
to load. If the cookie is missing then the app falls back to the `app` directory
and assumes it's in dev mode.  The `app` director is never shipped as part of a
production build so will `404` if this ever happens in prod so make sure that
you have a way to set the cookie.

## Try it out

Install a nodejs based web server and the minifier.
```
make deps
```

Build a version (builds version 1 by default).
```
make build
```

Start the server and try it in your browser.
```
make start

# browse to: http://localhost:8080 to load the dev code
# browse to: http://localhost:8080 to load the minified code
```

Make a change to one of the files e.g. replace the surfing quote with one of your
own then rebuild the project, specifying a new version number.
```
make build APP_VERSION=2

# browse to:
# dev code: http://localhost:8080 
# v1 code: http://localhost:8080?appversion=1
# v2 code: http://localhost:8080?appversion=2
```

