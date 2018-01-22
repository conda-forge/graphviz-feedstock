FROM conda/c3i-linux-64

RUN /opt/conda/bin/conda install -yq conda conda-build

COPY ./recipe/ /recipe/

RUN /opt/conda/bin/conda build /recipe
