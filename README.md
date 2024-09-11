# devops-pipeline-tools
Some helpful pipeline tools

# Installed Tools
* python3
 * awscli
 * stacker
 * yamllint
 * cfn-int
 * cfn-flip
 * requests
* jq
* bash
* git
* gettext (envsubt)
* schedule-pipelines

# Schedule Pipelines

`schedule-pipelines` is a python script to schedule a GoCD Pipeline.

This can be added as a final stage of a pipeline to invoke another pipeline.

eg:
* build-ami pipeline finishes building and deploying an AMI
  * final stage is to schedule the deploy-cfn pipeline
* deploy-cfn pipeline applies the new AMI to existing ASGs

## Usage

The `schedule-pipelines` is configured by ENV VARs:

`docker compose run --rm tools schedule-pipelines` , assuming that this image is configured as the `tools` service in docker compose.

Environment Variables:
|KEY|NOTES|
|---|---|
|GOCD_USER|The user who has API priveledges on GOCD|
|SCHEDULE_PIPELINES|A comma separated list of GoCD Pipelines to schedule|

GoCD Secure Variables:
|KEY|NOTES|
|---|---|
|GOCD_PASSWORD_ENC|Encrypted password for the GOCD_USER|