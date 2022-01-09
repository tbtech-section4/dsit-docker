# DSIT Docker

Provides a Notebook environment for DSIT on Docker (include CUDA environment)  
Some google colab specific features cannot be used.

## Based Docker image

- TensorFlow Jupyter  
    <https://hub.docker.com/r/tensorflow/tensorflow/tags?page=1&name=jupyter>

## Added Modules

### Python Modules

- pandas
- seaborn
- scikit-learn
- graphviz
- xgboost
- lightgbm
- imblearn
- pydot
- opencv-python
- tqdm
- imageio
- scikit-image
- statsmodels
- jupyterlab
- jupyterlab-language-pack-ja-JP

### Jupyter Extensions

- @lckr/jupyterlab_variableinspector
- @jupyterlab/git

## How to use

1. Set the version of TensorFlow you want to use to `$TF_PACKAGE_VERSION`  
If `$TF_PACKAGE_VERSION` is blank, it will be 'latest'.  
ex.)  
    `2.5.0` (<- TensorFlow 2.5.0)  
    `2.7.0-gpu` (<- TensorFlow 2.7.0 and CUDA)  
    `latest` (<- latest version (default))  
    `latest-gpu`(<- latest version and CUDA)  

1. Build image and run container, then jupyter lab server will start.  

1. Access the following URL with a web browser.  
   <http://localhost:8888/lab?token=dsit>

### Build image example

```bash
$TF_PACKAGE_VERSION="2.7.0-gpu"
# build image
docker build -t tbtech/dsit:${TF_PACKAGE_VERSION} --build-arg TF_PACKAGE_VERSION=${TF_PACKAGE_VERSION} ./

# run container
docker run --rm -it --gpus all -p 8888:8888 -v ${PWD}/Notebook:/tf/Notebook -t tbtech/dsit:${TF_PACKAGE_VERSION}
```
