# Integrating ONOS with Kathará

This tutorial explains how to build and run a standalone Docker image integrating Kathará and ONOS.

## Get it from Docker Hub

```bash
docker pull chafiullah/kathara-onos-classic
```

You can run the container in interactive mode:

- Exposing both the Web UI (`8181`) and SSH CLI (`8101`):

  ```bash
  docker run -it --rm -p 8181:8181 -p 8101:8101 --name kathara-onos-test chafiullah/kathara-onos-classic /bin/bash
  ```

- Or exposing only the Web UI (`8181`) if you plan to access the ONOS CLI directly from inside the container:

  ```bash
  docker run -it --rm -p 8181:8181 --name kathara-onos-test chafiullah/kathara-onos-classic /bin/bash
  ```

## Build the Docker Image

Run the following command to build the image from scratch:

```bash
# get the onos-classic
git clone https://github.com/ONOS-resurrection-project/onos-classic.git

# navigate to onos-classic/docs directory
cd onos-classic/docs/

# clone this repository
git clone https://github.com/ONOS-resurrection-project/katharaXonos.git

# from the katharaXonos directory:
cd katharaXonos/
docker build -t kathara/onos-classic . --no-cache
```

Once the image build completes, verify the environment using the following steps:

### 1. Launch Container Shell and Verify Connectivity

You can run the container in interactive mode:

- Exposing both the Web UI (`8181`) and SSH CLI (`8101`):

  ```bash
  docker run -it --rm -p 8181:8181 -p 8101:8101 --name kathara-onos-test kathara/onos-classic /bin/bash
  ```

- Or exposing only the Web UI (`8181`) if you plan to access the ONOS CLI directly from inside the container:

  ```bash
  docker run -it --rm -p 8181:8181 --name kathara-onos-test kathara/onos-classic /bin/bash
  ```

- Test outbound network connectivity from within the container:

  ```bash
  ping -c 3 google.com
  ```

### 2. Verify Kathará Base Networking Tools

From inside the container shell, verify that standard networking and diagnostic tools inherited from `kathara/core` are present:

```bash
# Check networking utilities
ip a
iptables --version
tcpdump --version
ping -V
```

### 3. Verify Python, NetworkX, and Java Environments

Check the runtime dependencies required by Bazel and ONOS:

```bash
# Verify Java (Temurin / OpenJDK 11)
java -version

# Verify Python 2 (required by Bazel ONOS toolchains)
python2 -V

# Verify Python 3 and NetworkX
python3 -V
python3 -c "import networkx as nx; print(f'NetworkX version: {nx.__version__}')"
```

### 4. Verify Bazel and ONOS Installation

Confirm the build tools and repository paths:

```bash
# Verify Bazel version
bazel version

# Verify ONOS source folder
ls -la $ONOS_ROOT
```

### 5. Start and Test ONOS

- Run the preconfigured helper script to start the ONOS controller:

  ```bash
  start-onos
  ```

- Once ONOS has booted up, test accessing the ONOS CLI from inside the container:

  ```bash
  source $ONOS_ROOT/tools/dev/bash_profile
  onos onos@localhost
  ```

  _(Default credentials: username `onos`, password `rocks`)_

### 6. Access the Web GUI

Open your web browser and navigate to:

- **URL**: [http://localhost:8181/onos/ui](http://localhost:8181/onos/ui)
- **Username**: `onos` or `karaf`
- **Password**: `rocks` or `karaf`

### 7. Lab Example

Please follow this [lab-tutorial](./labs/ovs/README.md) for the LAB.

---
