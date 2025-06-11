# InfraSonar Files Agent

A simple agent to monitor properties of some files.

This collector has a single check: `files` and two types: `files` and `agent`.


## Type: files

This type is **required** and may have multiple items.

Metric    | Type    | Required | Description
--------- | ------- | -------- | -----------
name      | string  | yes      | Name of the file.
size      | integer | yes      | Size of the file in bytes.
created   | integer | yes      | Creation time of the file as unix timestamp in seconds.
access    | integer | yes      | Last access time of the file as unix timestamp in seconds.
modified  | integer | yes      | Last modified time of the file as unix timestamp in seconds.

## Type agent

This type is **optional** and is given, it must have exactly one item.

Metric    | Type    | Required | Description
--------- | ------- | -------- | -----------
name      | string  | yes      | Name of the agent. (`files`)
info      | string  | no       | Free format info.
version   | string  | no       | Version of the agent/script.
