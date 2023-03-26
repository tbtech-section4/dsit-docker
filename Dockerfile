ARG TF_PACKAGE_VERSION=latest

# Base Image
FROM tensorflow/tensorflow:${TF_PACKAGE_VERSION}-jupyter

# Install modules
RUN apt-get update
RUN apt-get install -y --no-install-recommends wget graphviz

# Install modules for OpenCV
RUN apt-get install -y --no-install-recommends libgl1-mesa-dev
# RUN apt-get install -y libglib2.0-0 libsm6 libxrender1 libxext6

# Install modules for Object Detection API
RUN apt-get install -y --no-install-recommends protobuf-compiler

# Install nodejs
# RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
#     && apt-get install -y nodejs

# Clenup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python modules
# RUN python3 -m pip install --no-cache-dir git+https://github.com/googlecolab/colabtools.git psutil --use-feature=2020-resolver
RUN python3 -m pip install --no-cache-dir pandas seaborn scikit-learn graphviz xgboost lightgbm imblearn pydot opencv-python tqdm imageio scikit-image statsmodels
RUN python3 -m pip install --no-cache-dir jupyterlab jupyterlab-git jupyterlab-language-pack-ja-JP
RUN python3 -m pip install --no-cache-dir nbformat -U
# RUN python3 -m pip install --no-cache-dir --upgrade ipython jupyter jupyterlab

# # Install JupyterLab Extension
RUN python3 -m pip install --no-cache-dir lckr-jupyterlab-variableinspector
# RUN jupyter labextension install @lckr/jupyterlab_variableinspector@3.0.7
# RUN jupyter labextension enable jupyterlab_variableinspector
# RUN jupyter lab build

# configure jupyter
RUN jupyter notebook --generate-config && ipython profile create
RUN echo "c.InteractiveShellApp.matplotlib = 'inline'" >> /root/.ipython/profile_default/ipython_config.py

# execute jupyter lab
CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter lab --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.allow_origin='*' --NotebookApp.token='dsit'"]
