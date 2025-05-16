FROM jupyter/base-notebook:latest

# Switch to root to install system packages
USER root

# Install any additional system packages if needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install required Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set the working directory
WORKDIR /home/jovyan/work

# Switch back to the jovyan user
USER jovyan

# Expose the port Jupyter runs on
EXPOSE 8888

# Specify the command to run when the container starts
CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--allow-root"]