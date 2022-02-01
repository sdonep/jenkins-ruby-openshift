FROM registry.redhat.io/openshift4/ose-jenkins-agent-base as base

ENV APP_ROOT=/usr/src/app \
    PYTHON_PKG=python38 \
    PYTHON_VERSION=3.8 \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    LANG=en_US.UTF-8 \
    PIP_NO_CACHE_DIR=off \
    PIPENV_VENV_IN_PROJECT=1 \
    PATH=${APP_ROOT}/.venv/bin:$PATH

# pipenv complains if you don't install which
RUN dnf install -y which ${PYTHON_PKG}{,-devel,-setuptools,-pip}
RUN dnf install -y ruby

WORKDIR ${APP_ROOT}

# use pipenv to create venv in APP_ROOT
RUN pip${PYTHON_VERSION} install pipenv && \
    pipenv --python ${PYTHON_VERSION} && \
    chown -R 1001:0 .

USER 1001

COPY ["Pipfile", "Pipfile.lock", "./"]
RUN pipenv install --deploy
