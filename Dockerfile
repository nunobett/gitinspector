# Simple dockerfile for gitinspector
# Usage:
# To build the image, execute the following command in the repository of gitinspector. 
# docker build -t gitinspector . 
#
# Run the following commands in the repository you want to analyze:
# docker run --rm -it -v $(pwd):/repo gitinspector -f cs,fs -m -r -T -w /repo -F json > myresults.json
# docker run --rm -it gitinspector --help 
# docker run --rm -it -v $(pwd):/repo gitinspector --file-types=md,java,properties,svg,puml,jpeg,jpg,png,vpp,js,xml,jsx,json --grading -x email:"^(?!([1]))" --format=html > ../git-reports/$folder-gitinspect-all-time.html

FROM python:2-alpine3.7

ENV PYTHONIOENCODING=utf-8

RUN apk add --no-cache git \
 && apk add --no-cache tree

ADD gitinspector/ /tmp/gitinspector/gitinspector/
ADD DESCRIPTION.txt /tmp/gitinspector/
ADD setup.py /tmp/gitinspector/

WORKDIR /tmp/gitinspector
RUN python setup.py install

WORKDIR /
RUN rm -r /tmp/gitinspector

WORKDIR /repo

ENTRYPOINT ["gitinspector"]