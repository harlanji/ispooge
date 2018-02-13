The site is in the apps directory. Based on cryogen.

Built with `./scripts/build.sh`, started with `./scripts/start.sh` and will stay running after reboot... stopped with `./scripts/stop.sh`.

The running service will rebuild changes, although it takes about 2 minutes on the RasPi and makes content unavailabile.

In order to address this, we can create a snapshot with `./scripts/build-static.sh` and run that using `./scripts/start-static.sh` (heh) and `./scripts/stop-static.sh`.

The static service uses the same Python module that we use for the v1 service.
