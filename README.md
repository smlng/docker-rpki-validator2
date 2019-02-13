# A small Docker Container for the RIPE RPKI Validator

## Prerequisites

To create and run the docker container you need a host system with
Docker and docker-compose installed. This may need superuser rights
e.g. `sudo`.

## Build Docker Container

Follow these steps to create the container image:

1. Download the latest version (2.xy) of the RPKI-Validator from [RIPE] 
2. Save the source archive in the root folder of this repository, 
   side by side to the `Dockerfile`
3. Build the container with `sudo docker build -t rpki-validator2 .`

The last step should only take a few moments as the container image is
based on Alpine Linux.

Run `sudo docker images` to check that the container image was created
successfully.

## Configure the RPKI-Validator

The RPKI Validator will download (rsync) ROAs from the 5 major RIRs, i.e.
AFRINIC, APNIC, ARIN, LACNIC, and RIPE, also refered to as trust anchors.
For downloading TRUST ANCHOR LOCATOR (TAL) files are required, the RPKI
Validator comes with 4 of them, however the TAL for ARIN is not included.
Thus, download the TAL file from [ARIN] and save it into the `conf/tal`
folder.

Afterwards, check the RPKI validator configuration file, which is found in
`conf/rpki-validator.conf`. This will be mounted into the running container
and can be changed later, too. In case of memory errors increase the values
of `jvm.memory.*` in the conf file and restart the container afterwards.

**Note(1)**: you don't need to change the default ports for RTR (8282) and
web UI (8080), this can be done in the `docker-compose.yml`. To do so, open
the yml file and change the values in section `ports`, the format is 
`HOST_PORT:DOCKER_PORT`. For instance to remap the web UI to `9090` change
`8080:8080` to `9090:8080`.

**Note(2)**: the HTTP port (default 8080) binds to localhost (::1) and is
thus not reachable from the outside by default. It is recommended to use
a HTTP proxy (apache or nginx) because there is no HTTPS support by the
RPKI validator itself.

**Note(3)**: the container is set to restart always, i.e., on any errors or
restart of the host system.  See section `restart` in `docker-compose.yml` 
to change this if needed.

## Run the RPKI-Validator in Docker

Using `docker-compose` this is easy, simply run `sudo docker-compose up -d`.

## Updating and Troubleshooting

If you made changes to the `conf/rpki-validator.conf` file, it is sufficient
to run `sudo docker-compose restart` to apply these changes. Also if you
updated or added TAL files in `conf/tal` this should do.

If you updated the container image, e.g. with a new version of the RPKI
Validator App, or if you changed the `docker-compose.yml` you need to
run `sudo docker-compose up -d` to apply these changes.
If this does not help, run `sudo docker-compose down` before `up`.
  
To just stop the container for a moment and start it again use commands
`sudo docker-compose stop` and `sudo docker-compose start`. This halts and
starts the container without deleting or recreating it.

## Copyright and License

The `startup.sh` script is a modified version of the `docker-startup.sh`
found in https://github.com/RIPE-NCC/rpki-validator/tree/master/rpki-validator-app/docker 
of the [RIPE-NCC GitHub repo](https://github.com/RIPE-NCC/rpki-validator) 

For the ARIN TAL and the RPKI Validator source archive refer to the
respective licenses. For everything else in this repo the MIT License
applies, see LICENSE file for details.

[ARIN]: https://www.arin.net/resources/rpki/tal.html
[RIPE]: https://www.ripe.net/manage-ips-and-asns/resource-management/certification/tools-and-resources
