#!/bin/bash

battery=$(acpi | grep -oP '\d+(?=%)')

echo "${battery}%"
