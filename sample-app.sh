#!/bin/bash
set -euo pipefail

# Clean up old artifacts safely
rm -rf tempdir
mkdir -p tempdir/templates tempdir/static

# Copy app source
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Create Dockerfile
cat > tempdir/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

# Build and run container
cd tempdir
docker stop samplerunning 2>/dev/null || true
docker rm samplerunning 2>/dev/null || true
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a
