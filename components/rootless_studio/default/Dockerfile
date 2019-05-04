ARG PACKAGE_TARGET
FROM biome-${PACKAGE_TARGET}:bio-base as bio
ENV PATH=${PATH}:/bio/bin
ARG BLDR_CHANNEL=stable
RUN bio pkg install -c ${BLDR_CHANNEL} biome/bio-backline \
  && bio pkg binlink core/bash -d /bio/bin \
  && bio pkg binlink biome/bio -d /bio/bin

FROM scratch
COPY --from=bio /bio /bio
COPY --from=bio /bio/bin /bin
COPY --from=bio /bin/bio /bin/
COPY ./etc/ /etc/
ADD ./entrypoint.sh /
ADD ./profile /etc/
ADD ./profile.enter /etc/
ADD ./build /bin/
ENTRYPOINT ["/entrypoint.sh"]
CMD ["enter"]
WORKDIR /src
