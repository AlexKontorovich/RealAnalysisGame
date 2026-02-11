# Real Analysis, The Game

This is a game for [lean4game](https://github.com/leanprover-community/lean4game/).

The documentation about how to use this are at the [lean4game repository](https://github.com/leanprover-community/lean4game/):

* [Creating a new game](https://github.com/leanprover-community/lean4game/blob/main/doc/create_game.md)
  * [Updating an existing game](https://github.com/leanprover-community/lean4game/blob/main/doc/update_game.md)
  * [Running a game locally](https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md)

## Docker

### Running with Docker

You can run this game using Docker without installing Lean locally.

#### Pull and run from Docker Hub:

```bash
docker pull ovotim/real-analysis-game:latest
docker run -it --rm ovotim/real-analysis-game:latest
```

#### Building locally:

```bash
# Build the image
docker build -t real-analysis-game .

# Run the container
docker run -it --rm real-analysis-game
```

The Docker image is automatically built and published to [ovotim/real-analysis-game](https://hub.docker.com/r/ovotim/real-analysis-game) on every push to the main branch.
