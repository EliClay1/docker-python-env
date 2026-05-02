# Jupyter Docker Environment
Simple containerized setup for running Jupyter with a clean Everforest theme and persistent data. This is meant to be quick to spin up and not get in your way.

## What this does
Runs a Jupyter Notebook server in Docker
Applies Everforest styling for a softer, easier-on-the-eyes UI
Persists notebooks and data across container restarts
Keeps dependencies isolated so your host stays clean

## Quick Start
```
docker compose up -d
```
go to http://localhost:8888.

## Getting started
Build the image
```
docker build -t jupyter-everforest .
```
Run the container
```
docker run -p 8888:8888 -v $(pwd)/data:/home/jovyan/work jupyter-everforest
```
Open the link shown in the logs and you are in.

## Data persistence
Everything in /home/jovyan/work is mounted to your local ./data folder. Your notebooks, datasets, and outputs will still be there even if you stop or remove the container.

## Styling
Everforest theme is preconfigured. If you want to tweak it, update the theme config in the image or override it with your own dotfiles.

## Notes
- Default token auth is enabled out of the box
- Add your own requirements in the Dockerfile if needed
- If ports clash just change the left side of the port mapping

That is it. Run it, write code, and move on.