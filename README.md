# speedtest2mqtt

An experiment to publish speedtest results to MQTT.

[![Software
License](https://img.shields.io/badge/License-MIT-orange.svg?style=flat-square)](https://github.com/mannkind/speedtest2mqtt/blob/master/LICENSE.md)

## Installation

### Via Docker

```bash
docker run -d --name="speedtest2mqtt" -v /etc/localtime:/etc/localtime:ro mannkind/speedtest2mqtt
```

### Via Bash

Please note: you have have `mosquitto_pub`, `jq`, and `speedtest-cli` available.

```bash
git clone https://github.com/mannkind/speedtest2mqtt
cd speedtest2mqtt
./speedtest2mqtt
```

## Configuration

Configuration happens via environmental variables

```bash
SPEEDTEST_SERVER         - [OPTIONAL] The speedtest server to use, defaults to ""
SPEEDTEST_LOOKUPINTERVAL - [OPTIONAL] The interval in seconds to speedtest, defaults to "21600" (6 hours)
MQTT_TOPICPREFIX         - [OPTIONAL] The MQTT topic on which to publish the collection lookup results, defaults to "home/speedtest"
MQTT_DISCOVERY           - [OPTIONAL] The MQTT discovery flag for Home Assistant, defaults to false
MQTT_DISCOVERYPREFIX     - [OPTIONAL] The MQTT discovery prefix for Home Assistant, defaults to "homeassistant"
MQTT_DISCOVERYNAME       - [OPTIONAL] The MQTT discovery name for Home Assistant, defaults to "speedtest"
MQTT_CLIENTID            - [OPTIONAL] The clientId, defaults to "DefaultSpeetest2MqttClientID"
MQTT_BROKER              - [OPTIONAL] The MQTT broker, defaults to "test.mosquitto.org"
MQTT_USERNAME            - [OPTIONAL] The MQTT username, default to ""
MQTT_PASSWORD            - [OPTIONAL] The MQTT password, default to ""
```
