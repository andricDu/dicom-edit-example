# dicom-edit-example

![GitHub](https://img.shields.io/github/license/andricdu/dicom-edit-example?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/dandric/dicom-edit-example/latest?style=for-the-badge)
[![Image Size](https://img.shields.io/docker/image-size/dandric/dicom-edit-example/latest?style=for-the-badge)](https://hub.docker.com/layers/195659429/dandric/dicom-edit-example/latest/images/sha256-3181e0a87cbdb43f28af7202619b43bb355cb1357e110bdd7655354a5fa128ad?context=repo)


Example pipeline of pseudonymising a dicom file by rewriting some of the header information. 

A public docker image for this pipeline is hosted here: https://hub.docker.com/repository/docker/dandric/dicom-edit-example

If `dandric/dicom-edit-example:latest` is no longer available, it is likely it has been deleted by dockerhub for inactivity. 

## Dicom Edit Pipeline

### Build
```bash
docker build .
```

### Run

#### Shell

To run the shell script. You will need to configure the appropriate env vars before running:

```bash
export FILENAME=<filename>
export PASS=<sftp_pass>
export SFTP_URI=<sftp_uri>
export SFTP_PORT=<sftp_port>

chmod +x run_edit.sh # make sure you can execute the script

./run_edit.sh
```


#### Docker
Pass appropriate env vars to docker run command. 
```bash
docker run \
-e FILENAME=<filename> \
-e PASS=<sftp_pass> \
-e SFTP_URI=<sftp_uri> \
-e SFTP_PORT=<sftp_port> \
dandric/dicom-edit-example:latest
```

### Kubernetes
Env vars should be set inside the kubernetes manifest for the job. 
```
kubectl apply -n <your_namespace> -f dicom_edit.yaml
```

## Running SFTP in Kubernetes

For running sftp in Kubernetes, I made use of the following helm chart: https://github.com/openvnf/sftp-server

```
git clone https://github.com/openvnf/sftp-server.git
cd sftp-server
helm install sftp .
```