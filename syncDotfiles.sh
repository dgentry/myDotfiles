#!/bin/bash

ssh -A gentry@tiny.zapto.org 'cd myDotfiles && git sync'
ssh -A movies.local 'cd myDotfiles && git sync'
